---
title: 'Evaluation methods in health informatics: references and resources'
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-03-06'
date-modified: '2026-03-07'
description: A curated reading and resource list for evaluation in medical informatics, with short practical notes.
image: medtech.webp
lang: en
bibliography: refs-emhi.bib
csl: ../../nature.csl
citation:
  url: https://tiagojct.eu/notes/emhi/
tags:
- Health Informatics
- Evaluation
- AI
draft: false
---

This page brings together the core references I use for the subject Evaluation in Medical Informatics (FMUP, 2025/2026). It is designed as a practical reading map: each section includes key papers or standards and a short note on why they matter for study design, reporting, and implementation.
You can use this as a starting point for your own projects, or as a reference for teachers and students. The list is not exhaustive but focuses on foundational and recent influential works that I find useful in my research and teaching.

You can [download the full bibliography](notes/emhi/refs-emhi.bib)) for use in your own reference manager, or browse the references directly in the text. If you have suggestions for additional resources or comments on the included ones, please [contact me](mailto:tiagojacinto@med.up.pt)).

## 1. Foundations of evaluation in medical informatics

Evaluation in health informatics is not an afterthought; it is part of system design, deployment, and governance. The key frameworks in this section define what should be evaluated, when, and how findings should be reported [@ammenwerth2004; @friedman2022; @nykanen2011; @talmon2009].

- **Strategic framing:** `Ammenwerth et al. (2004)` gives a high-level vision of why rigorous evaluation is essential for safe and effective information systems [@ammenwerth2004].
- **Methodological backbone:** `Friedman and Wyatt` remains a practical conceptual reference for evaluating biomedical information resources [@friedman2022].
- **Operational guidance:** `GEP-HI` translates evaluation principles into implementable recommendations for health informatics projects [@nykanen2011].
- **Reporting quality:** `STARE-HI` helps structure evaluation reports so studies can be interpreted, compared, and reused [@talmon2009].
- **Failure/success factors:** Delphi-based work highlights recurrent socio-technical determinants that affect implementation outcomes [@brender2013].

## 2. Failure cases and lessons learned

Historical failures and bias analyses are crucial because they expose the gap between technical performance and real-world safety [@leveson1993; @han2005; @obermeyer2019; @howe2018; @ratwani2018; @wong2021].

- **Classic safety case:** `Therac-25` remains a foundational case for understanding software-risk propagation in clinical environments [@leveson1993].
- **Implementation harm:** CPOE-related mortality findings show that introducing digital tools can worsen outcomes if workflows are not validated end-to-end [@han2005].
- **Algorithmic inequity:** Racial bias in risk management algorithms demonstrates why external validation and fairness analysis must be mandatory [@obermeyer2019].
- **EHR usability as safety issue:** Usability defects are linked to patient harm, not just clinician inconvenience [@howe2018; @ratwani2018].
- **Generalizability limits:** Proprietary sepsis model validation highlights performance drift across institutions [@wong2021].

## 3. Usability and human factors

Medical informatics systems are adopted and trusted only when they are usable, cognitively manageable, and compatible with clinical work [@brooke1996; @iso9241112018; @lewis2018; @davis1989; @venkatesh2003; @hart1988].

- **Fast benchmarking:** SUS remains the most common rapid usability instrument in health IT evaluations [@brooke1996; @lewis2018].
- **Standards language:** ISO 9241-11 provides shared definitions for usability claims across studies [@iso9241112018].
- **Adoption models:** TAM and UTAUT are useful for explaining acceptance barriers beyond technical quality [@davis1989; @venkatesh2003].
- **Cognitive workload:** NASA-TLX is useful when introducing decision support tools that may increase clinician burden [@hart1988].
- **Current methods landscape:** Recent scoping evidence summarizes which usability methods are most frequently applied in HIT research [@abareshi2025].

## 4. Study design and methods

Sound evaluation requires explicit design choices aligned with causal questions, context constraints, and available data [@creswell2018; @campbell1963; @shadish2002; @bernal2017].

- **Mixed methods:** combining qualitative and quantitative evidence is often necessary for socio-technical interventions [@creswell2018].
- **Experimental logic:** classic experimental and quasi-experimental designs remain central for internal validity [@campbell1963; @shadish2002].
- **Interrupted time series:** one of the most practical approaches for evaluating policy or system rollout effects in routine care [@bernal2017].
- **Evaluation trends:** longitudinal reviews show how health IT evaluation has evolved and where methodological gaps persist [@ammenwerth2005].

## 5. Reporting guidelines (general and AI-specific)

Transparent reporting is the bridge between local projects and cumulative evidence [@hopewell2025; @chan2025; @page2021; @vonelm2007]. For AI-enabled interventions, extensions and AI-specific guidance are now essential [@liu2020consortai; @rivera2020spiritai; @ibrahim2021; @collins2024; @vasey2022decideai; @hernandez2020minimar].

- **General trial/protocol standards:** CONSORT and SPIRIT updates support clearer reporting of randomized studies [@hopewell2025; @chan2025].
- **Review and observational standards:** PRISMA and STROBE remain baseline requirements for evidence synthesis and observational designs [@page2021; @vonelm2007].
- **AI trial reporting:** CONSORT-AI and SPIRIT-AI adapt core standards to AI intervention specifics [@liu2020consortai; @rivera2020spiritai; @ibrahim2021].
- **Prediction model reporting:** TRIPOD+AI extends reporting quality expectations to ML-enabled clinical prediction [@collins2024].
- **Early-stage AI evaluation:** DECIDE-AI and MINIMAR help define minimal reporting content in translational settings [@vasey2022decideai; @hernandez2020minimar].

## 6. Regulation and ethics

Evaluation is also a regulatory and ethical exercise: systems must be clinically useful, lawful, and aligned with societal values [@aiact2024; @mdr2017; @minssen2024; @vardas2025; @who2021ethics; @topol2019; @char2018].

- **Legal framework in Europe:** AI Act and MDR define requirements that directly affect evidence generation and lifecycle monitoring [@aiact2024; @mdr2017].
- **Interpretive guidance:** recent analyses discuss practical implications for digital medical products [@minssen2024; @vardas2025].
- **Ethics baseline:** WHO guidance remains a useful reference for governance principles in AI for health [@who2021ethics].
- **Clinical framing:** perspective papers help connect regulation with real implementation decisions [@topol2019; @char2018].

## 7. Evaluating AI in healthcare practice

For AI to produce clinical impact, evaluation must address usability, deployment context, monitoring, and communication to end users [@sendak2020; @norgeot2020; @nice2019; @coiera2019; @kelly2019; @wiens2019; @keane2018].

- **Communication artifacts:** model facts labels improve transparency for clinical users [@sendak2020].
- **Minimum information checklists:** MI-CLAIM supports reproducible reporting of clinical AI modelling [@norgeot2020].
- **Evidence thresholds:** NICE framework helps stratify evidence needs by digital health technology maturity [@nice2019].
- **Implementation realism:** “last mile” and related papers emphasize the socio-organizational barriers after model development [@coiera2019; @kelly2019].
- **Responsible deployment:** practical principles focus on avoiding unintended harm in production settings [@wiens2019; @keane2018].

## 8. Useful resources and networks

Beyond individual papers, these resources support continuous methodological quality improvement:

- **EQUATOR Network:** central repository for reporting guidance across study designs [@equator2024].
- **TRIPOD resources:** official guidance hub for prediction model reporting [@tripodstatement2024].
- **Risk-of-bias support:** PROBAST and PROBAST+AI for structured critical appraisal [@wolff2019; @moons2025].
- **Emerging LLM reporting:** TRIPOD-LLM extends structured reporting principles to large language model studies [@gallifant2025].

If you are using this list for teaching or project setup, start with sections 1, 4, and 5, then add section-specific references depending on your intervention type.

## Related notes

- [Implementing AI in health: some things I want to preserve](/essays/ai-health/): the philosophical framing that sits behind this reading list.
- [Scientific writing for early-career researchers](/notes/sw/): overlaps substantially with Section 5 (reporting guidelines) and extends into data presentation and the editorial process.

If you have any comments or questions, feel free to [reach out](mailto:tiagojacinto@med.up.pt)).
