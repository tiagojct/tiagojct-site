---
title: Soundings
subtitle: A personal music listening dashboard built from Last.fm data
author:
  name: Tiago Jacinto
date: '2026-05-07'
description: Soundings reads my Last.fm scrobble history and turns it into top lists, listening patterns, and a discovery view. A GitHub Action pulls fresh data daily; the browser renders everything client-side
  from a static JSON file.
lang: en
draft: false
---

Soundings is a static page that reads my [Last.fm](https://www.last.fm/user/tiagojct) scrobble history and turns it into top lists, listening patterns, and a discovery view. The name is a Moby-Dick reference: sailors take soundings to measure the depth of the water beneath the ship, and this project takes soundings of my listening history.

## Links

- Live dashboard: [tiagojct.eu/soundings/](https://tiagojct.eu/soundings/)
- GitHub: [github.com/tiagojct/soundings](https://github.com/tiagojct/soundings)
- Last.fm profile: [last.fm/user/tiagojct](https://www.last.fm/user/tiagojct)

## What it shows

**Top lists** — top artists, albums, and tracks across five time windows: last 7 days, 30 days, 90 days, 365 days, and all-time. Each list shows the top 10 with a secondary view of ranks 11–25.

**Listening patterns** — a calendar heatmap of daily scrobbles, streak tracking, an hourly breakdown across the day, a weekday breakdown, and monthly scrobble counts over time.

**Distribution** — play concentration (how many artists account for what share of total listening) and a weekly top-5 view showing how the dominant artists shift across the year.

**Discovery** — artists and tracks that appear for the first time in a given month. "New" means new in my Last.fm history, not necessarily new to me: anyone I was already listening to before scrobbling began will show as new in the earliest month of the archive.

## How it works

A scheduled GitHub Action runs daily at 03:00 UTC. It calls the Last.fm API, appends new scrobbles to a gzipped JSONL archive stored in the repository, and computes aggregates into a `stats.json` file. The page reads that file at load time and renders everything client-side. The browser never calls Last.fm directly.

The data pipeline is written in Python. The frontend is plain JavaScript with no framework dependency.

## Running your own copy

The repository is MIT-licensed. Fork it, add a `LASTFM_API_KEY` secret and a `LASTFM_USER` variable in the repository settings, set GitHub Pages to serve from the `main` branch at `/docs`, and trigger the update workflow once to pull the full history. After that it runs unattended.

Full setup instructions are in the [README](https://github.com/tiagojct/soundings#readme).
