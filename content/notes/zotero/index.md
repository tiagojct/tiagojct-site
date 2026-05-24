---
title: Using Zotero
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-03-06'
date-modified: '2026-04-20'
description: 'A practical guide to Zotero: the interface, adding references, managing collections and tags, annotating PDFs, writing notes, and building a library you can trust.'
image: zotero-download.png
lang: en
citation:
  url: https://tiagojct.eu/notes/zotero/
tags:
- Zotero
- Tutorials
- Productivity
draft: false
---

It has been nearly 20 years since I started using reference managers. My first was EndNote, then Mendeley, and for the past decade Zotero has been my main tool for organising references, notes, and PDFs. I have used it for everything from small literature reviews to large systematic reviews, and it has scaled with me as my library grew from a few dozen papers to several thousand.

A reference manager does not just store citations: it becomes the single place where a paper, its metadata, your annotations, and your notes about it all live together. When you need to cite something, you find it. When a reviewer asks you to clarify a source, you find it in seconds, not minutes.

**Zotero** is free, open-source, and has been the standard reference manager in academic research for many years. This post is a practical guide to setting it up and using it, written mostly as a guide for students, and for my future self.

Zotero is free and open-source. Storage for syncing PDFs across devices is the only paid feature, and the free tier (300 MB) is sufficient for a library without PDFs if you store files locally. More on this later.

## 1. Installing Zotero

Download the installer from [zotero.org](https://www.zotero.org/download). Zotero runs on macOS, Windows, and Linux. Install it as you would any other application in your operating system.

![Zotero's website. Click the big red button and don't look back.](notes/zotero/zotero-download.png))

The second thing to install is the **Zotero Connector**: a browser extension available for Firefox, Chrome, Edge, and Safari. This is what allows you to import references directly from journal websites, PubMed, Google Scholar, and DOI landing pages without any copy-pasting. The download page for the connector is on the same page as the main application.

> [!warning]
If you're using Safari, when you install Zotero, the connector is also installed, but make sure to enable it in Safari's Extensions settings.

Once both are installed, open Zotero. You will be prompted to create a free account; do this, even if you do not plan to sync immediately. It takes thirty seconds and you will want it later.

## 2. The interface

Zotero's main window is divided into three panes.

![Zotero main window after first installation, showing the collections panel on the left, the items list in the middle, and the item detail panel on the right](notes/zotero/zotero-main-window.png))

**Left pane: the collections panel.** This is a tree of folders you create to organise your library. At the top is "My Library", which contains everything. Below it you create collections, one per project or one per topic, whatever works for you. There are also a few special items: "My Publications" for papers you have authored, "Duplicate Items" for finding duplicate references, "Unfiled Items" for references not assigned to any collection, and "Trash".

![The left pane.](notes/zotero/zotero-left-pane.png))

**Middle pane: the items list.** When you select a collection on the left, the items it contains appear here. Each row shows the title, author, year, and item type (what is shown about the item is configurable by right-clicking on the top bar). You can sort by any column.

![A paperclip icon on the left of a row means the item has an attachment, usually a PDF.](notes/zotero/zotero-single-ref.png))

**Right pane: the item detail panel.** When you select an item in the middle pane, its metadata appears here: title, authors, journal, year, volume, pages, DOI, abstract, and more. Below the metadata are tabs for **Notes**, **Tags**, and **Related** items. This is also where you see and open attached PDFs.

Collections in Zotero are **virtual folders**, not physical ones. An item can belong to multiple collections simultaneously without being duplicated. Deleting a collection does not delete the items inside it; they remain in "My Library" and in any other collections they belong to.

The toolbar at the top of the window contains a few frequently used buttons: a green circle with a plus (new item), a magic wand (add item by identifier), a folder with a plus (new collection), and a search bar. The Zotero Connector button lives in your browser, not in the Zotero application itself.

![The toolbar](notes/zotero/zotero-toolbar.png))

## 3. Adding references

### Browser connector

This is the fastest and most reliable way to add references. When you are on a journal article page, a PubMed record, a Google Scholar result, or a DOI landing page, click the Zotero Connector icon in your browser toolbar.

![If the page contains a single article, the icon looks like a document.](notes/zotero/zotero-save-pubmed.png))

The connector works best on publisher websites (Elsevier, Springer, Wiley, BMJ, NEJM) and PubMed. On Google Scholar it works, but metadata quality varies. When possible, import from the primary source (the publisher's page or PubMed) rather than from Google Scholar.

If the page contains a single article, the icon looks like a document. Clicking the connector imports the item and its metadata directly into your library: title, authors, journal, year, volume, pages, DOI, abstract, all populated automatically. Zotero will also attempt to attach the PDF if it is freely accessible or if you have institutional access.

If the page contains multiple items (a search results page on PubMed, for example), the icon looks like a folder. Clicking it opens a dialog where you can select which items to import.

### Magic wand: add by identifier

In the Zotero toolbar, click the magic wand icon. A small input box appears. Paste a **DOI**, **PubMed ID (PMID)**, **ISBN**, or **arXiv ID** and press Enter. Zotero fetches the metadata from CrossRef, PubMed, or other resolvers and creates the item immediately.

This is the fastest path when you already have a list of identifiers, for example a table of studies from a previous systematic review, or a list of PMIDs from a PubMed search export. You can paste multiple identifiers separated by spaces or newlines and Zotero will import them all.

![One of the easiest ways to add an item to Zotero.](notes/zotero/zotero-magicwand.png))

### Drag and drop PDFs

If you already have PDFs saved on your computer, drag them into the Zotero window. Zotero will attempt to extract the metadata from the PDF, using the embedded DOI, the title, or its PDF recognition service. For recent papers from major publishers, this works reliably. For older scanned papers or preprints, it may require manual correction.

After dropping a PDF, right-click the created item and choose "Retrieve Metadata for PDF" if the fields are empty. If automatic retrieval fails, you can edit the metadata manually in the right pane.

### Manual entry

For items without a DOI or an online record (grey literature, unpublished reports, clinical guidelines from institutional websites, internal documents), use `File > New Item` and select the appropriate item type from the menu. Zotero supports over twenty item types: journal article, book, book chapter, conference paper, report, thesis, dataset, preprint, statute, and more. *Selecting the correct type matters because each type has different metadata fields, and those fields determine how the citation is formatted.*

### Importing from .bib or .ris

If someone sends you a `.bib` or `.ris` file, or if you export references from another database (EMBASE, Web of Science, Cochrane), use `File > Import` and select the file. Zotero reads the file and creates items for each reference. Review the imported items afterwards; field mapping from other systems is not always perfect, and author names in particular sometimes need correction.

## 4. Collections

Collections are how you impose structure on your library. Without them, everything sits in a flat list in "My Library" that becomes increasingly difficult to navigate as your library grows.

### Creating collections and subcollections

Right-click anywhere in the collections panel and choose "New Collection". Give it a descriptive name. To create a subcollection, right-click an existing collection and choose "New Subcollection". The tree can be as deep as you need, though more than two or three levels tends to become unwieldy.

To add an item to a collection, drag it from the items list onto the collection name in the left pane. You can also right-click an item and choose "Add to Collection". An item can belong to any number of collections simultaneously.

### Organisation strategies

There is no single correct way to organise a library. A few patterns that work well:

**By project.** One top-level collection per research project. Inside it, subcollections for background reading, methods references, and papers directly cited in the manuscript.

```
My Library
├── Project 1/
│   ├── Background
│   ├── Methods
│   └── Included studies
├── Project 2/
│   ├── Search results
│   ├── Full-text screening
│   └── Included studies
└── Subject readings/
    ├── Epidemiology
    └── Biostatistics
```

**By review stage.** For a systematic review, collections that mirror your screening workflow: one for all retrieved references, one for those that passed title/abstract screening, one for full-text review, and one for included studies.

**By topic.** For ongoing reading across multiple projects, a library organised by topic (cohort methods, survival analysis, specific disease areas) lets you find a reference without knowing which project it belonged to originally.

The "Unfiled Items" entry in the collections panel shows every item that is not in any collection. After a large import session it is worth checking this list; items that landed there were either added before you created any collections or were not assigned manually.

### Deleting collections vs. deleting items

This distinction is important. Right-clicking a collection and choosing "Delete Collection" removes the collection but **does not delete the items** inside it; they remain in "My Library". To delete the items themselves, you must select them, press Delete (or right-click and choose "Move to Trash"), and then empty the trash.

## 5. Tags

Tags are a second axis of organisation, independent of collections. Where collections group items by project or context, tags describe properties of items: their role in your workflow, their quality, their topic, their review status.

### The tag selector

At the bottom of the left pane is the **tag selector**: a list of all tags used by items in the currently selected collection. Clicking a tag filters the items list to show only items with that tag. Clicking a second tag narrows the filter further. Clicking a tag again deselects it.

This filtering is the main practical use of tags. A tag of "include" on a set of studies lets you click once in the tag selector and see exactly those studies, regardless of which collection you are browsing.

### Adding and editing tags

Select an item, go to the Tags tab in the right pane, and click "Add Tag". Type the tag name and press Enter. To remove a tag, click the minus button next to it.

Tags are case-sensitive. "To read" and "to read" are different tags. Decide on a convention (all lowercase, no spaces) and stick to it. You can rename tags across all items by right-clicking the tag name in the tag selector and choosing "Rename Tag".

### Coloured tags

![In this example, there are four tags: `tag1` and `tag3` are selected, and thus, only items with those tags are shown in the main window. You can also add colors to tags, like `tag1`, to create a visual distinction between tags.](notes/zotero/zotero-tags.png))

Right-click any tag in the tag selector and choose "Assign Colour". You can assign one of nine colours and a **position number from 1 to 9**. Once a tag has a position, pressing that number on the keyboard while an item is selected in the items list toggles the tag on or off immediately, without going to the Tags tab. Coloured tags also appear as small coloured dots in the items list, so you can see tagged items at a glance.

A useful set of coloured tags for a systematic review: 1 = include (green), 2 = exclude (red), 3 = uncertain (yellow), 4 = key paper (blue). With these assigned, you can screen a list of references by selecting each one and pressing a number, at the same speed as purpose-built systematic review software, with the rest of Zotero's functionality alongside it.

### Managing auto-imported tags

When you import references from PubMed or other databases, Zotero imports their indexing keywords as tags. A PubMed record might add twenty MeSH terms as tags to an item. These tags quickly fill the tag selector and make your own tags harder to find.

To hide them, right-click the tag selector and uncheck "Show Automatic". Auto-imported tags are still there (they still appear in the item's Tags tab, and you can search for them in the advanced search), but they are no longer cluttering the tag selector. I always turn this off and never turn it back on.

![Go to `Settings` and scroll down to `Miscellaneous`.](notes/zotero/zotero-tags-prefs.png))

## 6. Notes

Notes in Zotero let you write free-form text attached to a reference, or as standalone entries in your library. This is where your intellectual engagement with the literature lives, alongside the bibliographic metadata.

### Item notes vs. standalone notes

An **item note** is attached to a specific reference. Select an item, go to the Notes tab in the right pane, and click the green plus button to create a note. The note editor opens in the right pane. Item notes appear as child items under the reference in the items list (click the triangle to expand).

A **standalone note** is not attached to any reference. Create one with `File > New Note > New Standalone Note`, or by right-clicking a collection and choosing "New Standalone Note". Standalone notes are useful for summaries of a topic, reading logs, or meeting notes that reference multiple papers without belonging to any one of them.

![Use and abuse notes!](notes/zotero/zotero-note.png))

### What to write in notes

The note editor supports rich text: bold, italic, headings, bullet lists, and links. You can format notes as you would a document.

For a systematic review, a useful structure for item notes is:

```
**Study design:** Retrospective cohort, two tertiary hospitals, 2018–2023
**Population:** 5,204 adults hospitalised for acute heart failure
**Outcome:** 30-day unplanned readmission
**Key finding:** Readmission rate 12.3% (95% CI 11.5–13.1%); NT-proBNP ≥ 1,000 pg/mL
  at discharge independently associated (adjusted HR 1.31, 95% CI 1.08–1.59)
**Limitations:** Two-centre; no measurement of diuretic adherence after discharge
**Notes for review:** Uses a broader HF definition than Jones 2022 —
  discuss in methods
```

Notes are **full-text searchable** in Zotero's quick search bar. If you write a finding in a note, you can find the paper later by searching for any term in the note, not only the title or authors. This makes detailed notes far more valuable than they might initially seem.

### Merging notes into a summary

Standalone notes can also serve as a synthesis layer. As you read and annotate papers, copy key findings into a standalone note per topic. By the time you sit down to write, you have a structured summary of the literature rather than a list of individual papers to re-read.

## 7. Annotating PDFs

Zotero includes a built-in PDF reader. When you open an attached PDF by double-clicking it, it opens in a tab within Zotero rather than in an external application.

### Annotation tools

The PDF reader has five annotation tools in the toolbar:

- **Highlight**: drag to highlight text in yellow (or other colours). Right-click a highlight to change its colour.
- **Underline**: draws a line under selected text.
- **Sticky note**: click anywhere in the PDF to add a floating comment.
- **Area highlight**: drag to capture a rectangular region, useful for figures, tables, and equations.
- **Text annotation**: add a label to a selected area.

All annotations are stored in Zotero, not written into the PDF file itself. This means they sync with the rest of your library and are not lost if you replace the PDF.

![PDF annotations can be very helpful.](notes/zotero/zotero-pdf-annotation.png))

### Extracting annotations to a note

After annotating a PDF, right-click the item in the items list and choose "Add Note from Annotations". Zotero creates an item note containing all your highlights and comments, formatted as a structured list with the highlighted text and the page number. This note is searchable and editable; you can add your own commentary between the extracted highlights.

![Extracting annotations to a note is particularly useful before writing. Instead of re-reading a PDF to find the passages you marked, you open the extracted note and read a condensed version of the paper's most relevant content.](notes/zotero/zotero-pdf-annotation-note.png))

## 8. Organising attachments and storage

### Where Zotero stores files

By default, Zotero stores PDFs and other attachments in a **data directory** on your computer, typically at `~/Zotero` on macOS and Linux, or `C:\Users\[username]\Zotero` on Windows. Inside this folder is a `storage` subfolder containing one subfolder per item, each named with a random alphanumeric key.

**You do not need to manage this folder manually.** Zotero handles everything. The important thing is not to move or rename it while Zotero is closed, and to include it in your regular backups.

### Stored files vs. linked files

By default, when you import a PDF, Zotero **copies** it into its data directory (a "stored file"). Alternatively, you can configure Zotero to save a **link** to a file at its original location rather than copying it. Linked files are useful if you already have an organised folder of PDFs you do not want to duplicate, but they introduce a fragility: if you move the original file, the link breaks.

For most users, stored files are the right choice. Let Zotero manage the files and do not think about the folder structure.

### Syncing and storage

Zotero syncs your **library data** (metadata, collections, tags, notes) for free across all your devices when you are signed in to a Zotero account. PDF attachments are separate: syncing files requires either Zotero's own storage (300 MB free, paid plans for more) or a **WebDAV** server.

If you do not want to pay for Zotero storage, a WebDAV service (many universities offer this, or you can use a service like Koofr or pCloud) can serve as the sync target for attachments. Configure it under `Edit > Preferences > Sync > File Syncing > Sync attachment files in My Library using WebDAV`.

Regardless of whether you sync PDFs, back up the Zotero data directory manually. Metadata, notes, and annotations live there. A copy to an external drive or a cloud storage folder takes a few seconds and protects against data loss.

## 9. Search and saved searches

### Quick search

The search bar in the toolbar filters the items list as you type. By default it searches titles, creators, and years. Click the small dropdown arrow on the left of the search bar to switch to "All Fields & Tags" or "Everything"; the latter includes full-text content of attached PDFs and notes.

### Advanced search

![The Advanced search is powerful, and you can even save a search into a dynamic collection.](notes/zotero/zotero-advanced-search.png))

`Edit > Advanced Search` (or `Ctrl/Cmd + Shift + F`) opens a dialog where you can build multi-condition queries: author contains "Smith" AND year is after 2020 AND tag is "include". The results appear as a temporary collection. Click "Save Search" to keep it as a **saved search**: a dynamic collection that always shows items matching the criteria, updated automatically as your library changes.

### Useful saved searches

A few saved searches that are worth setting up:

| Name | Condition |
|---|---|
| Added this week | Date Added > is in the last > 7 days |
| Missing PDFs | Attachment > is > false |
| Unread | Tag > is > "to read" |
| No collection | Collection > is > Unfiled Items |

: Useful saved searches {.striped .hover}

"Missing PDFs" is a useful maintenance tool. Run it periodically and use the magic wand or the browser connector to attach PDFs to items that only have metadata. A library where every item has a PDF attached is much more useful than one where half the items are metadata-only.

## 10. Syncing and group libraries

### Syncing across devices

If you work on more than one computer (a laptop at home and a desktop at work, for example), Zotero sync keeps your library identical on both. Sign in to the same Zotero account on each computer. Under `Edit > Preferences > Sync`, make sure "Sync automatically" is enabled. Zotero will sync whenever it is open and there is an internet connection.

Library data (metadata, collections, tags, notes) syncs for free. PDF attachments sync via Zotero storage or WebDAV as described in section 8.

### Group libraries

A **group library** is a shared library accessible to multiple Zotero accounts. It is separate from your personal "My Library" and appears as a distinct section in the collections panel. Groups are managed at [zotero.org/groups](https://www.zotero.org/groups).

To create a group, go to zotero.org, sign in, and click "New Group". You can set the group to private (invitation only) or public (anyone can join). Add members by email address or Zotero username, and assign roles: owner, admin, or member (read/write). Read-only access is available for public groups.

Group libraries are useful for:

- A research team sharing references for a multi-centre study
- A supervisor and student working on the same systematic review
- A lab maintaining a shared collection of methods references

Group libraries share metadata and notes but **not personal annotations**. Highlights and sticky notes you add to a PDF are stored locally and do not appear for other group members. If you want to share annotations, extract them to a note first; notes do sync with the group.

## Summary

| Task | Action |
|---|---|
| Install | Download from zotero.org; install the browser connector |
| Add references | Use the browser connector, magic wand, drag-and-drop PDFs, or manual entry |
| Organise | Create collections per project; use subcollections for review stages |
| Tag | Add manual tags; assign colours and keyboard shortcuts (1–9) for fast tagging |
| Notes | Write item notes for extraction and synthesis; use standalone notes for topic summaries |
| Annotate PDFs | Highlight, underline, and annotate in the built-in reader; extract to a note |
| Search | Use quick search or advanced search; save useful searches as dynamic collections |
| Sync | Sign in to a Zotero account; use Zotero storage or WebDAV for PDF sync |
| Collaborate | Create a group library and invite team members |

: Key actions in Zotero {.striped .hover}

Everything in Zotero (your library data, notes, and tags) is stored in an open format on your computer. You are not locked in. You can export your entire library as a `.bib` or `.ris` file at any time, and every note you have written is accessible even without Zotero.

## Related notes

- [Zettlr and Zotero: a plain-text workflow for scientific writing](/notes/zettlr-zotero/): the full manuscript workflow: Better BibTeX, stable cite keys, CSL styles, and Pandoc export.
- [Using Zettlr](/notes/zettlr/): the Markdown editor on the other end of that pipeline.
- [Scientific writing for early-career researchers](/notes/sw/): how references fit into the wider writing process, reporting guidelines, and the editorial process.

If you have any comments or questions, feel free to [reach out](mailto:tiagojacinto@med.up.pt)).
