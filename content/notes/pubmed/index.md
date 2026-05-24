---
title: 'Searching PubMed: a practical guide for clinicians and early-career researchers'
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-05-19'
description: How to build a PubMed query you can defend, reproduce, and re-run six months later, plus what AI scouts add (and where they lie). A 2026 refresh of a 2011 paper.
image: figures/search-recipe.svg
lang: en
bibliography: refs-pubmed.bib
csl: ../../nature.csl
citation:
  url: https://tiagojct.eu/notes/pubmed/
tags:
- PubMed
- Literature search
- Research methods
- Health informatics
draft: false
---

Fifteen years ago I wrote a short paper for the *Revista Portuguesa de Pneumologia* called *How to write a scientific paper — searching and managing biomedical information* [@jacinto2011searching]. It was aimed at trainee pulmonologists, but most of the readers I have heard from since were doctoral students in unrelated fields who had never been formally taught how to search a database. The interface has been redrawn twice since then, the journal has folded into another title, and a layer of AI tools now sits on top of every literature workflow. The job, however, has not changed: you need to find what is known about a question, judge what is worth reading, and end up with a list of references you can defend in a viva or a peer review.

This note is the 2026 version of that paper. It is **not** a systematic-review tutorial. For PRISMA, protocol registration, and dual screening, look elsewhere; the [evaluation methods reading list](/notes/emhi/) is a better starting point, and [PRISMA-S](https://www.prisma-statement.org/) is now the canonical extension for reporting literature searches [@rethlefsen2021prisma]. What follows is the everyday craft: how a busy clinician on Friday afternoon, or a PhD student in their second month, can build a PubMed query that returns the right papers, save it, and have new evidence arrive by email until they decide otherwise.

> [!tip]
## The short version

1. PubMed is still the **source of truth**. Every other tool (Google Scholar, Elicit, Consensus, ChatGPT) eventually has to be checked against it.
2. Always open **Search Details**. The translated query, not what you typed, is what PubMed actually ran. Copy it into your Methods.
3. **One block per concept**. Within a block, OR; between blocks, AND. NOT only at the end, only if you must.
4. Pair **MeSH with text words**: `("asthma"[MeSH] OR "asthma"[tiab])`. MeSH indexing is 6–12 months behind; `[tiab]` catches what MeSH has not yet caught up to.
5. Save the query in **MyNCBI** and create a weekly alert. The literature will then come to you.
6. Verify every AI-surfaced reference with the **Single Citation Matcher** before it enters Zotero. Hallucinated PMIDs are common and convincing [@walters2023chatgpt].

## Why PubMed still beats asking an LLM

You can ask a chatbot *"what does the evidence say about inhaled corticosteroids in preschool wheeze?"* and get a coherent paragraph in seconds. The paragraph will often be roughly right, occasionally wrong in load-bearing ways, and almost always supported by citations that are partly invented. In a controlled audit, more than half of the references ChatGPT produced for academic queries were fabricated or contained errors [@walters2023chatgpt].

PubMed has the opposite property: harder to use, slower to learn, sometimes ugly, but the results are real. Each record points to a paper that exists, with the indexing, abstract, and (when the journal participates) the full text. The trade is craft for trust, and the rest of this note is about making the craft cheap enough that the trust pays off.

The second reason to prefer PubMed is reproducibility. A query in PubMed can be saved, shared, and re-run. A conversation with an LLM cannot: the underlying model shifts between releases, temperature settings vary, and the same prompt can return different answers next week. If your reviewers ask how you found your references, *"I asked ChatGPT"* is not a defensible answer; *"I ran this query on this date and got 412 hits"* is.

## Anatomy of a PubMed query

When you type words into the PubMed search box, PubMed does not match them as a literal string. It runs your input through **Automatic Term Mapping** (ATM): it tries the phrase as a MeSH term, then as a journal title, then as an author, and finally as a set of text words across title and abstract [@nlmatm2024]. The result is a translated query, joined with `AND`, that may look little like what you typed.

![Automatic Term Mapping in action. PubMed expands each token of your raw query into a MeSH term (when one exists) plus a text-word fallback, then joins the resulting blocks with `AND`. The Search Details panel, at the bottom of the figure, exposes the translated query and is the single most important habit a new searcher can pick up.](notes/pubmed/figures/query-anatomy.svg){fig-align="center"}

ATM is also why a "simple" search often returns thousands of hits. PubMed has OR'd together MeSH expansions, plurals, and synonyms on your behalf without showing you the working. The Search Details panel shows you exactly what it did.

ATM is helpful when it works and harmful when it does not. It can mis-map a drug name to an unrelated MeSH term, or fail to map a recent concept that does not yet have a MeSH heading. Either way, the cure is the same: open the Search Details panel in the right sidebar and read the translated query. When results surprise you (too many, too few, off-topic), the answer is in there.

A useful exercise on day one: type a sloppy query, look at Search Details, then rewrite it explicitly. After a few weeks of this, you stop typing sloppy queries.

## MeSH in 60 seconds

MeSH (Medical Subject Headings) is the controlled vocabulary the U.S. National Library of Medicine uses to index every record in PubMed. Each MeSH term has a preferred label, which is the canonical form (`Asthma`); entry terms, the synonyms PubMed maps to the same heading (`Bronchial Asthma`, `Asthma, Bronchial`); a tree position in the hierarchy (`Asthma` sits under `Lung Diseases, Obstructive`, which sits under `Lung Diseases`, which sits under `Respiratory Tract Diseases`); and a set of subheadings that narrow the term (`Asthma/drug therapy`, `Asthma/epidemiology`). When you search for a parent term, PubMed by default *explodes* the tree and includes all descendants.

The MeSH Database (linked from the PubMed homepage under *Explore*) is the lookup tool. Type a free-text concept, find the canonical MeSH heading, decide whether you want to explode, and pick subheadings if relevant. Then add the term to your query with the tag `[MeSH]`, or `[MeSH:noexp]` to suppress explosion.

MeSH indexing is not instantaneous, and that is the trap. New records arrive in PubMed as `[PubMed - as supplied by publisher]` or `[PubMed - in process]` and only get MeSH terms once an NLM indexer assigns them, which typically takes weeks to months. A MeSH-only search misses the last 6–12 months of literature. The fix is the standard block pattern below: MeSH for older indexed records, text words (`[tiab]`) for everything else.

## Boolean and field tags: the working syntax

PubMed's query language is small and worth memorising.

Boolean operators are evaluated left to right unless parentheses say otherwise:

| Operator | Meaning |
|----------|---------|
| `AND` | both terms must appear |
| `OR` | either term may appear |
| `NOT` | excludes the second term; use last, sparingly |

Field tags go in square brackets after the term:

| Tag | What it restricts to |
|------|----------------------|
| `[tiab]` | title or abstract (free text) |
| `[ti]` | title only |
| `[MeSH]` | the term as a MeSH heading |
| `[MeSH:noexp]` | the MeSH heading, no explosion |
| `[au]` | author |
| `[dp]` | publication date (`2020:2026[dp]`) |
| `[la]` | language (`english[la]`) |
| `[pt]` | publication type (`randomized controlled trial[pt]`) |
| `[majr]` | major topic; only records where the MeSH term is the main focus |

A proximity operator was added in 2022:

```text
"inhaled corticosteroids preschool wheeze"[tiab:~3]
```

This matches when the four words appear in any order within three positions of each other in title or abstract. Use it to tighten otherwise noisy text-word blocks.

The block pattern is what most working searches look like: one block per concept, combined with `AND`.

```text
(
  "asthma"[MeSH] OR "asthma"[tiab]
)
AND
(
  "child"[MeSH] OR "children"[tiab] OR "paediatric"[tiab] OR "pediatric"[tiab]
)
AND
(
  "adrenal cortex hormones"[MeSH] OR
  "inhaled corticosteroids"[tiab] OR
  "ICS"[tiab]
)
AND
2015:2026[dp] AND english[la]
```

Build blocks in the **Advanced** search builder rather than the main search box. Each block gets a search-history number (`#1`, `#2`, ...). You then combine them with `#1 AND #2 AND #3`, which is easier to read and easier to debug.

## Filters worth using (and one to avoid)

PubMed's sidebar filters are convenient but they hide what they do. The ones I trust:

- *Article type* (`Randomized Controlled Trial`, `Systematic Review`, `Meta-Analysis`, `Practice Guideline`) maps to `[pt]` tags PubMed applies based on MEDLINE indexing.
- *Date*: prefer typing `2020:2026[dp]` in the query so it lands in Search Details and your Methods.
- *Language*: `english[la]` if you must, but flag the choice as a limitation; meaningful non-English studies exist for many questions.
- *Species*: `humans[mh]` for clinical questions; excludes animal studies.

The one to avoid is the `Free full text` filter. It looks innocuous and excludes landmark trials behind paywalls (*NEJM*, *Lancet*, *JAMA*) without warning. Use LinkOut with your institutional library proxy instead, or accept that you will hit some closed-access papers and request them.

Filters compound. Each one drops a fraction of your hits. Three filters and you may have halved your set without realising. Document every one in Methods.

## Clinical Queries: the bedside mode

If you are not writing a paper, just trying to answer a clinical question fast, Clinical Queries (linked from the homepage under *Find*) is the right entry point. It wraps your search in an evidence-tuned filter for therapy, diagnosis, etiology, prognosis, or clinical prediction guides, using the Haynes filters [@haynes2005clinical], plus a *Narrow* / *Broad* toggle that trades sensitivity for specificity.

Use it when you have ten minutes between consultations. Do not use it as a substitute for a properly built block search when you are writing.

## Single Citation Matcher: defense against hallucinated references

An LLM gives you what looks like a perfectly formatted reference: *Smith et al., NEJM 2021, NT-proBNP as a predictor of 30-day readmission in heart failure*. Before it enters Zotero, paste fragments (author, year, journal, title words) into the Single Citation Matcher (homepage, *Find* menu). If it returns a PMID, the paper exists. If it returns nothing, the paper almost certainly does not.

The model invents references in two ways. The first is composite fabrication: real authors, real journal, plausible title that no one ever wrote. The second is drift: a real paper with the wrong year, wrong volume, or wrong page numbers. Single Citation Matcher catches both.

The habit takes 20 seconds per reference. It catches the failure mode that has already made it into published peer-reviewed papers and forced retractions.

## MyNCBI: save the query, schedule the alert

This is the step that turns a one-off search into a standing system. MyNCBI is the free NLM account that lives behind PubMed and a handful of other NLM resources. Once you sign in:

1. Run your query.
2. Click *Create alert* under the search box.
3. Name it something you will recognise in a year (`asthma · ICS · preschool · 2026-recipe`).
4. Choose frequency (weekly is the default; monthly is fine for slow fields).
5. Choose format (summary, abstract; HTML or text).

PubMed now emails you new hits matching that exact query, every week, forever, for free. You stop going out to look, and the literature comes to you.

> [!tip]
## Two corollaries
- The saved query is version-controlled. You can re-run it six months later and reproduce the result set (allowing for new records), and you should paste the run date in your Methods alongside the query.
- You can have many alerts. I keep one per ongoing project plus a small number of *watch* alerts for fields I am not in but want to track. Five or six total is sustainable; thirty is noise.

## The eight-step recipe, on one page

![The full recipe, from a clinical question to references in Zotero with new evidence arriving by email. Adapt it; do not memorise it.](notes/pubmed/figures/search-recipe.svg){fig-align="center"}

The recipe is mechanical on purpose. Most of the variance in *which* papers you find sits in steps 2 and 3 (the MeSH lookup and the block design). Steps 5–7 are administrative. Step 8 is what makes the whole thing worth doing again next week.

## Beyond PubMed: what to add, when

PubMed indexes MEDLINE plus PubMed Central plus a few smaller streams. It is the right default for most clinical questions, and not enough for some.

*Embase* (Elsevier, subscription) substantially overlaps with MEDLINE but indexes around 2,000 journals MEDLINE does not, with stronger pharmacology coverage, and adds 10–20% unique records for most systematic-review questions [@bramer2017optimal]. If your institution has it and you are writing an SR, use it. For a working clinical search it is usually not worth the extra effort.

The *Cochrane Library* is the right place to look for a Cochrane systematic review on your question *before* you start searching. If one exists and is recent, your search may already be done.

*Google Scholar* is excellent for citation chasing: forward citations of a key paper, and adjacent literature you would not have found otherwise. It is weak for systematic search because the ranking is opaque, there is no controlled vocabulary, and the filters are not reproducible. Use it as a second look, never as the only source.

*Preprints* on bioRxiv and medRxiv now surface inside PubMed via the NIH Preprint Pilot. Treat them as candidates rather than evidence (they have not been peer reviewed) and flag them as preprints in any synthesis.

*ClinicalTrials.gov* covers ongoing studies, recruitment status, and protocols. It is especially useful when the published literature seems thin: the trials may exist, just not yet reported.

## AI scouts: useful, never authoritative

A new layer of tools sits between you and the underlying databases. They help with discovery; they do not replace citations.

![What the major AI scouts are actually good at, and where the PubMed verification step has to sit. The arrow back from Undermind to PubMed is illustrative; *every* scout output gets verified, not just one.](notes/pubmed/figures/ai-vs-pubmed.svg){fig-align="center"}

*Elicit* is good at extracting structured fields (sample size, outcome, effect estimate) across hundreds of papers from one natural-language question. It is useful for first-pass scoping.

*Consensus* aggregates whether the literature points yes, no, or mixed for a specific factual question. It is useful for *"is X associated with Y?"* style questions during background reading.

*Undermind*, Elicit Notebook, and similar iterative deep-search agents run for minutes and walk the citation graph in ways a single PubMed query cannot. They are best for hard, low-prior questions where you do not yet know the right vocabulary.

*Research Rabbit*, Connected Papers, and Inciteful are citation-graph visualisers. Drop in a seed paper, see its backward and forward neighbourhood. They are excellent for finding the *prior* paper you should have started from and the *more recent* paper that supersedes your seed.

*scite* classifies citations as supporting, contrasting, or mentioning. It is useful when a paper is widely cited and you want to know whether subsequent work agrees with it.

ChatGPT, Claude, and Gemini without a retrieval layer are best treated as brainstorming partners rather than bibliographies. Their citations are the highest-risk category.

> [!warning]
## The non-negotiable
Every reference an AI tool surfaces gets verified in PubMed via the Single Citation Matcher before it enters Zotero. Every one. Skip this step and you will eventually ship a fake citation in a real paper.

## Exporting to Zotero

The handoff from PubMed to your reference manager should be a one-click action you do not think about.

- From a PubMed *search result page*: tick the records, click *Send to → Citation manager*, save the `.nbib` file, drag it onto Zotero. All metadata, including MeSH, is preserved.
- From a *single record page*: with the [Zotero Connector](https://www.zotero.org/download/) browser extension installed, click the Zotero button in the toolbar. The record goes into your library in the currently selected collection.
- From an *alert email*: click through to PubMed, then *Send to → Citation manager*, same flow.

See [Using Zotero](/notes/zotero/) for the rest of the workflow: collections, tags, annotation, and citation in Quarto or Word.

## A worked example, end to end

Question: *"In children with persistent asthma, do daily inhaled corticosteroids reduce exacerbations compared with as-needed ICS-formoterol?"*

1. **PICO**: P = children with persistent asthma; I = daily ICS; C = as-needed ICS-formoterol; O = exacerbations.
2. **MeSH lookup**: `Asthma`, `Child`, `Adrenal Cortex Hormones`, `Administration, Inhalation`, `Formoterol Fumarate`.
3. **Blocks**:

```text
#1  "asthma"[MeSH] OR "asthma"[tiab]
#2  "child"[MeSH] OR "children"[tiab] OR "paediatric"[tiab] OR "pediatric"[tiab]
#3  ("adrenal cortex hormones"[MeSH] OR "inhaled corticosteroids"[tiab] OR "ICS"[tiab])
    AND ("administration, inhalation"[MeSH] OR "inhaled"[tiab])
#4  "formoterol fumarate"[MeSH] OR "formoterol"[tiab] OR "MART"[tiab] OR "SMART"[tiab]
```

4. **Combine**: `#1 AND #2 AND #3 AND #4`.
5. **Filter**: `randomized controlled trial[pt] OR systematic review[pt]`, `2015:2026[dp]`, `english[la]`.
6. **Save to MyNCBI**, name `paeds-asthma · daily-ICS-vs-MART · 2026`, weekly alert.
7. **Export** the current hit set as `.nbib`, drop into Zotero, into a collection called `2026 — paeds asthma daily vs MART`.
8. **Read.** This is the part the tools cannot do for you.

## How to know your search is good

A search is good enough when:

- It returns a set you can hand-screen in a reasonable time. For a working clinical search, 50–200 hits is normal; 5,000 means you have not narrowed enough; 3 means you have over-narrowed.
- The set includes the seed paper you already knew about. If it does not, the query is broken; fix it before trusting the rest.
- Re-running the query the next day returns roughly the same set. Wild swings mean a filter is unstable, or an ATM mapping has shifted.
- A colleague can re-run the query from your Methods section and reproduce your hit count to within a few records.

If you cannot say yes to all four, the search is not done.

## Closing

The original 2011 paper [@jacinto2011searching] closed with a paragraph about RSS feeds and saved searches in MyNCBI. RSS is mostly gone; MyNCBI is still there, doing the same job, with a different button. The mechanics get re-skinned every few years. The discipline (frame the question, build the blocks, save the query, verify the references) is the part that survives.

If this is the only literature note you read, take three things home: open Search Details every time, save the query in MyNCBI with an alert, and never let an AI-surfaced reference into your library without checking the PMID. Everything else is refinement.

---

*This note supersedes Jacinto T, Morais A, Fonseca JA. How to write a scientific paper — searching and managing biomedical information. Rev Port Pneumol. 2011;17(4):190-194 [PMID 21680136](https://pubmed.ncbi.nlm.nih.gov/21680136/).*

## References {.unnumbered}

::: {#refs}

