---
title: "Uses"
description: "The tools, software, and hardware behind Tiago Jacinto's daily research, writing, and teaching workflow."
date-modified: "2026-04-20"
---

This is a running note about the tools I actually use, not an attempt at optimization theatre. Inspired by [uses.tech](https://uses.tech).

## The short version

If I had to summarise my setup in one sentence: I write in plain text where I can, manage references in [Zotero](https://www.zotero.org) (my [note](/notes/zotero/)), do most coding in [Positron](https://github.com/posit-dev/positron) and [Visual Studio Code](https://code.visualstudio.com), and keep everything tied together with a terminal, automation, and a slightly obsessive collection of small macOS utilities.

## Writing and thinking

For long-form notes and idea development, I use [Obsidian](https://obsidian.md). It is local-first, it stays out of my way, and it scales from a single rough note to years of linked material. For academic writing, especially anything that benefits from Markdown and Pandoc, I use [Zettlr](https://zettlr.com) ([note](/notes/zettlr/), and the companion [Zettlr + Zotero workflow](/notes/zettlr-zotero/)). It works well with my citation workflow and keeps manuscripts portable. When I just need to open and edit a text file quickly, [MarkEdit](https://github.com/MarkEdit-app/MarkEdit) is usually enough.

I keep a personal journal in [Everlog](https://everlog.app), mostly to slow down and think clearly before committing to a decision.

## Coding, analysis, and the terminal

My default environment is [Positron](https://github.com/posit-dev/positron), mostly because it feels natural for mixed R/Python work. [RStudio](https://posit.co/products/open-source/rstudio/) is still part of the toolkit, especially when teaching; the conventions I rely on are in my [RStudio best-practices note](/notes/rst-bp/). [Visual Studio Code](https://code.visualstudio.com) remains the general-purpose fallback for everything else, and [Zed](https://zed.dev) is what I open when I want speed and no overhead.

The terminal matters a lot in my workflow, so I use [iTerm2](https://iterm2.com) daily with zsh as the shell. The [terminal note](/notes/terminal/) captures the habits that matter day to day.

For version control I live in [Git](/notes/git/) and [GitHub](/notes/github/): locally for every analysis project and every manuscript, remotely for anything I want to share, back up, or collaborate on.

## References and reading

[Zotero](https://www.zotero.org) is the centre of my reference management ([note](/notes/zotero/)). I rely on it for everything from course prep to manuscripts. For keeping up with journals, blogs, and news without algorithmic noise, I use [NetNewsWire](https://netnewswire.com), backed by a self-hosted [Miniflux](https://miniflux.app) instance.

## AI tools

[Claude](https://claude.ai) is my primary AI assistant for writing, research, and coding. For code and research projects, I work increasingly inside the terminal with [Claude Code](https://www.anthropic.com/claude-code) and [OpenCode](https://opencode.ai/); the agent reads the project directly, which makes it a very different experience from a browser chatbot. The [OpenCode note](/notes/opencode/) walks through the setup and everyday workflows, including the free-tier and local-only options (Google Gemini, Groq, Ollama). I also use [Dot](https://new.computer) for more personal reflection-oriented prompts.

## Daily macOS layer

A surprising amount of quality of life comes from small utilities. [Raycast](https://www.raycast.com) replaced Spotlight years ago and now handles launching, snippets, clipboard history, and a lot more. Window management is split between [Rectangle Pro](https://rectangleapp.com/pro), [AltTab](https://alt-tab-macos.netlify.app), and [DockDoor](https://github.com/ejbills/DockDoor). [Ice](https://icemenubar.app) keeps the menu bar under control.

I also use [MagicQuit](https://magicquit.com), [Lungo](https://sindresorhus.com/lungo), [Batteries](https://www.fadel.io/batteries), [TinkerTool](https://www.bresink.com/osx/TinkerTool.html), [BetterDisplay](https://github.com/waydabber/BetterDisplay), and [LinearMouse](https://linearmouse.app). None of these are dramatic individually, but together they make the machine feel calmer.

## Office and institutional collaboration

My university runs on Microsoft, so a significant part of my day is in [Word](https://www.microsoft.com/en-us/microsoft-365/word), [Excel](https://www.microsoft.com/en-us/microsoft-365/excel), [PowerPoint](https://www.microsoft.com/en-us/microsoft-365/powerpoint), and [OneDrive](https://www.microsoft.com/en-us/microsoft-365/onedrive/online-cloud-storage). I write in plain text and export where I can, but collaboration with co-authors and institutional workflows still land in Word and PowerPoint. Pandoc (from my Markdown stack) handles the conversion cleanly in both directions.

## Browsers

[Brave](https://brave.com) is my primary browser (Chromium engine, strong privacy defaults out of the box, no Google account required). [Safari](https://www.apple.com/safari/) when battery and Apple integration matter, and [Min](https://minbrowser.org) for quiet reading sessions.

## Security, media, and the rest

For networking and access to self-hosted services, I use [Tailscale](https://tailscale.com). I still keep [Keybase](https://keybase.io) for encrypted file sharing, and [Wipr](https://giorgiocalderolla.com/wipr.html) on Safari.

For media and visuals: [IINA](https://iina.io), [CleanShot X](https://cleanshot.com), [Pika](https://superhighfives.com/pika), [ImageOptim](https://imageoptim.com), and [Pixelmator Pro](https://www.pixelmator.com/pro/). [Vinegar](https://andadinosaur.com/launch-vinegar) and [Baking Soda](https://andadinosaur.com/launch-baking-soda) remove a lot of player clutter on the web.

For file transfer and system work: [Cyberduck](https://cyberduck.io), [Transmission](https://transmissionbt.com), [balenaEtcher](https://etcher.balena.io), and [UTM](https://mac.getutm.app).

## Hardware

A MacBook for everything. External display and a full-size keyboard when at the office. AirPods Pro for calls and focus.

## Closing note

I try to keep the stack stable. I do not chase new tools for their own sake; I switch only when something is clearly better in day-to-day work.
