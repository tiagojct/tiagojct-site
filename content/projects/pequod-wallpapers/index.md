---
title: Pequod Wallpapers
subtitle: A wallpaper generator built on the Pequod palette
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-05-04'
date-modified: '2026-05-12'
description: A static web application that generates Pequod-coloured wallpapers. Two modes (abstract with three sub-styles, maritime with six scenes), seed-reproducible output, optional Moby-Dick chapter
  epigraph, PNG and SVG export, an in-browser gallery.
lang: en
image: screenshot.png
tags:
- Design
- Colour
- Tools
draft: false
---

[ Open the application](https://tiagojct.eu/pequod-wallpapers/) ·
[ Source on GitHub](https://github.com/tiagojct/pequod-wallpapers) ·
[ Generated images CC BY 4.0](https://github.com/tiagojct/pequod-wallpapers/blob/main/LICENSE-IMAGES)

![The application running in light theme, abstract mode, showing a *constellation* composition: a dark biomorphic blob with a small red-brown inner disc, a thin sinuous curve crossing the canvas, and scattered asterisk and wedge marks on a warm Log 100 surface.](projects/pequod-wallpapers/screenshot.png))

> [!note]
## Status

**Beta.** The composition engine, the deploy pipeline, and the UI are stable. Two modes ship.

The **abstract** mode picks uniformly between three named sub-styles: *constellation* (a biomorphic blob with marks scattered around it), *lunar* (a crescent with a companion dot and a few star marks), and *gesture* (a sinuous hero curve with supporting marks).

The **maritime** mode picks uniformly between six named scenes, all built from the same primitive vocabulary as the abstract mode (no SVG file imports): *horizon* (a horizontal stroke plus a sun or moon disc, optional sail), *becalmed* (a flat horizon and a single vertical mast), *storm* (stacked sinuous waves, a leaning sail, a cloud blob), *whale-back* (one dominating sinuous curve with a fluke wedge and an eye dot), *doubloon* (a centred disc with a ring of asterisks), and *lookout* (a mast with a small disc atop and a low horizon).

Every composition, in either mode, is driven by a coherent four-colour chord chosen up-front so the elements harmonise. An optional Moby-Dick chapter epigraph can be toggled on to overlay a seeded italic-serif chapter title at the bottom of the composition.

## Why

The Pequod palette was designed for prose and code, but the test of any reading palette is whether it can carry a substantial body of work without tiring the eye. A wallpaper is the longest single exposure most readers ever have to a colour scheme. It is on every screen, every time the laptop wakes up, for months at a time. If the palette breaks under that load, the cracks will show.

This generator turns the question around. What does Pequod look like at scale, in motion, without text? What kind of compositions does the warm-paper-to-deep-ink axis produce when you let the gradient be the whole image and the accents have only one job?

The maritime mode pushes a step further. The palette is named for Ahab's ship, and the question there is whether the same colour vocabulary can carry not just abstract pattern but narrative figure: a horizon, a whale's back, a doubloon nailed to a mast, a lookout on a calm sea. The answer turned out to be yes, but only if the figures are drawn from the same vocabulary of primitives the abstract mode uses (a sinuous curve, a disc, a triangle, a bar). Imported motif SVGs were tried and dropped: they read as decals, not compositions.

## How it works

The application is a small static site. No bundler, no framework. ES modules in a directory, served from the GitHub Pages artifact published by the deploy workflow. The whole app loads in well under 100 KB of code plus the vendored `pequod.json` and `chapters.json`.

Each wallpaper is the deterministic output of a 32-bit seed. The seed format is `PEQUOD-` followed by four base36 characters. A mulberry32 pseudo-random generator drives every random choice in the composition pipeline, so the same seed plus the same controls always produces a pixel-identical image. URLs are permalinks. The gallery stores parameters, not pixels.

A composition is rendered as SVG and either exported as inline SVG (for vector use) or rasterised through a Canvas at the chosen resolution for PNG export. Default PNG export is 2880 px on the long axis.

### The vocabulary

Both modes share one vocabulary, kept in a single shared composition module. A composition is built from a small set of forms:

- A **biomorphic blob**, a closed Catmull-Rom-to-Bezier path with per-vertex radius perturbation, sized 30 to 40 percent of the canvas's short axis. Used as the *constellation* primary and as cloud forms in *storm*.
- A **crescent**, a foreground circle minus an offset surface-coloured circle that carves the inner edge. The *lunar* primary.
- A **sinuous hero curve**, a long bezier through five sample points. The *gesture* primary, the *whale-back* primary, and the wave layers in *storm*.
- A **disc**, used as a sun or moon in *horizon*, as the doubloon itself, and as a lookout perch.
- A **mast**, a thick vertical bar from a horizon line up to the masthead. The *becalmed* and *lookout* primaries.
- A **sail**, a small triangle anchored at the horizon. An optional companion in *horizon* and *storm*.
- **Small marks**: dots, asterisks (four to six thin crossed lines through a point with a small filled centre), short snake curves, wedges, eyes (an ellipse with a contrasting pupil), small rings, bars.

Every composition layers a soft Pequod gradient (seven stops with non-linear offsets) as ground, the primary forms on top, a turbulence-based paper-grain wash, and a subtle vignette. The grain seed is derived from the wallpaper seed, so the texture varies between regenerations and is stable for a given seed.

### The colour chord

Every composition picks a four-colour chord up-front: the surface (the Pequod Log step that backs the canvas), a closely related Log step on the same temperature side, the focal accent, and a secondary accent for marks. Every primary, every mark, and every line draws from this chord rather than from a random pool, so the result reads as one image rather than a stack of unrelated colours.

### The chapter epigraph

The optional epigraph layer overlays a seeded Moby-Dick chapter title at the bottom-left of the composition, in italic serif, low-opacity ink. The pick is reproducible from the same seed (it uses a derived RNG so toggling the epigraph on or off never disturbs the visual composition), and it covers all 135 chapters plus the *Etymology*, *Extracts*, and *Epilogue* front and back matter. The full chapter list is vendored as `chapters.json` at the repo root, derived from the 1851 first edition (public domain).

## The interface

Preview-first. The wallpaper fills the viewport. A translucent top bar carries the brand and the abstract / maritime mode toggle. A translucent bottom bar carries the primary action (regenerate), the display selectors (theme, aspect ratio), a *more* button that opens a side drawer for advanced controls, and the output actions (copy seed, copy share URL, export PNG, export SVG, save to gallery, open gallery).

The advanced drawer holds: density (low, medium, high), accent count (one to three), accent lock (a multi-select with light and dark colour swatches for the eight crew members), the seed input itself, a watermark toggle, and the chapter epigraph toggle. Each control carries a one-line explanation directly under it.

The gallery stores up to 200 wallpapers via IndexedDB, with FIFO eviction. Each entry stores the parameters (including the mode and the named sub-style or scene) plus a 256 px thumbnail. Click a thumbnail to restore the full generation; the parameters drive a seed-reproducible re-render.

### Keyboard

Six shortcuts, all single keys (no modifiers):

- `space`: regenerate.
- `m`: toggle between abstract and maritime.
- `t`: toggle between light and dark theme.
- `s`: save to gallery.
- `e`: export PNG.
- `g`: open or close the gallery.

`Esc` closes any open drawer. Shortcuts are ignored while focus is in an input, textarea, or select.

## Composition rules

Three rules constrain every composition so the output stays coherent across regenerations:

1. **Same temperature side.** The surface and the foreground Log steps come from the same side of the Pequod scale (warm Log 50 to 500 on light theme, cool Log 600 to 950 on dark theme). The bands never mix sides.
2. **Variant by theme.** Light-mode accent variants pair with light surfaces; dark-mode accent variants pair with dark surfaces. Never crossed in one composition.
3. **CVD floor.** The two accents that collapse most under deuteranopia (Ishmael and Tashtego, ΔE 6.8 in the Pequod accessibility table) are not used as the only two accents in any single composition. See the [Pequod accessibility section](/projects/pequod/) for the full pairwise distance matrix and the underlying CVD simulation.

## Try it

[Open the application](https://tiagojct.eu/pequod-wallpapers/). Generate, export, save what you like. The URL bar is the share URL: copy it and the recipient will see the same wallpaper.

The [source is on GitHub](https://github.com/tiagojct/pequod-wallpapers) under MIT for the code and CC BY 4.0 for the generated images. The vendored `pequod.json` was copied from the upstream Pequod repository at the time of build. To upgrade the palette, copy a fresh `pequod.json` and record the upstream commit SHA in the README.

## Inspirations

- [Pequod](/projects/pequod/), the palette this generator runs on. The generator exists to look at the palette in motion, at scale, without text.
- [Flexoki](https://stephango.com/flexoki) by Steph Ango, the lineage Pequod descends from. Flexoki was the first palette I saw that committed to the warm-paper-cool-ink metaphor at this fidelity.
- Joan Miró, for the abstract visual register: biomorphic forms, sparse asterisks, a crescent, a thin line, all on a soft painted ground.
- Herman Melville, for the maritime register and the chapter epigraph. The scene set (horizon, becalmed, storm, whale-back, doubloon, lookout) is a compressed reading of the book's recurring images.

## Licence

- **Code:** [MIT](https://github.com/tiagojct/pequod-wallpapers/blob/main/LICENSE-CODE).
- **Generated images:** [Creative Commons Attribution 4.0 International](https://github.com/tiagojct/pequod-wallpapers/blob/main/LICENSE-IMAGES). Use, adapt, ship; credit required.

---

If you generate a wallpaper you like and want me to know, the share URL captures everything: send it to [tiagojacinto@med.up.pt](mailto:tiagojacinto@med.up.pt)). Suggestions on the composition engine itself are also welcome: the source is small enough to read in an afternoon.
