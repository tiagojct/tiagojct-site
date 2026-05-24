---
title: 'Zettlr and Zotero: a plain-text workflow for scientific writing'
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-03-06'
date-modified: '2026-04-20'
description: 'How to write a scientific manuscript in Zettlr with Zotero managing your references: stable cite keys, automatic .bib export, and Nature-style citations via Pandoc.'
image: cover.png
lang: en
citation:
  url: https://tiagojct.eu/notes/zettlr-zotero/
tags:
- Productivity
- Academic writing
- Tools
draft: false
---

Most researchers write manuscripts in Word or Google Docs and manage references in a reference manager that stays loosely coupled to the document. The result is familiar: field codes that break when you share the file, a bibliography that reformats unexpectedly after a software update, and a final submission process that involves deleting hidden metadata and hoping nothing falls apart. The formatting is entangled with the content, and the toolchain is fragile.

A plain-text workflow separates those concerns. You write in a Markdown file that contains only content and cite keys. A reference manager exports your library to a `.bib` file that sits on disk. At export time, Pandoc reads the document, resolves every cite key against the `.bib`, and applies a citation style (Nature, Vancouver, APA, anything) automatically. The manuscript is a text file. The reference list is generated, not maintained by hand. The citation style is swapped by pointing to a different CSL file.

This post walks through that workflow using three tools: **Zotero** for reference management, the **Better BibTeX** plugin for stable cite keys and automatic `.bib` export, and **Zettlr** as the Markdown editor that connects to both. By the end you will have a writing environment where inserting a reference is a keystroke, the bibliography is always up to date, and switching citation styles takes ten seconds.

This post assumes you are comfortable with both Zotero and Zettlr. If you are new to either, start with [Using Zotero](/notes/zotero/) or [Using Zettlr](/notes/zettlr/) first.

## 1. Zotero: managing your library

For this workflow, two things matter most about your Zotero library: it is organised into collections, and every item has complete and correctly-typed metadata. The metadata fields (author, year, journal, volume, pages, DOI) are what the CSL style reads to produce a formatted citation. An incorrectly typed item (a preprint saved as a journal article, for example) will be missing fields and produce broken citations. The [Using Zotero](/notes/zotero/) guide covers collections, item types, and metadata in full.

### Adding items

**Browser connector.** Install the Zotero Connector extension for your browser. When you are on a journal article page, a DOI landing page, or a PubMed record, clicking the connector icon imports the item and its metadata directly into your library. Zotero will also attempt to attach the PDF if it is accessible.

**DOI or ISBN lookup.** In the Zotero toolbar, click the magic wand icon, paste a DOI or ISBN, and press Enter. Zotero fetches the metadata from CrossRef or other resolvers and creates the item. This is the fastest path for items you already have DOIs for.

**Manual entry.** Use `File > New Item` and select the item type. Fill in the fields by hand. This is necessary for grey literature, internal reports, and anything without a DOI.

Once an item is in your library, right-click it to attach a PDF, a note, or a link. Notes attached to items are searchable and stay with the reference: a good place to record why a paper was included in your review, or what a finding means for your argument.

<!-- SCREENSHOT: Zotero main window with a populated library showing journal articles, a book chapter, and a preprint in the middle pane, and the item metadata visible in the right pane -->

### Better BibTeX

Better BibTeX (BBT) is a Zotero plugin that does two things this workflow depends on: it gives every item a **stable, human-readable cite key**, and it **auto-exports your library to a `.bib` file** whenever anything changes.

**Installing BBT.** Download the `.xpi` file from the [Better BibTeX releases page](https://github.com/retorquere/zotero-better-bibtex/releases). In Zotero, go to `Tools > Add-ons`, click the gear icon, choose `Install Add-on From File`, and select the `.xpi`. Restart Zotero. A new `Better BibTeX` section will appear under `Edit > Preferences`.

**Cite key format.** The default BBT pattern generates keys like `jacinto2026` or `jacinto2026plaintext`. You can customise the pattern under `Edit > Preferences > Better BibTeX > Citation keys`. A pattern that works well for most cases is:

```
[auth:lower][year]
```

This produces keys like `smith2023`, `johnson2024`. For disambiguation when one author has multiple papers in the same year, BBT appends a letter: `smith2023a`, `smith2023b`. Once a key is generated and pinned, BBT will not change it even if you add more items; this is what "stable" means. You can pin a key by right-clicking an item and choosing `Better BibTeX > Pin BibTeX key`.

**Auto-export.** This is the step that connects Zotero to Zettlr. You want the `.bib` file to always reflect your current library without any manual action.

Go to `File > Export Library`. In the export dialog, select `Better BibTeX` as the format, tick the **Keep updated** checkbox, and choose a stable path for the output file, somewhere outside any folder that syncs or changes automatically:

```
~/references/my-library.bib
```

Click `OK`. BBT will write the `.bib` file immediately and update it in the background whenever you add, edit, or delete items. You never have to export again.

Choose a path you will not accidentally move or rename. Zettlr and Pandoc both need to find this file at the exact path you configure. A folder in your home directory works well; avoid paths inside Dropbox or iCloud Drive folders that might rename or conflict.

<!-- SCREENSHOT: Zotero Better BibTeX preferences pane showing the citation key format field, and the export dialog with Keep updated checked and a file path entered -->

## 2. Configuring Zettlr

### Linking the .bib file

Open Zettlr and go to `File > Preferences > Export` (on macOS: `Zettlr > Preferences > Export`). There are two fields to fill in:

- **Citation database:** paste the full path to your `.bib` file, e.g. `~/references/my-library.bib`
- **CSL stylesheet:** paste the full path to your CSL file, e.g. `~/references/nature.csl`

CSL files for virtually every journal and citation style are available at [zotero.org/styles](https://www.zotero.org/styles). Download the file, put it somewhere stable alongside your `.bib`, and point Zettlr at it.

Save and close the preferences. Zettlr will now load your reference database in the background. This takes a few seconds for large libraries.

<!-- SCREENSHOT: Zettlr preferences pane, Export tab, showing the Citation database field populated with a .bib file path and the CSL stylesheet field populated with nature.csl -->

### Testing autocomplete

In any open document, type `@` followed by the first few characters of an author name or title. A dropdown should appear showing matching references from your library. Use the arrow keys to select one and press Enter; Zettlr inserts the cite key in the correct Pandoc citation syntax: `[@smith2023]`.

If the dropdown does not appear, the most likely cause is that Zettlr has not loaded the `.bib` file: check the path in Preferences for typos, and confirm the file exists at that location.

### How Pandoc resolves citations

Zettlr is a front end. The actual work of turning `[@smith2023]` into a formatted citation happens in **Pandoc**, which Zettlr calls at export time. Pandoc reads the `bibliography` field in your document's YAML front matter, loads the `.bib` file, looks up each cite key, and formats the references according to the CSL file. Zettlr does not do this itself; it just constructs the Pandoc command with the right arguments.

This is worth understanding because it means citations will only be rendered in the exported document, not in the editor preview. What you see in Zettlr while writing is the raw cite key; what you see in the exported DOCX or PDF is the formatted citation.

## 3. Writing the article

### YAML front matter for the manuscript

Every Zettlr document that will be exported with citations needs a YAML front matter block at the top of the file. At minimum it needs `bibliography` and `csl`:

```yaml
---
title: "NT-proBNP at discharge predicts 30-day readmission in acute heart failure: a cohort study"
author:
  - name: Tiago Jacinto
    affiliation: Faculty of Medicine, University of Porto
date: "2026-03-06"
bibliography: ~/references/my-library.bib
csl: ~/references/nature.csl
---
```

The `bibliography` and `csl` paths here are passed directly to Pandoc. They do not need to match the paths configured in Zettlr's preferences; those are only used for autocomplete. What Pandoc uses is whatever is declared in the document's own front matter.

> **If your submission system requires the `.bib` file** (some journals, especially those using LaTeX, ask you to upload it separately), change the `bibliography` path to a relative one: `bibliography: references.bib`. Put the `.bib` file in the same folder as your manuscript before exporting.

### Inserting citations

The standard Pandoc citation syntax covers every case you will encounter:

```markdown
A single reference [@jones2022].

Multiple references in one bracket [@jones2022; @smith2023; @lee2024].

A specific page or range [@jones2022, p. 14] or [@jones2022, pp. 14--16].

Suppress the author name — useful after "Jones et al. showed that..." [-@jones2022].

Narrative citation: @jones2022 showed that NT-proBNP at discharge predicts heart failure readmission.
```

The semicolon separates multiple keys within one bracket. The order in which they appear in the bracket is the order Pandoc uses; some CSL styles will re-sort them, and Nature sorts by order of appearance in the text.

In Nature style, `[@jones2022]` renders as a superscript number at the point of citation, and the full reference appears in a numbered list at the end of the document. You do not number the references yourself; Pandoc assigns numbers in order of first appearance.

### Document structure

A standard scientific manuscript in Zettlr looks like this:

```markdown
---
title: "NT-proBNP at discharge predicts 30-day readmission in acute heart failure: a cohort study"
author:
  - name: Tiago Jacinto
    affiliation: Faculty of Medicine, University of Porto
date: "2026-03-06"
bibliography: ~/references/my-library.bib
csl: ~/references/nature.csl
---

## Abstract

Brief summary of the study, 250 words maximum.

## Introduction

The problem of heart failure readmission has been studied extensively [@jones2022; @smith2023].
Early work by @lee2024 established the baseline 30-day readmission rate in European centres.

## Methods

### Study population

Patients were included if they met the following criteria...

### Statistical analysis

Cox proportional hazards models were fitted as described previously [@johnson2021].

## Results

## Discussion

## References
```

The `## References` heading at the end is optional; Pandoc appends the reference list at the end of the document regardless. Including the heading makes its position explicit and lets you add a page break above it in Word templates.

## 4. Exporting

### The export dialog

In Zettlr, go to `File > Export` (or `Cmd/Ctrl + E`). The dialog shows available output formats. The most useful for manuscript submission are:

- **DOCX**: for journals that require Word files and for sharing with collaborators who use Word
- **PDF**: via LaTeX; produces well-typeset output but requires a LaTeX installation
- **HTML**: fast, useful for reviewing citations before final submission

Select the format and click Export. Zettlr constructs a Pandoc command using the paths from your document's front matter and runs it.

<!-- SCREENSHOT: Zettlr export dialog showing DOCX, PDF, and HTML format options, with a document open in the editor behind it -->

### What Pandoc does

When Pandoc processes your document it:

1. Parses the YAML front matter and locates the `.bib` file
2. Scans the document for citation keys (`[@key]`)
3. Looks each key up in the `.bib` file
4. Applies the CSL style to format each citation and the reference list
5. Writes the output file

If you export to DOCX with a Nature CSL, the citations in the body text will be superscript numbers and the reference list at the end will be formatted in Nature style: authors, title, journal name in italics, volume, pages, year. You do not touch any of this manually.

### Verifying Nature style

Open the exported DOCX and check the following:

- Citations in the body are superscript arabic numerals, numbered consecutively from 1 in order of first appearance
- The reference list entries follow the format: Author(s). Title. *Journal* **volume**, pages (year)
- Journal names are abbreviated correctly (Pandoc uses the abbreviations in the `.bib` file, so check the `journaltitle` or `journal` field in Zotero if a name appears in full when it should be abbreviated)
- The reference list heading is "References", not "Bibliography"

If the output looks correct on a test document with two or three references, it will look correct on the full manuscript.

### Common issues

| Issue | Symptom | Fix |
|---|---|---|
| `.bib` file not found | Pandoc error: `cannot find bibliography` | Check the `bibliography` path in the YAML front matter; use an absolute path or verify the relative path from the document's location |
| CSL file not found | Pandoc error: `cannot find CSL file` | Check the `csl` path; confirm `nature.csl` exists at that location |
| Cite key not in `.bib` | Citation renders as `[@smith2023]` literally, warning in Pandoc output | Open Zotero, find the item, check its BBT cite key matches exactly what you typed; re-export the `.bib` if needed |
| `.bib` file is stale | New items not appearing in autocomplete or output | Confirm BBT's auto-export is still active: `File > Export Library` and check the `Keep updated` entry |
| Journal names unabbreviated | Nature reference list shows full journal names | Add the abbreviated name to the `Journal Abbr` field in Zotero for the affected items |
| PDF export fails | Pandoc error mentioning LaTeX or a missing `.sty` file | Install a LaTeX distribution (TeX Live or MiKTeX) or export to DOCX instead and convert separately |

: Common export issues and fixes {.striped .hover}

> **Before submitting to a journal:** export to DOCX, open the file, and read through the reference list manually. Automated checks catch most problems, but an incorrectly typed cite key will silently fall through as a literal string if Pandoc does not find it in the `.bib`.

---

## Summary

| Step | Action |
|---|---|
| Set up Zotero | Install Better BibTeX, configure cite key pattern, enable auto-export to a stable `.bib` path |
| Configure Zettlr | Set the `.bib` path and CSL path under Preferences > Export |
| Write | Use `@` autocomplete to insert cite keys; write in plain Markdown |
| Front matter | Declare `bibliography` and `csl` in the document YAML |
| Export | Use `File > Export` in Zettlr; Pandoc formats citations and builds the reference list |
| Verify | Check superscript numbering, journal abbreviations, and that no cite key rendered literally |

: Key steps {.striped .hover}

The entire workflow is portable. The `.md` file, the `.bib` file, and the `.csl` file are plain text. They open on any machine with any editor, and they can be put under version control with Git, so you have a complete history of every change to your manuscript, your references, and your citations.

If you have any comments or questions, feel free to [reach out](mailto:tiagojacinto@med.up.pt)).
