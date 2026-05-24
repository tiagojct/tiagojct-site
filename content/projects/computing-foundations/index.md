---
title: Computing Foundations for Health Researchers
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-04-13'
description: 'A self-paced learning path covering the essential computing tools for health research: terminal, Git, GitHub, Zotero, Zettlr, scientific writing, and AI-assisted work.'
image: sergey-zolkin.jpg
lang: en
tags:
- Tutorials
- Computing
draft: false
---

Most health research today requires working with data, code, references, and written output, often simultaneously, often under version control, and often in collaboration with others. These are not optional skills bolted on to statistical knowledge. They are the foundation on which reproducible, auditable research is built.

This learning path covers the core computing tools that a health researcher needs. Each post is self-contained and written for a specific audience: someone comfortable with Python or R but who has not had formal training in the command line, version control, or reference management. The posts are ordered to build on each other; start at the beginning and work through.

## The learning path

### Core sequence

These seven notes form the main sequence. Work through them in order.

| # | Note | What you learn |
|---|---|---|
| 1 | [The terminal for health researchers](/notes/terminal/) | Navigate, inspect data files, run scripts, and automate repetitive tasks from the command line. |
| 2 | [Git for health researchers](/notes/git/) | Track every change in your analysis, recover from mistakes, and build an auditable record from day one of the project. |
| 3 | [GitHub for health researchers](/notes/github/) | Publish your work, collaborate with a research team, and access real public health datasets through version-controlled repositories. |
| 4 | [Advanced Git for research](/notes/advanced-git/) | Stash interrupted work, bisect regressions, pin dataset versions with submodules, and automate pipelines with GitHub Actions. |
| 5 | [Using Zotero](/notes/zotero/) | Build a reference library you can trust: the interface, collections, tags, annotations, and a PDF workflow. |
| 6 | [Using Zettlr](/notes/zettlr/) | Write in Markdown, organise notes, link ideas across documents, and export to any format. |
| 7 | [Zettlr and Zotero](/notes/zettlr-zotero/) | Combine them into a plain-text academic writing workflow: cite while you write, export to Word or PDF via Pandoc. |

### Supplementary notes

These two notes are not part of the core sequence but are closely related.

| Note | Description |
|---|---|
| [Scientific Writing for Early-Career Researchers](/notes/sw/) | Principles of clear writing, article structure, data presentation, and the editorial process; not a tool tutorial, but everything these tools are in service of. |
| [OpenCode with Claude](/notes/opencode/) | Run a research AI assistant directly in the terminal, with access to your actual project files. Builds on terminal skills from note 1. |

## Why these tools together

Research that cannot be reproduced is research that cannot be trusted. The tools in this path are not independent skills; they form a stack:

1. The **terminal** is where you execute everything.
2. **Git** records every version of every file, permanently.
3. **GitHub** backs that history online, enables collaboration, and gives you access to public datasets.
4. **Zotero** manages the literature your work depends on.
5. **Zettlr** gives you a writing environment built around the same principles: plain text, linking, and transparency.
6. The **Zettlr--Zotero workflow** ties reference management directly into the writing process.
7. **Scientific writing** is the end goal; everything above is in service of clearer, more reproducible papers.

A project built on this stack can be handed to a colleague, a supervisor, or a reviewer, and they can see exactly what was done, when, and why.

## Assumptions

These posts assume you have access to a computer where you can install software and run a terminal: a laptop running macOS or Linux, or Windows with WSL2 installed. No server required for the first four posts.

<!-- SCREENSHOT: Overview diagram of the computing stack (terminal, Git, GitHub, Zotero, Zettlr, and the written output) connecting them as layers that build on each other -->
