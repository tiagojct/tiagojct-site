---
title: AI, digital health, and nursing informatics
date: '2026-05-05'
venue: NurSID 2026
location: Escola Superior de Enfermagem do Porto, Portugal
description: 'A keynote arguing that the AI conversation in healthcare overlooks a foundational competency: data workflow literacy. Walks through cases from nursing practice (spirometry exports built to
  print, ICU datasets hand-offered as malformed spreadsheets) and proposes the AICA framework (Access, Interpret, Communicate, Act), grounded in open tools (Zotero, Git, Quarto), so that nursing becomes
  a co-designer of clinical information systems rather than an end-user of them.'
slides: ''
video: ''
handout: ''
tags:
- Nursing informatics
- AI in health
- Data literacy
- Health professions education
- Keynote
- Nursing informatics
- AI in health
- Data literacy
- Health professions education
draft: false
---

<header class="talk-header">

<span class="type-badge">Keynote</span>
<span class="talk-venue">NurSID 2026</span>
<span class="talk-location">Escola Superior de Enfermagem do Porto, Portugal</span>

</header>

AI in healthcare sits at the top of a competency stack. Below it, clinical informatics: electronic records, coding systems, information exchange. Between the two, a middle layer that is rarely named and almost never taught: the practical capacity to structure data, version analyses, interoperate between formats, and produce reproducible documents. This middle layer is what determines whether the AI sitting on top is a tool or only a patch. Most AI conversations in health start at the top of the stack and never reach the bottom.

AI has already arrived in nursing care under several headings. Decision support (fall risk, deterioration alerts, triage prioritisation). Continuous monitoring (wearables, bed sensors, cameras). Documentation support (transcription, summarisation, free-text suggestions). Population analysis (cohort building, readmission prediction). Recent reviews give a fair picture of the state of the art. The recurring question across the talk is older than any of these systems: how many of these tools were designed with nurses in the room, and how many were tested with nurses only after they were already finished?

Two cases make the data workflow problem concrete. Spirometry data is born structured at the device, with dozens of variables per test. The standard export is a printed PDF. Years later, when the data are needed for research, computer vision models are trained to extract numbers from images: digital archaeology in place of investigation. ICU dataset hand-offs arrive with title cells merged across rows, logos printed into the first lines, headers repeated mid-spreadsheet, three date formats in a single column, and missing values written interchangeably as dashes, spaces, or the word "unknown". The lesson is the same in both cases. Data workflow literacy changes the cost of everything that happens downstream, in clinical practice and in research alike.

Why does the layer go unnamed? Because the major frameworks underspecify it. IPEC v3 (2023) proposes four interprofessional competence domains, none of them about data. The WHO Global Strategy on Digital Health 2020 to 2025 calls for digital workforce capacitation without saying what to capacitate in. The Topol Review (UK, 2019) recommends digital training for everyone with no operational detail. The AAMC Principles for AI in Medical Education (2025) focus on responsible AI use without touching the data practices that precede it. The talk responds with the AICA framework (Access, Interpret, Communicate, Act), introduced in a preprint at JMIR Medical Education (Jacinto, [doi.org/10.2196/preprints.98383](https://doi.org/10.2196/preprints.98383)). Health professionals usually live in Act, sometimes in Interpret, almost never in Access, where the question of what counts as a datum is decided. The proposed teaching vehicles are open and inexpensive: Zotero for references as structured metadata, Git for version control and provenance, Quarto for reproducible documents that mix prose, code, and data. The point is not to produce specialists in any of these tools; the point is for the underlying ideas to enter the curriculum.

What constrains AI in healthcare is not model capacity. It is the literacy of the people who generate and receive the data, and the collaboration between professionals who are, and are not, in the room when an information system is designed.
