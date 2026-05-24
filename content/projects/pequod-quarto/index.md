---
title: pequod-quarto
subtitle: A Quarto extension that applies the Pequod palette to reveal.js and HTML
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-05-12'
description: 'A Quarto extension that applies the Pequod palette and Atkinson Hyperlegible Next + Mono to reveal.js slides and HTML documents. Three formats ship: light slides, dark slides, and HTML.'
image: dark.png
lang: en
tags:
- Quarto
- Design
- Typography
- Tools
draft: false
---

![The dark variant: deep-ink ground with crew-dark accents.](projects/pequod-quarto/dark.png))

`pequod-quarto` is a Quarto extension that brings the [Pequod palette](/projects/pequod/) into Quarto presentations and documents. It ships three formats: `pequod-revealjs` for slides on warm paper, `pequod-dark-revealjs` for slides on deep ink, and `pequod-html` for documents, reports, and articles. Atkinson Hyperlegible Next and Atkinson Hyperlegible Mono are bundled as base64-embedded WOFF2, so the theme has no Google Fonts CDN dependency.

## Links

- GitHub: [github.com/tiagojct/pequod-quarto](https://github.com/tiagojct/pequod-quarto)
- Install: `quarto add tiagojct/pequod-quarto`
- Companion palette: [Pequod](/projects/pequod/)
- License: MIT (code), CC-BY-4.0 (palette), SIL OFL 1.1 (fonts)

## What it gives you

Three Quarto formats, one set of design tokens.

The palette itself, the Log scale, and the per-crew syntax assignments are documented in full on the [Pequod project page](/projects/pequod/). This page covers only the Quarto-specific surface.

| Format | Use for | Surface |
|---|---|---|
| `pequod-revealjs` | Slide decks | Warm paper |
| `pequod-dark-revealjs` | Slide decks | Deep ink |
| `pequod-html` | Documents, reports, articles | Warm paper |

Every Pandoc syntax token maps to a member of the crew: Ahab keywords (red), Tashtego strings (green), Pip numbers (yellow), Ishmael comments (grey), Starbuck functions (blue), Queequeg types (indigo), Stubb constants (orange), Daggoo variables (brown). The mapping is honoured by both the slide deck and the HTML document, so a code chunk in a report looks the same as a code chunk in a presentation.

![A code slide rendered with the light `pequod-revealjs` format.](projects/pequod-quarto/cover.png))

## Install

From any Quarto project:

```bash
quarto add tiagojct/pequod-quarto
```

This installs two extensions, `pequod` and `pequod-dark`, into `_extensions/`. Or scaffold a new project from the bundled template:

```bash
quarto use template tiagojct/pequod-quarto
```

## Use

In a `.qmd` front matter:

```yaml
---
title: "Your title"
format: pequod-revealjs
---
```

For the dark variant:

```yaml
format: pequod-dark-revealjs
```

For an HTML document:

```yaml
format: pequod-html
```

## Design decisions

A few choices worth flagging, since they differ from Quarto defaults.

**Vertical centering, left-aligned prose.** Reveal.js's `center: true` is on by default in the extension, so slide content sits in the vertical middle. The horizontal axis stays left-aligned, which keeps long-form prose readable. This matches how the upstream Pequod project treats reading: ink on paper, with text where the eye expects it.

**Smaller body type.** Reveal.js defaults to 40px root size. `pequod-revealjs` uses 28px, which lets a full paragraph or a short code chunk fit comfortably on a single slide without feeling crowded.

**16:9 at 1600 × 900.** The default slide canvas is widescreen and high-resolution. The upstream reveal.js default (1050 × 700) is 3:2 and feels dated on a modern projector.

**Local fonts.** Atkinson Hyperlegible Next and Mono are bundled directly inside the theme SCSS as base64-encoded WOFF2 files. No external CDN, no Google Fonts request at render time, and the rendered HTML works offline.

**Pandoc highlight theme.** A custom KDE-Syntax theme file (`pequod.theme` for light, `pequod-dark.theme` for dark) maps the standard Pandoc syntax classes to the crew accents. The same highlight theme is used across reveal.js and HTML, so syntax highlighting in a slide and in a report are identical.

**Quarto-specific callout fix.** Quarto's default callout selectors `.callout-note.callout-style-default .callout-title` outspecify a naive `.callout-note .callout-title` rule, so the per-kind crew accents (Starbuck for notes, Tashtego for tips, Stubb for warnings, Ahab for cautions and important) are written at matching specificity to win the cascade.

## File layout

```
_extensions/
├── pequod/
│   ├── _extension.yml
│   ├── pequod.scss               # revealjs entry (light)
│   ├── pequod-html.scss          # html entry
│   ├── pequod.theme              # Pandoc highlight (light)
│   ├── _pequod-palette.scss      # shared design tokens
│   ├── _pequod-fonts.scss        # @font-face (base64 woff2)
│   └── _pequod-revealjs-rules.scss
└── pequod-dark/
    ├── _extension.yml
    ├── pequod-dark.scss
    └── pequod-dark.theme
```

The two extensions share three partials (palette, fonts, reveal rules) via Sass `@import "../pequod/…"`. The dark variant is a thin overlay on the shared partials: it overrides only the role bindings (surface, text colour, link colour) and the active crew aliases, then re-imports the same rules.

## Customising

Every token in `_pequod-palette.scss` is declared with `!default`, so you can override any of them by composing a theme array in your own `.qmd`:

```yaml
format:
  pequod-revealjs:
    theme:
      - my-overrides.scss   # set $log-50, $starbuck-light, … here
```

Anything you set in `my-overrides.scss` wins because Sass `!default` only assigns when the variable is undefined.

## Source code

The full source and a working demo are on GitHub:

- [github.com/tiagojct/pequod-quarto](https://github.com/tiagojct/pequod-quarto)

The repo includes three example `.qmd` files (`example.qmd`, `example-dark.qmd`, `example-html.qmd`) that double as the regression-check renders.

## Licence

The colour values in `_pequod-palette.scss` are licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/); the rest of the extension (SCSS, Pandoc themes, manifests, documentation) is [MIT](https://opensource.org/licenses/MIT). Atkinson Hyperlegible Next and Mono are © Braille Institute of America, distributed under [SIL OFL 1.1](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL_web) via Google Fonts.

The companion palette page at [/projects/pequod/](/projects/pequod/) is the canonical narrative for the Pequod colour scheme itself; this page documents only the Quarto-specific wrapper.
