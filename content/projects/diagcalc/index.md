---
title: DIAGCALC
author:
  name: Tiago Jacinto
date: '2026-03-14'
description: A diagnostic test calculator with web, TUI, and CLI interfaces for teaching and practical use.
lang: en
image: diagcalc.png
draft: false
---

DIAGCALC is a diagnostic test calculator built around a simple idea: start from a confusion matrix, calculate the core performance measures of a diagnostic test, and then show how the test result changes the probability of disease.

It has two interfaces:

- a web app for teaching, demonstration, and interactive use in the browser
- a terminal app with both TUI and CLI modes for keyboard-driven work and automation

The web app and terminal app use the same calculation engine, so the numbers remain consistent across interfaces.

## Links

- Web app: [tiagojct.github.io/diagcalc](https://tiagojct.github.io/diagcalc/)
- GitHub: [github.com/tiagojct/diagcalc](https://github.com/tiagojct/diagcalc)
- npm: [npmjs.com/package/diagcalc](https://www.npmjs.com/package/diagcalc)

## What it does

DIAGCALC supports the standard teaching and practical workflow for diagnostic reasoning:

1. define or load a case
2. inspect the confusion matrix
3. estimate the pre-test probability
4. calculate core test performance measures
5. interpret likelihood ratios
6. update to post-test probability

It computes:

- sensitivity
- specificity
- positive predictive value
- negative predictive value
- LR+
- LR-
- positive and negative post-test probability
- 95% confidence intervals using the Wilson method

The web app also includes a Fagan nomogram.

## Why I built it

I wanted a tool that would be useful both in teaching and in actual day-to-day work.

Many diagnostic calculators are either too minimal, too opaque, or too tied to a single interface. DIAGCALC tries to do the opposite:

- keep the maths visible and easy to verify
- keep the workflow aligned with how diagnostic reasoning is actually taught
- make the same engine available in the browser and in the terminal
- support both interactive exploration and scripted use

## Philosophy

The project follows a few simple principles.

### 1. Simplicity

The calculator should be easy to use during a class, a tutorial, or a quick discussion at the command line.

### 2. Transparency

The outputs should be understandable. The goal is not just to compute metrics, but to help users see how they relate to each other.

### 3. Consistency

The web app, the TUI, and the CLI should agree. If the input is the same, the output should be the same.

### 4. Lightweight design

The web app is static. The terminal app is small. The project is intentionally simple to deploy and maintain.

## Web app

The web app is intended for browser-based teaching, live demonstrations, and direct interaction.

Features:

- preset scenarios from generic examples and medical literature
- direct confusion matrix entry
- pre-test and post-test probability display
- probability bars
- result cards with interpretation notes
- Fagan nomogram
- print-friendly output

Use it here:

- [Open the web app](https://tiagojct.github.io/diagcalc/)

## Terminal app

The terminal version is useful when you want a keyboard-first workflow, remote use over SSH, or integration into scripts.

It supports:

- a TUI for interactive use
- a plain CLI for one-shot calculations
- JSON output for automation
- export from the TUI to plain text or Markdown

## Install

### Browser only

No installation is required. Use the hosted page:

- [https://tiagojct.github.io/diagcalc/](https://tiagojct.github.io/diagcalc/)

### Terminal app

Install from npm:

```bash
npm install -g diagcalc
```

Then run:

```bash
diag --tui
```

## Terminal usage

### TUI

```bash
diag --tui
```

### List datasets

```bash
diag --list-datasets
```

### Run a preset case

```bash
diag --dataset hiv_elisa
```

### Run an ad hoc case

```bash
diag --tp 42 --fp 8 --fn 3 --tn 120 --pre 15
```

### JSON output

```bash
diag --dataset ddimer --format json
```

## TUI controls

- `Tab` or `Ctrl-N`: next panel
- `Shift-Tab` or `Ctrl-P`: previous panel
- arrow keys: move selection
- type digits directly into the selected input field
- `Backspace`: delete one character
- `Delete` or `Ctrl-U`: clear the selected field
- `Enter`: open the selected field in prompt mode
- `n`: start a blank ad hoc case
- `x`: export the current case to plain text
- `m`: export the current case to Markdown
- `r`: reset the current case
- `q`: quit

## Modes of use

I think of DIAGCALC as useful in three contexts.

### Teaching

The web app is suitable for teaching sessions, tutorials, and small-group explanations of pre-test and post-test probability.

### Personal study

Students and trainees can use the preset cases to practise interpretation and see how different confusion matrices affect the final reasoning.

### Terminal workflow

The CLI and TUI are useful when a browser is not the right tool, or when you want to integrate calculations into a reproducible workflow.

## Project structure

- `index.html` — web app markup
- `styles.css` — web app styles
- `script.js` — web app logic and Fagan nomogram rendering
- `lib/diagcalc-core.js` — shared calculation engine
- `lib/diagcalc-datasets.js` — shared preset datasets
- `tui/index.js` — terminal UI
- `bin/diagcalc.js` — CLI and TUI entrypoint

## Source code and release

The full source code is on GitHub:

- [github.com/tiagojct/diagcalc](https://github.com/tiagojct/diagcalc)

The terminal app is published on npm:

- [npmjs.com/package/diagcalc](https://www.npmjs.com/package/diagcalc)

If you want to inspect the implementation, report an issue, or contribute improvements, GitHub is the right place to start.
