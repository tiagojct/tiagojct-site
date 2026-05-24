---
title: quarto-study-flow
author:
  name: Tiago Jacinto
date: '2026-05-11'
description: A Quarto extension that renders CONSORT, STROBE, PRISMA, TRIPOD+AI, and STARD participant-flow diagrams from YAML in the document frontmatter.
lang: en
image: consort.png
draft: false
---

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/tiagojct/quarto-study-flow/blob/main/LICENSE) [![Quarto](https://img.shields.io/badge/Quarto-%E2%89%A51.4-37a779.svg)](https://quarto.org) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.20125560.svg)](https://doi.org/10.5281/zenodo.20125560)

`quarto-study-flow` is a small Quarto shortcode extension that renders participant-flow diagrams for five biomedical reporting guidelines from structured YAML in the document frontmatter. The same YAML produces inline SVG when you render to HTML and native TikZ when you render to PDF, so the same source compiles cleanly to both formats with no external rendering pipeline.

It supports five guidelines:

| `type:`   | Guideline                        | Used for                     |
| --------- | -------------------------------- | ---------------------------- |
| `consort` | CONSORT 2025 (supersedes 2010)   | Randomised controlled trials |
| `strobe`  | STROBE                           | Observational studies        |
| `prisma`  | PRISMA 2020                      | Systematic reviews           |
| `tripod`  | TRIPOD+AI 2024 (supersedes 2015) | Clinical prediction models   |
| `stard`   | STARD 2015                       | Diagnostic accuracy studies  |

## Links

- GitHub: [github.com/tiagojct/quarto-study-flow](https://github.com/tiagojct/quarto-study-flow)
- Install: `quarto add tiagojct/quarto-study-flow`
- DOI: [10.5281/zenodo.20125560](https://doi.org/10.5281/zenodo.20125560)
- Latest release: [v1.1.0](https://github.com/tiagojct/quarto-study-flow/releases/tag/v1.1.0)
- License: MIT

## Quick start

Add the extension to your project:

```bash
quarto add tiagojct/quarto-study-flow
```

Declare the diagram in the document YAML and drop the shortcode where you want the figure to appear:

````markdown
---
title: "My trial"
format: html
study-flow:
  type: consort
  enrollment:
    assessed: 350
    excluded: 120
    exclusion_reasons:
      - "Did not meet inclusion criteria: 80"
      - "Declined to participate: 40"
  randomised: 230
  groups:
    - label: "Intervention"
      allocated: 115
      lost_followup: 8
      analysed: 107
    - label: "Control"
      allocated: 115
      lost_followup: 10
      analysed: 105
---

The flow of participants is shown below.

{{< study-flow >}}
````

That's the whole authoring loop. Update an N count, re-render, the figure follows.

If you want the figure to be numbered and cross-referenceable from the prose (so you can write `@fig-trial` and get *"Figure 1"*), wrap the shortcode in a Quarto figure div:

````markdown
::: {#fig-trial}
{{< study-flow >}}

Participant flow following CONSORT 2025.

See @fig-trial for the participant flow.
````

This is just Quarto's standard `:::{#fig-id}` syntax for any custom figure content, and works in both HTML and PDF.

## What it looks like

CONSORT 2025:

![CONSORT example](projects/quarto-study-flow/consort.png))

PRISMA 2020 (with an optional parallel column for grey-literature and citation-search identification, matching the PRISMA 2020 v2 template):

![PRISMA example](projects/quarto-study-flow/prisma.png))

STARD 2015 (with the canonical 2×2 contingency grid at the bottom):

![STARD example](projects/quarto-study-flow/stard.png))

TRIPOD+AI 2024 (with development and external validation cohorts):

![TRIPOD example](projects/quarto-study-flow/tripod.png))

STROBE (with optional excluded-from-eligible and excluded-from-enrolled sidebars):

![STROBE example](projects/quarto-study-flow/strobe.png))

## Why I built it

Most flow diagrams I see in submitted manuscripts are drawn by hand in PowerPoint or Lucidchart, exported to PNG, dropped into the figure folder, and redrawn from scratch when one more participant withdraws and the N counts shift. The diagram itself is structurally trivial (boxes, arrows, counts), yet keeping it in sync with the rest of the paper is a manual task that nobody enjoys and nobody benefits from.

Treating the diagram as data means the source of truth is the manuscript itself. Re-rendering takes seconds, and the diagram cannot drift out of sync with the data it summarises.

A second goal was that the extension should not require anything beyond Quarto itself. Many publishing pipelines (institutional servers, conference build environments, CI runners on shared machines) do not let you install system libraries on demand, and a tool that breaks in those settings is not useful in practice. Both renderers are therefore pure Lua: SVG strings for HTML, TikZ strings for LaTeX, with no shell-outs to `rsvg-convert`, Graphviz, or a Python helper script.

## Design notes

The layout engine is shared across diagram types. Each builder emits an abstract list of boxes, lines, and arrows, and the two renderers (SVG and TikZ) consume that same abstract diagram, so a layout fix benefits both formats at once.

Internal units are pixel-equivalent. The TikZ output uses `[x=1pt, y=-1pt]` to map the same coordinates into LaTeX with the y-axis flipped, then wraps the whole picture in `\resizebox{\linewidth}{!}{...}` so it always fits the text width whatever the page geometry.

The diagrams follow the published reporting-guideline templates exactly. The extension does not invent new layouts or merge guidelines. CONSORT 2025 supersedes CONSORT 2010 with no structural change to the flow diagram, so the same `type: consort` builder works for both.

Every sidebar (excluded, lost to follow-up, did not receive index test) is rendered only when the corresponding YAML key is present, so a minimal CONSORT diagram with no exclusions and one arm still renders correctly.

## Reporting guideline references

- CONSORT 2025: Hopewell S et al. *CONSORT 2025 statement: updated guideline for reporting randomised trials.* The Lancet, 2025. <https://www.consort-spirit.org>
- STROBE: von Elm E et al. *Strengthening the Reporting of Observational Studies in Epidemiology (STROBE).* Ann Intern Med, 2007. <https://www.strobe-statement.org>
- PRISMA 2020: Page MJ et al. *The PRISMA 2020 statement: an updated guideline for reporting systematic reviews.* BMJ, 2021. <https://www.prisma-statement.org>
- TRIPOD+AI 2024: Collins GS et al. *TRIPOD+AI statement: updated guidance for reporting clinical prediction models that use regression or machine learning methods.* BMJ, 2024. <https://www.tripod-statement.org>
- STARD 2015: Bossuyt PM et al. *STARD 2015: an updated list of essential items for reporting diagnostic accuracy studies.* BMJ, 2015. <https://www.equator-network.org/reporting-guidelines/stard/>

## Source code

The full source, examples, and field reference are on GitHub:

- [github.com/tiagojct/quarto-study-flow](https://github.com/tiagojct/quarto-study-flow)

If you want a guideline added, hit a layout edge case, or want to extend the YAML schema for a specific use case (e.g. crossover trials, cluster RCTs, three-arm studies), GitHub issues are the right place to start.

## Citation

If you use the extension in published work, please cite it via the Zenodo DOI:

> Jacinto, T. (2026). *quarto-study-flow* (Version 1.1.0) [Computer software]. <https://doi.org/10.5281/zenodo.20125560>

BibTeX is available from the *Cite this repository* sidebar on the GitHub page, or by clicking through to the Zenodo record above.
