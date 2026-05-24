---
title: Pequod
subtitle: A pigment-inspired palette for reading and code
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-04-21'
date-modified: '2026-04-30'
description: 'Pequod is the palette that this website runs on: warm paper at one end, deep ink at the other, with eight accent hues named after the crew of Melville''s whaler. It is meant for prose, data,
  and code that will be read at length.'
image: cover.jpg
lang: en
tags:
- Design
- Colour
- Typography
- Tools
draft: false
---

![Pequod](projects/pequod/cover.jpg))

[ GitHub](https://github.com/tiagojct/pequod){.pequod-btn}
[ VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=tiagojct.pequod-color-theme){.pequod-btn}
[ Open VSX](https://open-vsx.org/extension/tiagojct/pequod-color-theme){.pequod-btn}
[ PyPI](https://pypi.org/project/pequod/){.pequod-btn}
[ npm](https://www.npmjs.com/package/pequod-tailwind){.pequod-btn}
[ R package](https://github.com/tiagojct/pequod/tree/main/r){.pequod-btn}

Pequod is a palette designed for long reading. Paper to ink, with eight accent hues drawn in the same pigment register: earthy, muted, the colours of weathered materials. The whole thing is named after the whaler in *Moby-Dick*, and its accents are named after the people who sailed her.

This page is the narrative, readable version. The canonical source lives at [github.com/tiagojct/pequod](https://github.com/tiagojct/pequod), with tokens, themes, licence files, and the CVD test script.

> [!note]
## Status

**Alpha, v0.2.0.** A perceptual-correctness rewrite of the v0.1 tokens: monotonic Log scale, CVD-safe crew accents, every accent now clears WCAG-AA-large on its target surface. Hex values may still shift by a point or two as I test against more code and long-form reading. The [GitHub repository](https://github.com/tiagojct/pequod) is the source of truth; this page is kept in sync with each release.

The **VS Code extension** is published to the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=tiagojct.pequod-color-theme) (as *Pequod Palette*) and to the [Open VSX Registry](https://open-vsx.org/extension/tiagojct/pequod-color-theme) for VSCodium / Cursor / Gitpod users.

The **Python package** is on [PyPI](https://pypi.org/project/pequod/): `pip install pequod` (or `pip install "pequod[plot]"` for the matplotlib helpers).

The **R package** is on [CRAN](https://CRAN.R-project.org/package=pequod): `install.packages("pequod")`.

## Why Pequod

Three things bother me about the palettes most tools ship with:

1. They are **optimised for glance rather than reading.** Saturated primaries tire the eye after ten minutes.
2. They rarely commit to a **paper-and-ink metaphor.** Backgrounds drift bluish, text drifts greyish, and there is no felt continuity between a printed page and the screen.
3. Their **accent hues are decorative**. Red means error, yes; nothing else in the palette carries the weight of a character.

Pequod follows the lineage of Steph Ango's [Flexoki](https://stephango.com/flexoki), which solves (1) and (2) beautifully, and adds (3) through Melville. Every accent is a person, with a role in the crew that maps to a role in a page of code or text. The role works as a mnemonic. The palette reads better once you know who is who.

## The Log scale

The base scale runs from *Log 50* (almost-white paper, the inside cover of a ship's log) to *Log 950* (the night sky over the deck before a storm). It is deliberately warm on the paper side and cool on the ink side: the colours of aged parchment and iron-gall ink meeting on the same page.

<div class="swatch" style="--c:#F7F3EE"><span>Log 50</span><code>#F7F3EE</code></div>
<div class="swatch" style="--c:#EAE1D7"><span>Log 100</span><code>#EAE1D7</code></div>
<div class="swatch" style="--c:#DBC9B6"><span>Log 150</span><code>#DBC9B6</code></div>
<div class="swatch" style="--c:#CFAD8E"><span>Log 200</span><code>#CFAD8E</code></div>
<div class="swatch" style="--c:#BD8C68"><span>Log 300</span><code>#BD8C68</code></div>
<div class="swatch" style="--c:#A16E50"><span>Log 400</span><code>#A16E50</code></div>
<div class="swatch" style="--c:#835A49"><span>Log 500</span><code>#835A49</code></div>
<div class="swatch" style="--c:#335260"><span>Log 600</span><code>#335260</code></div>
<div class="swatch" style="--c:#163F54"><span>Log 700</span><code>#163F54</code></div>
<div class="swatch" style="--c:#0D2F42"><span>Log 800</span><code>#0D2F42</code></div>
<div class="swatch" style="--c:#0C222F"><span>Log 900</span><code>#0C222F</code></div>
<div class="swatch" style="--c:#0B1720"><span>Log 950</span><code>#0B1720</code></div>

The scale has twelve numbered steps. The warm→cool hinge falls between Log 500 (warm taupe) and Log 700 (cool sage). Log 50 is the paper tone used as the light-mode background of this site; Log 100 is the slightly darker cream that accent-light variants are designed against (a stricter reference than Log 50). Log 950 is the dark-mode background.

## The Crew

Eight accent hues, each named after a character in *Moby-Dick*, each with a light-mode and a dark-mode variant. Light variants sit against Log 100; dark variants sit against Log 950. Seven of the eight dark-mode accents clear WCAG-AA (4.5:1) on Log 950 (Daggoo lands at 4.4:1, just under AA-body and so reserved for AA-large uses); light-mode accents range from 3.0:1 (Stubb) to 9.5:1 (Daggoo), with four of the eight clearing 4.5:1 for body text. The Accessibility section below has the full table.

<div class="crew-row">
  <div class="crew-name">Ahab</div>
  <div class="crew-role">red</div>
  <div class="crew-sample crew-sample-light" style="--c:#A83732">#A83732</div>
  <div class="crew-sample crew-sample-dark" style="--c:#E3877C">#E3877C</div>
  <div class="crew-note">Obsession, fire, the wound. For errors, alarms, destructive actions.</div>
</div>

<div class="crew-row">
  <div class="crew-name">Starbuck</div>
  <div class="crew-role">blue</div>
  <div class="crew-sample crew-sample-light" style="--c:#0082B1">#0082B1</div>
  <div class="crew-sample crew-sample-dark" style="--c:#A6DFFF">#A6DFFF</div>
  <div class="crew-note">The steady chief mate; sea and storm. For functions, primary actions, hyperlinks in code.</div>
</div>

<div class="crew-row">
  <div class="crew-name">Queequeg</div>
  <div class="crew-role">indigo</div>
  <div class="crew-sample crew-sample-light" style="--c:#253E82">#253E82</div>
  <div class="crew-sample crew-sample-dark" style="--c:#838CCF">#838CCF</div>
  <div class="crew-note">Tattoo ink and loyalty. For types, classes, interfaces.</div>
</div>

<div class="crew-row">
  <div class="crew-name">Pip</div>
  <div class="crew-role">yellow</div>
  <div class="crew-sample crew-sample-light" style="--c:#6A4A00">#6A4A00</div>
  <div class="crew-sample crew-sample-dark" style="--c:#DEC577">#DEC577</div>
  <div class="crew-note">Child of the sun, the lost soul. For numbers, literals, highlights.</div>
</div>

<div class="crew-row">
  <div class="crew-name">Ishmael</div>
  <div class="crew-role">grey</div>
  <div class="crew-sample crew-sample-light" style="--c:#76716B">#76716B</div>
  <div class="crew-sample crew-sample-dark" style="--c:#BFBBB6">#BFBBB6</div>
  <div class="crew-note">The narrator; observer, transparent. For comments, punctuation, muted text.</div>
</div>

<div class="crew-row">
  <div class="crew-name">Stubb</div>
  <div class="crew-role">orange</div>
  <div class="crew-sample crew-sample-light" style="--c:#CA6435">#CA6435</div>
  <div class="crew-sample crew-sample-dark" style="--c:#FFD9BB">#FFD9BB</div>
  <div class="crew-note">The pipe-smoking second mate; amber and easy flame. For constants, warnings, changes.</div>
</div>

<div class="crew-row">
  <div class="crew-name">Tashtego</div>
  <div class="crew-role">green</div>
  <div class="crew-sample crew-sample-light" style="--c:#177C55">#177C55</div>
  <div class="crew-sample crew-sample-dark" style="--c:#82C4A2">#82C4A2</div>
  <div class="crew-note">Gay Head harpooneer; moss and low pine. For strings, success, additions.</div>
</div>

<div class="crew-row">
  <div class="crew-name">Daggoo</div>
  <div class="crew-role">brown</div>
  <div class="crew-sample crew-sample-light" style="--c:#552823">#552823</div>
  <div class="crew-sample crew-sample-dark" style="--c:#A17069">#A17069</div>
  <div class="crew-note">African-born harpooneer; mahogany and earth. For variables, references, identifiers.</div>
</div>

The syntax-highlighting assignments are deliberate. Ahab gets red because Ahab *is* red. Starbuck gets blue because he is the voice that wants to turn the ship around, and moderate reason reads as blue in most people's heads. Ishmael narrates from outside, so he is grey. Pip, adrift and saved by the sea, is yellow like the sun that reflected off the water he was almost lost in. You do not need to know any of this to use the palette, but if you do, the colours stop being arbitrary.

## How it is used on this site

Pequod runs the whole site. The body renders Log 800 text on Log 50 in light mode and Log 100 text on Log 950 in dark mode. Light-mode headings use Log 800; dark-mode headings use Log 150 (parchment). Links use Log 700 with a soft border-bottom, hovering to Log 400 (warm taupe). Category pills use a 16%-opacity softsage tint. The navbar uses Log 800 with Log 100 text: the Pequod's dark hull with a cream deck.

The accent hues are not yet wired in as syntax colours on this site (that will come with the VS Code theme). The site does give you a chance to see the base scale carry a substantial body of text, which is, in the end, the only real test of a reading palette.

## In matplotlib

The Python package ships with `pequod.register_cmaps()`, which makes the Log scale and the crew accents addressable as ordinary matplotlib colormaps (`pequod_log`, `pequod_crew`, etc.). Combined with a small `_theme()` helper that paints the figure surface from `pequod.LOG`, you get a coherent look across plot types in about 10 lines of code.

![Log scale as a continuous colormap on Log 950](projects/pequod/example-heatmap.png))

![Grouped bars in the crew dark variants](projects/pequod/example-bars.png))

![Horizontal bars on Log 50 paper, ranked descending](projects/pequod/example-hbars.png))

A full gallery (eight plots on dark and light surfaces, including box plots, scatter, distributions, and a specimen-style swatch grid) lives at [github.com/tiagojct/pequod/tree/main/examples](https://github.com/tiagojct/pequod/tree/main/examples), with the [reproducible source](https://github.com/tiagojct/pequod/blob/main/examples/plots.py) under 350 lines of matplotlib. Titles set in Atkinson Hyperlegible Next SemiBold, ticks in JetBrains Mono.

## Design principles

- **Read-first.** Every design decision prioritises comfort over contrast for contrast's sake. Pigments are muted; saturation stays low.
- **One story, two temperatures.** The base scale warms toward paper and cools toward ink. The contrast is deliberate, the palette's distinctive move.
- **Semantic accents.** Each accent hue has a role. When you assign it in a theme, the assignment should feel earned.
- **Accessibility as the floor.** Every body-text pairing clears WCAG-AA (4.5:1). Some clear AAA. Focus states are explicit, never conveyed by colour alone.
- **Paper and ink, not neon.** Pequod holds no colour you could not mix from earth pigments and ship's ink.

## Accessibility

Measured WCAG contrast ratios on body text (17px, 400 weight):

| Pair | Use | Ratio |
|---|---|---|
| Log 800 on Log 100 | light body | 10.8 : 1 |
| Log 700 on Log 50 | light link | 10.2 : 1 |
| Log 400 on Log 50 | muted / large text | 3.9 : 1 |
| Log 100 on Log 950 | dark body | 14.0 : 1 |
| *Accent-light* on Log 100 | UI accents (see below) | 3.0 – 9.5 : 1 |
| *Accent-dark* on Log 950 | dark-mode accents | 4.4 – 13.7 : 1 |

Accent-light on Log 100, per crew member: Daggoo 9.5, Queequeg 7.8, Pip 6.3, Ahab 5.0; all clear WCAG-AA (4.5:1) for body text. Tashtego 4.0, Ishmael 3.7, Starbuck 3.4, and Stubb 3.0 fall short of AA-body on Log 100 and are best reserved for bold, large-text (≥ 18.7px), or UI uses where AA-large (3:1) is the relevant target. Accent-dark on Log 950, per crew member: Stubb 13.7, Starbuck 12.6, Pip 10.7, Ishmael 9.5, Tashtego 9.0, Ahab 6.9, Queequeg 5.7; all clear AA-body. Daggoo lands at 4.4, just under AA-body and so reserved for AA-large uses.

### Colourblindness

[Dichromacy](https://en.wikipedia.org/wiki/Dichromacy) is the form of [colour blindness](https://en.wikipedia.org/wiki/Color_blindness) in which one of the three cone types is absent.

**[Protanopia](https://en.wikipedia.org/wiki/Color_blindness#Protanopia):** no L-cone; reds darken and collapse toward greens and browns. About 1% of men.

**[Deuteranopia](https://en.wikipedia.org/wiki/Color_blindness#Deuteranopia):** no M-cone; greens collapse toward reds. The most common dichromacy, roughly 1.1% of men.

**[Tritanopia](https://en.wikipedia.org/wiki/Color_blindness#Tritanopia):** no S-cone; blues collapse toward greens and yellows toward reds. Rare (< 0.01%), often overlooked in palette design.

Each accent was simulated at 100% severity for the three dichromatic conditions using the [Viénot–Brettel–Mollon (1999)](https://doi.org/10.1002/%28SICI%291520-6378%28199908%2924%3A4%3C243%3A%3AAID-COL5%3E3.0.CO%3B2-0) model in LMS space, and pairwise perceptual distances ([ΔE\*~ab~](https://en.wikipedia.org/wiki/Color_difference#CIE76), CIE76, [Lab D65](https://en.wikipedia.org/wiki/CIELAB_color_space)) were computed between the simulated accent colours. Lower ΔE means two colours collapse to a more similar appearance; below ~10 they become hard to tell apart.

The [Viénot–Brettel–Mollon algorithm](https://en.wikipedia.org/wiki/Color_blindness#Simulation_of_dichromatic_vision) converts an sRGB colour to [LMS space](https://en.wikipedia.org/wiki/LMS_color_space) (the responses of the long-, medium-, and short-wavelength cones), projects the colour onto the plane of the missing cone, and converts back. The output approximates what a dichromat would perceive.

[ΔE\*~ab~](https://en.wikipedia.org/wiki/Color_difference#CIE76) is the Euclidean distance between two colours in [CIELAB space](https://en.wikipedia.org/wiki/CIELAB_color_space), a roughly perceptually uniform space with [D65](https://en.wikipedia.org/wiki/Illuminant_D65) as the reference white point. ΔE ≈ 1 is a just-noticeable difference; ΔE ≈ 10 is the rough boundary at which two colours stop reading as clearly distinct.

Worst-case ΔE per simulation (v0.2.0; every other pair clears ΔE ≥ 10):

| Condition | Variant | Closest pair | ΔE |
|---|---|---|---|
| Protanopia    | light | Ishmael ↔ Tashtego | 15.1 |
| Protanopia    | dark  | Stubb ↔ Tashtego   | 11.8 |
| Deuteranopia  | light | **Ishmael ↔ Tashtego** |  8.0 |
| Deuteranopia  | dark  | **Ishmael ↔ Tashtego** |  6.8 |
| Tritanopia    | light | Pip ↔ Daggoo       | 13.3 |
| Tritanopia    | dark  | Ahab ↔ Pip         | 10.2 |

The deuteranopia floor is **Ishmael ↔ Tashtego** because saturated green collapses to neutral grey under deutan and the two accents are designed to sit at similar L\* on their respective surfaces. This is mathematically unavoidable for an 8-hue palette that includes both a green and a low-chroma grey, so it is documented rather than designed away. v0.2.0 closed the catastrophic v0.1.0 collapses (Pip ↔ Stubb at ΔE 1.0 under tritanopia, Ahab ↔ Daggoo at ΔE 2.8 under protanopia-dark); the worst-case pair is now ten times further apart than under v0.1.0.

**Usage guidance.** Do not rely on colour alone to distinguish *Ishmael* from *Tashtego* under deuteranopia (the Pequod default theme italicises comments to break the tie). Every other accent pair clears ΔE ≥ 10 across all three simulations.

The simulation script and the full pairwise ΔE matrix live in the [GitHub repository](https://github.com/tiagojct/pequod) under `scripts/cvd_check.py`.

## Download

- [`Pequod.itermcolors`](projects/pequod/Pequod.itermcolors)): iTerm2 colour scheme (dark). Right-click and *Save link as…*, then in iTerm2 open *Settings > Profiles > Colors > Color Presets > Import…* and select the file. Apply the *Pequod* preset.
- **VS Code extension**: search *Pequod* on the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=tiagojct.pequod-color-theme), or grab the `.vsix` from the [GitHub releases page](https://github.com/tiagojct/pequod/releases). Includes both **dark** and **light** themes.
- [`Pequod-color-theme.json`](projects/pequod/Pequod-color-theme.json)): raw VS Code dark theme (for building the extension yourself).
- [`Pequod-light-color-theme.json`](projects/pequod/Pequod-light-color-theme.json)): raw VS Code light theme.
- [`Pequod.zed.json`](projects/pequod/Pequod.zed.json)): Zed theme family with both **dark** and **light** variants in a single file. Drop it into `~/.config/zed/themes/` (see note below).
- [`pequod.json`](projects/pequod/pequod.json)): the canonical palette tokens (base scale, accents, role mappings, syntax assignments).
- **R package**: on [CRAN](https://CRAN.R-project.org/package=pequod), `install.packages("pequod")`. See install note below.
- [Printable specimen PDF](https://github.com/tiagojct/pequod/blob/main/specimen/specimen.pdf): one-page A4 reference. Source at [`specimen/specimen.typ`](https://github.com/tiagojct/pequod/blob/main/specimen/specimen.typ).

### Installing the VS Code themes

The themes are packaged as a Visual Studio Marketplace extension. Three ways to install:

1. **Marketplace.** Open VS Code → Extensions (⌘⇧X / Ctrl+Shift+X) → search *Pequod* → install. Then *Preferences: Color Theme* → pick **Pequod** or **Pequod Light**.
2. **`.vsix` file.** Download the `.vsix` from the [GitHub releases page](https://github.com/tiagojct/pequod/releases) and run:
   ```bash
   code --install-extension pequod-color-theme-0.2.0.vsix
   ```
3. **From source.** Clone the repo and copy the [`vscode/`](https://github.com/tiagojct/pequod/tree/main/vscode) folder to `~/.vscode/extensions/pequod-color-theme/`. VS Code picks it up on next launch.

### Installing the Zed themes

Zed reads user themes from its themes directory directly. The single `Pequod.zed.json` file contains both variants:

1. Save `Pequod.zed.json` to `~/.config/zed/themes/Pequod.zed.json` (create the folder if it does not exist).
2. Restart Zed.
3. Open the command palette (⌘⇧P / Ctrl+Shift+P), run *theme selector: toggle*, and pick **Pequod Dark** or **Pequod Light**.

### Installing the R package

The R package is on [CRAN](https://CRAN.R-project.org/package=pequod):

```r
install.packages("pequod")

library(pequod)
palette_pequod("log")             # 12-step Log scale
palette_pequod("crew", n = 5)     # first five crew accents
pequod_preview("crew")            # quick base-R preview
```

To follow the development version (between CRAN releases), the `r/` subdirectory of the main repository can be installed directly: `remotes::install_github("tiagojct/pequod", subdir = "r")`.

ggplot2 scales:

```r
library(ggplot2)
ggplot(iris, aes(Sepal.Length, Sepal.Width, colour = Species)) +
  geom_point(size = 3) +
  scale_color_pequod_d(palette = "crew")
```

Six named palettes ship: `log`, `log-warm`, `log-cool`, `crew`, `crew-dark`, `syntax`. Data is regenerated from `pequod.json` by `r/data-raw/generate_palettes.R`, so the R values cannot drift from the canonical tokens. Full docs in [`r/README.md`](https://github.com/tiagojct/pequod/tree/main/r).

## Roadmap

What exists today
  ~ this website (you are reading Pequod rendered in itself)
  ~ [github.com/tiagojct/pequod](https://github.com/tiagojct/pequod): the canonical repository, with `pequod.json` as the single source of truth
  ~ [`pequod.json`](projects/pequod/pequod.json)): machine-readable tokens
  ~ [`Pequod.itermcolors`](projects/pequod/Pequod.itermcolors)): iTerm2 colour scheme (dark)
  ~ [`Pequod-color-theme.json`](projects/pequod/Pequod-color-theme.json)) + [`Pequod-light-color-theme.json`](projects/pequod/Pequod-light-color-theme.json)): VS Code dark and light themes
  ~ [`Pequod.zed.json`](projects/pequod/Pequod.zed.json)): Zed theme family (dark + light)
  ~ [VS Code Marketplace extension](https://marketplace.visualstudio.com/items?itemName=tiagojct.pequod-color-theme): both themes packaged for one-click install (also on [Open VSX](https://open-vsx.org/extension/tiagojct/pequod-color-theme))
  ~ [Terminal presets](https://github.com/tiagojct/pequod/tree/main/themes/terminals): Ghostty, Alacritty, kitty, WezTerm, tmux, Windows Terminal (all share the same ANSI mapping as the iTerm2 preset)
  ~ [Python package](https://pypi.org/project/pequod/): `pip install pequod`, with optional matplotlib glue under `pequod[plot]`
  ~ [Tailwind CSS plugin](https://www.npmjs.com/package/pequod-tailwind): `npm install pequod-tailwind`; spreads into `theme.extend.colors` for instant `bg-log-50`, `text-ahab`, etc.
  ~ [R package](https://CRAN.R-project.org/package=pequod): on CRAN, `install.packages("pequod")`
  ~ [Printable specimen (PDF)](https://github.com/tiagojct/pequod/blob/main/specimen/specimen.pdf): one A4 page, generated from [`specimen.typ`](https://github.com/tiagojct/pequod/blob/main/specimen/specimen.typ) with Typst
  ~ [CVD test script](https://github.com/tiagojct/pequod/blob/main/scripts/cvd_check.py): Viénot--Brettel--Mollon simulation, reproducible from `pequod.json`

What comes next
  ~ **Generators** for the remaining theme targets so the JSON stays the single source of truth end-to-end (the R package, the specimen, and the CVD script already regenerate from it).
  ~ **iTerm2 light preset** to round out the terminal theme.
  ~ **Terminal themes**: Ghostty, Kitty, Alacritty. Trivial once the tokens are fixed.
  ~ **Vim / Neovim colourscheme** using Lush.
  ~ **Helix, Sublime**: lower priority.

## Inspirations and credits

- [Flexoki](https://stephango.com/flexoki) by Steph Ango is the most direct inspiration. Pequod owes its philosophy (warm paper, cool ink, muted accents, published tokens) to Flexoki. Where Flexoki draws on earth pigments broadly, Pequod narrows the story to a ship, a century, and a text.
- [Solarized](https://ethanschoonover.com/solarized/) by Ethan Schoonover established the modern practice of designing palettes for reading first.
- [Tokyo Night](https://github.com/enkia/tokyo-night-vscode-theme) and [Nord](https://www.nordtheme.com/) are two other palettes with a disciplined colour story.
- Herman Melville, *Moby-Dick; or, The Whale* (1851), for the names.

## Licence

- **Palette and documentation:** [Creative Commons Attribution 4.0 International](https://creativecommons.org/licenses/by/4.0/). Use, adapt, ship; credit required.
- **Theme files and code:** [MIT](https://opensource.org/licenses/MIT).

Licence files live alongside the tokens at [github.com/tiagojct/pequod](https://github.com/tiagojct/pequod).

---

If you use Pequod in a project, I would love to hear about it: [tiagojacinto@med.up.pt](mailto:tiagojacinto@med.up.pt)). Corrections, suggested accents, or observations about how the palette holds up against your actual reading and coding are especially welcome.
