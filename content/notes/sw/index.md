---
title: Scientific writing for early-career researchers
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-03-09'
date-modified: '2026-04-30'
description: 'Sentence craft, article anatomy, tables and figures, the editorial process, and the responsible use of AI: a guide for doctoral students and early-career researchers in health.'
image: cover.png
lang: en
bibliography: refs-sw.bib
csl: ../../nature.csl
citation:
  url: https://tiagojct.eu/notes/sw/
tags:
- Scientific Writing
- Academia
- Research
draft: false
---

> [!note]
**This note has been superseded.** [*The Working Draft*](https://tiagojct.eu/working-draft/) is the current, maintained version of this content — expanded chapters, cross-references to the figures material, and ongoing updates. This page is kept for archival purposes.

I have watched brilliant analyses die in badly written discussions. I have also watched unremarkable findings become quietly influential because the paper was clear, honest, and short. The difference is almost never talent; it is discipline, revision, and a willingness to cut what does not earn its place.

Good scientific writing is a set of learnable principles applied with patience, rather than a gift you either have or you don't. William Zinsser put it well: "Clear thinking becomes clear writing: one can't exist without the other" [@zinsser2006writing]. This post distils the core lessons I teach in my scientific writing workshops, aimed at doctoral students across disciplines. It covers the structure of a scientific article, how to write clearly, how to present data effectively, how to handle the editorial process, which reporting guidelines to follow, how to manage references and co-authors, and how to sustain a writing workflow you can live with.

The focus here is the **journal article**. For adjacent tasks in the scientific life-cycle I have written short companion pieces in the *Breathe* journal's *Doing Science* series (on writing conference abstracts [@jacinto2014abstracts], preparing a poster [@jacinto2013poster], giving an oral presentation [@jacinto2014oral], and submitting a funding application [@hardavella2016funding]), and will link to them where relevant below.

Sterk and Rabe argue that writing a paper is itself a form of scientific thinking; the discipline of putting an argument into words forces you to examine whether the argument actually holds [@sterk2008joy]. Do not wait until the analysis is complete before writing. Write as you go.

> [!tip]
## The short version

If you only take away ten things:

1. Write the **one-sentence summary** of your paper before you write anything else.
2. **One idea per paragraph**; topic sentence first.
3. Write the **abstract first**, then the paper, then the title.
4. **Cut ruthlessly.** Aim for one-third shorter in revision.
5. Every estimate gets a **95% CI** and a **p-value**, in that order. Never just p.
6. **Statistical significance is not clinical importance.** State both.
7. **Submit where the finding fits** the readership, not where the impact factor dazzles.
8. Use a **reference manager** from your first week of the PhD.
9. Reviewers are volunteers. **Thank them; respond point by point; never argue, only explain.**
10. Revise, revise, revise. And then, revise.

## Why writing matters

Research that is not communicated effectively might as well not exist. The substance of science goes beyond collecting data; it extends to interpretation and communication [@gopen1990science]. A well-conducted study published in a poorly written paper will struggle to find readers, attract citations, or influence practice. A methodologically sound finding buried in a confusing paragraph may be misunderstood or ignored entirely.

Writing well also matters for practical reasons. Reviewers are busy. Editors skim. Readers decide within seconds whether to keep reading. Every unclear sentence is an invitation to stop.

## The structure of a scientific article

Most scientific articles follow the IMRAD format: Introduction, Methods, Results, and Discussion [@sollaci2004imrad]. This structure is not arbitrary. It mirrors the logic of an investigation: *Why did you do it? How did you do it? What did you find? What does it mean?*

### The hourglass model

![The hourglass arc of a scientific article. The introduction opens broadly and narrows to the objective; methods and results form the narrow waist; the discussion opens back out from the specific finding to its wider implications.](notes/sw/figures/hourglass.svg){width=320 fig-align="center"}

A useful way to think about an article's narrative arc is the hourglass. The introduction starts broad (the general problem), narrows to the specific research question, and states the objective. The methods and results stay narrow and specific. The discussion then broadens again, from interpretation of the specific findings to their wider implications. The abstract compresses this entire arc into a single paragraph.

A concrete example of the arc. The opening sentence of the introduction might be *"Heart failure affects more than 60 million people worldwide and is a leading cause of hospital readmission."* By the end of the introduction, this has narrowed to *"We assessed whether N-terminal pro-B-type natriuretic peptide (NT-proBNP) at discharge predicts 30-day readmission in patients hospitalised for acute heart failure."* The methods and results stay at that level of specificity. The discussion then widens again: *"These findings support risk-stratified discharge planning in acute heart failure, a population in which 30-day readmissions account for a large share of avoidable hospital use."*

Not every discipline uses IMRAD. Qualitative research articles in the social sciences often replace "Results" with "Findings" and dedicate more space to theoretical framing in the introduction. Engineering papers may include a "System Design" section. Short communications in high-impact journals compress everything into a few hundred words. The underlying logic, however, is the same: context, question, method, answer, significance.

If your discipline or target journal uses a non-standard structure, adapt the hourglass proportionally rather than abandoning the logic entirely. Readers still need context, a specific question, a clear method, a direct answer, and an honest discussion of what it means.

### The introduction

The introduction is a funnel: broad context, narrower gap, specific question, clear objective. Four paragraphs is often enough.

1. **Paragraph 1.** State the general problem and why it matters: burden of disease, cost, clinical relevance.
2. **Paragraph 2.** Summarise what is already known. Group similar findings, cite primary sources where possible, and avoid a chronological "review of the literature" that does not move toward a question.
3. **Paragraph 3.** Identify the specific gap or unresolved question. This is the most important paragraph. If a reader finishes it and cannot state what the study is about, the introduction has failed.
4. **Paragraph 4.** State the objective precisely, in one sentence. If relevant, state the hypothesis and the study design.

Two common failure modes. The first is reviewing the field without arriving at a specific question. The second is introducing the findings in paragraph 4; those belong in the results.

### Methods

Another team should be able to replicate your study from the methods section alone. Order the section by study logic:

1. **Design and setting.** Study design (cohort, case-control, randomised trial), setting (hospital, clinic, registry), and recruitment dates.
2. **Participants.** Inclusion and exclusion criteria, how participants were identified, and how they were sampled.
3. **Variables.** Primary outcome, secondary outcomes, predictors, and potential confounders. For each: how it was measured, at what time, and by whom.
4. **Data sources.** Chart review, registry extraction, questionnaires. Quality checks and missingness rules.
5. **Statistical analysis.** Descriptive statistics, the primary model, missing-data handling, sample-size justification, and any sensitivity analyses.
6. **Ethics.** Approving committee and reference number, consent procedure, and registration number if applicable.

If the study follows a reporting guideline, say so in the first sentence: *"This cohort study is reported in accordance with the STROBE statement."* Put the filled checklist in the supplement.

### Results

Describe; do not interpret. Report the numbers in the same order the questions appear in the introduction: recruitment and baseline first, primary outcome next, secondary outcomes, then sensitivity analyses.

Three rules avoid most problems:

- **One paragraph per table or figure.** Introduce the table, describe its message in one or two sentences, highlight the numbers that matter most, and move on.
- **Estimate + 95% CI + p-value, in that order.** Not a p-value alone.
- **No interpretation.** "We found X" belongs in the results; "this suggests Y" belongs in the discussion.

### Discussion

A five-paragraph discussion covers most papers.

1. **Main finding.** Restate the primary result in one or two sentences, in plain language, without numbers.
2. **Comparison with prior work.** Where does this finding agree or disagree with what was already known, and why?
3. **Mechanism or explanation.** Why might the finding be true? Physiological, behavioural, or methodological explanations.
4. **Limitations.** Be specific and honest. Confounders, selection bias, measurement error, generalisability. A vague limitations paragraph signals a lack of critical engagement and is a frequent reviewer complaint.
5. **Implications and next steps.** What does this mean for practice, policy, or the next study?

A discussion that only restates the results is a missed opportunity. A discussion that overreaches (claiming causality from an observational study, generalising from one hospital to all hospitals) is the fastest path to rejection.

When the primary hypothesis is not supported, write the null result honestly. A well-conducted study with a clear negative answer is a contribution, not a failure. State the finding directly (*"we did not find evidence that NT-proBNP improved risk prediction beyond NYHA class and LVEF"*), comment on statistical power, discuss what would be needed to rule out a true effect, and resist the temptation to rescue the story with unplanned subgroup analyses.

Three phrases to avoid in discussions. *"To the best of our knowledge"* is usually unverifiable, and it hedges a claim you probably have not actually checked. *"A trend toward significance"* almost always means p ≈ 0.06--0.10; if the finding matters, report it without the euphemism. Starting every paragraph with *"In this study..."*: three consecutive uses and the reader disengages.

### From thesis chapter to journal article

A PhD thesis chapter and a journal article answer different questions. The chapter proves to examiners that you did the work competently; context, comprehensiveness, and demonstrated mastery matter. The journal article persuades readers that one finding is worth their time; focus, concision, and a clear take-home matter.

Turning a chapter into a paper is mostly subtraction:

1. **Cut to one question.** A chapter may ask three. A paper asks one. Identify the single finding you would be proud to publish on its own, and build around it.
2. **Cut the lengthy methods rationale.** Thesis methods justify every choice at length. A paper's methods describe what was done briefly and cite established approaches.
3. **Cut the field review.** Thesis introductions can run ten pages. A journal introduction runs four paragraphs.
4. **Rework the discussion.** A thesis discussion engages with competing methodologies and theoretical frames. A paper discussion compares the finding with prior work and states implications.
5. **Expect 40--60% reduction.** An 18,000-word chapter becomes a 5,000--7,000-word paper. If the cutting feels violent, it is, and is usually right.

### Titles

Short titles tend to attract more citations [@letchford2015advantage]. A good title is a distilled description of the article: specific enough for electronic retrieval, clear enough to convey the main point, and interesting enough to make someone want to read further. Some journals require the study design to appear in the title, particularly for randomised trials and systematic reviews.

Compare two titles for the same cohort study:

> *"A retrospective cohort analysis of factors associated with clinical outcomes in adult patients admitted for acute heart failure at a tertiary academic medical centre."* (25 words)

> *"NT-proBNP at discharge predicts 30-day readmission in acute heart failure: a retrospective cohort study."* (14 words)

The second tells the reader what was measured, what it predicted, in whom, and the design. The first says almost nothing specific.

Literary precedent helps. *Moby-Dick* [@melville1851mobydick] is two words; one object, instantly specific. A short title is not a vague one.

### Abstracts

The abstract is the most-read part of any article and the portion indexed in electronic databases. For original research, systematic reviews, and meta-analyses, a structured abstract is usually required [@haynes1990more]. The [ICMJE](https://www.icmje.org/) recommends structured abstracts for all medical journals, and most journals require a specific format. CONSORT for Abstracts and PRISMA for Abstracts specify structured formats for trials and systematic reviews respectively. Regardless of format, every abstract should emphasise what is new, note important limitations, and avoid overinterpretation. Abstracts should not contain references, value judgements ("surprisingly, we observed..."), or figures and tables.

A practical template for writing a structured abstract follows the hourglass logic:

1. **Context** (1--2 sentences): What is the general problem?
2. **Gap** (1 sentence): What is not yet known?
3. **Objective** (1 sentence): What does this study do?
4. **Methods** (2--3 sentences): How?
5. **Main findings** (2--3 sentences): What was found?
6. **Conclusion** (1--2 sentences): What does it mean for the field?

A worked example using the heart failure / NT-proBNP study:

> **Background.** Heart failure is responsible for more than one million hospital admissions per year in Europe, and 30-day readmission rates exceed 20% in several registries *[context]*. Risk stratification at discharge remains imperfect, and few biomarkers combine routine availability with strong prognostic value *[gap]*. **Objective.** To assess whether N-terminal pro-B-type natriuretic peptide (NT-proBNP) at discharge predicts 30-day unplanned readmission in patients hospitalised for acute heart failure *[objective]*. **Methods.** In a retrospective cohort of 5,204 adults discharged from two tertiary hospitals in Portugal between 2018 and 2023, NT-proBNP was measured within 24 hours before discharge. Thirty-day unplanned readmission was ascertained from the national hospital registry. Cox proportional-hazards models were adjusted for age, sex, left ventricular ejection fraction (LVEF), and New York Heart Association (NYHA) class *[methods]*. **Results.** The 30-day readmission rate was 12.3% (95% CI 11.5--13.1%). NT-proBNP ≥ 1,000 pg/mL at discharge was independently associated with readmission (adjusted HR 1.31, 95% CI 1.08--1.59, p = 0.005), with a monotonic gradient across quartiles *[main findings]*. **Conclusion.** In patients hospitalised for acute heart failure, NT-proBNP at discharge identifies those at highest 30-day readmission risk and may support targeted post-discharge follow-up *[conclusion]*.

Note what the abstract does and does not do. It states the gap, the objective, and the main finding with numbers. It contains no references, no figures, and no overreach ("may support targeted follow-up" is cautious and accurate). Every sentence earns its place.

A journal abstract is not a conference abstract. Conference abstracts run shorter, sit under tighter character limits, and are judged by a scientific committee deciding whether to accept your talk or poster. I have written a separate piece on the specific conventions for those [@jacinto2014abstracts].

### Plain-language summaries

A growing number of funders (NIHR, Wellcome, Horizon Europe) and journals (*The BMJ*, *The Lancet* group, *PLOS* titles) require a [plain-language summary](https://en.wikipedia.org/wiki/Plain_language) at submission: a short text aimed at patients, the public, policymakers, or clinicians outside the specialty. Lay summaries differ from shortened abstracts on four counts:

- **Reading level.** Aim for a Year-9 / Grade-8 reading age. The two most widely used metrics are the [Flesch--Kincaid readability tests](https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests) and the [SMOG grade](https://en.wikipedia.org/wiki/SMOG). The web-based [Hemingway Editor](https://hemingwayapp.com/) flags long sentences and complex phrases at a glance. For a reproducible score on plain-text or Quarto source, the R package [`quanteda.textstats`](https://quanteda.io/reference/textstat_readability.html) and the Python package [`textstat`](https://pypi.org/project/textstat/) compute a dozen readability indices, including Flesch--Kincaid and SMOG.
- **Vocabulary.** Replace jargon. *"NT-proBNP"* becomes *"a blood marker of heart strain"*; *"multivariable Cox model"* becomes *"statistical analysis that accounts for age, sex, and other factors"*. A basic awareness of [health literacy](https://en.wikipedia.org/wiki/Health_literacy) helps: a large share of the general public reads below the grade level at which most medical prose is written.
- **Structure.** Four questions, in this order: What did we do? Why does it matter? What did we find? What does it mean for people?
- **Length.** 150--250 words is typical; some journals specify 100.

Write the lay summary after the abstract is stable, not before. Test it by reading it to someone outside healthcare; if they cannot restate the main point in their own words, it is still too technical.

Approximate Flesch--Kincaid grade levels, for calibration:

- Children's picture book: Grade 1--3
- Hemingway, *The Old Man and the Sea*: Grade ~4
- Quality newspaper feature: Grade 10--12
- *Moby-Dick* [@melville1851mobydick], chapter 1: Grade ~10, with short sentences and famously rich vocabulary
- Typical biomedical research article: Grade 14--18
- **Lay summary target: Grade 6--8.**

Plain-language summaries sit within a broader shift toward [patient and public involvement](https://en.wikipedia.org/wiki/Patient_and_public_involvement) (PPI) in research: co-designing questions, interpreting findings, and communicating results. For practical guidance on building PPI into a study, see Hardavella and colleagues in the *Breathe* *Doing Science* series [@hardavella2015ppi].

### Authorship and responsibility

The ICMJE defines authorship through four cumulative conditions: substantial contribution to conception or design (or data acquisition, analysis, or interpretation); drafting or critically revising the work; final approval of the published version; and accountability for the work's integrity [@icmje2023recommendations]. Activities that alone do not qualify someone for authorship include funding acquisition, general supervision, administrative support, and language editing.

Many journals now require a [CRediT](https://credit.niso.org/) (Contributor Roles Taxonomy) statement at submission, listing each author's contribution against fourteen standardised roles (*conceptualisation, methodology, data curation, formal analysis, writing – original draft, writing – review and editing*, and so on). CRediT complements the ICMJE criteria rather than replacing them: it describes *what* each author did, while ICMJE defines *who* qualifies as an author. Fill the CRediT form together with all authors before submission, not after; disputes about contribution are much harder to settle post-hoc. For a practical companion on getting credit for scientific work more broadly (ORCID, author contributions, and credit disputes), see Caudri and colleagues in the *Breathe* *Doing Science* series [@caudri2015credit].

This matters more than ever in the age of generative AI. Large language models cannot be listed as authors because they cannot be held responsible for the accuracy, integrity, and originality of the work. Authors must disclose AI use, review AI-generated outputs carefully, and remain accountable for everything in the manuscript [@icmje2023recommendations].

### Using AI tools responsibly

Large language models are now routinely used for language editing, rewriting, summarising, and drafting. The useful question is no longer whether to use them but how to use them without compromising integrity. A working rule for disclosure:

- **Language editing** (grammar, concision, register) usually does not require a formal declaration unless the journal specifies otherwise, but an acknowledgement is always safer.
- **Content generation** (drafting a paragraph, summarising the literature, producing methods text, suggesting interpretations) must be disclosed, even if the authors edited heavily after.
- **Data analysis or figure generation** (code produced by an LLM, figures produced by image models) must be disclosed and is increasingly scrutinised by editors.
- **Fabricating citations or results** is misconduct. LLMs produce plausible but non-existent references; check every citation the model suggests against the primary source.

Disclosure rules tell you *what to declare*. They do not tell you *when in the writing process* to bring the tool in. Trainees in particular need a stricter rule, because the act of drafting is itself the skill the supervisor is trying to assess. A four-tier taxonomy I have proposed elsewhere [@jacinto2026ai] sorts AI use by the cognitive nature of the task:

| Tier | Task                                                                | When acceptable during training              |
|:----:|---------------------------------------------------------------------|----------------------------------------------|
| 1    | Mechanical edits on your own text (grammar, formatting, synonyms)   | Any stage                                    |
| 2    | Restructuring text you already wrote (translation, compression)     | After a complete first draft                 |
| 3    | Generating substantive content (introduction, discussion, lit review) | Only after an unassisted first draft exists |
| 4    | Fabricated references, ghost-authored sections, unverified claims   | **Prohibited always**                        |

The sequencing rule that makes this work: for Tier 2 and Tier 3 tasks during training, the cognitive work of drafting must happen *before* the tool touches the text. A trainee who outsources the first draft has not practised the act the supervisor is trying to assess, and will not learn from the revision either, because the model's prose is not theirs to revise.

A model disclosure sentence that fits most manuscripts:

> *"During the preparation of this work, the authors used [tool/model] for [language editing / rephrasing / code suggestions]. After using this tool, the authors reviewed and edited the content as needed and take full responsibility for the final manuscript."*

On peer review, most publishers now prohibit pasting manuscripts into public LLMs during review because it may leak unpublished work. Read the publisher's policy before reviewing with AI assistance. When in doubt, do not.

## The art of clear writing

The core purpose of scientific writing is not the presentation of information but its *communication* [@gopen1990science]. Converting data into sentences is not enough. What matters is whether the reader accurately perceives what you intended.

### Think first, write second

Writing becomes much easier when you separate thinking from writing. Jari Saramäki argues that "you cannot and should not compensate for bad science with good writing" [@saramaki2022write], but the reverse is also true: good science deserves good writing. Before writing a single sentence, clarify the key message, the logical order of your argument, and the role of each paragraph.

A practical discipline: write the one-sentence summary of the paper before writing anything else. Who was studied, what was measured, and what was found, in one honest sentence. If you cannot reduce the finding to that length, the argument is not yet clear enough to write about. Saramäki [@saramaki2022write] and Heard [@heard2016scientist] each recommend a version of this discipline under different names (the journalistic term is "nut graf"). The name varies; the practice does not.

### One idea per paragraph

Every paragraph should make exactly one point. The first sentence (the topic sentence) announces that point. The remaining sentences support, elaborate, or qualify it. If a paragraph wanders into a second idea, split it. If two consecutive paragraphs make the same point, merge them.

Transitions between paragraphs matter as much as the paragraphs themselves. The reader should always know why they are reading the current sentence and where the argument is heading.

An example. The paragraph below tries to carry three ideas at once: a finding, a mechanistic interpretation, and a limitation:

> *"NT-proBNP at discharge was the strongest independent predictor of 30-day readmission (adjusted HR 1.31, 95% CI 1.08--1.59), which is consistent with the physiology of persistent congestion in acute heart failure. However, we did not measure dietary sodium intake, which could confound this relationship. Clinicians may want to use NT-proBNP as a discharge risk-stratification tool, particularly in patients with reduced ejection fraction."*

Split into three paragraphs (one per idea), the reader can follow each thread. Paragraph one states the finding. Paragraph two explains what prior physiological work suggests. Paragraph three separately acknowledges the limitation. The word count barely changes; the clarity does.

### Stress and topic positions

Readers naturally emphasise the material that arrives at the end of a sentence: what Gopen and Swan call the *stress position* [@gopen1990science]. Place your most important information there. The beginning of the sentence (the *topic position*) should provide context and connect to what came before.

Compare:

> *"Furosemide was given to patients with decompensated heart failure."*

> *"Patients with decompensated heart failure received furosemide."*

The first sentence sits "furosemide" in the topic position and lands the stress on the patient population; the second flips the emphasis onto the drug. Neither is inherently better; the choice depends on what the paragraph is about and what the next sentence will say. Pick the version whose stress position hands off to the next sentence.

A second pair, where the choice is less neutral. The same finding, written two ways:

> *"Of the 142 participants enrolled, alpha-synuclein levels were significantly higher in patients with REM sleep behaviour disorder."*

> *"Among 142 participants, those with REM sleep behaviour disorder had significantly higher alpha-synuclein levels."*

The first sentence ends on the participant count (a bookkeeping detail) and buries the finding in the middle. The second ends on the finding, which is what the reader will carry into the next sentence and what the paragraph is presumably about.

### Active voice (mostly)

Active voice is almost always clearer than passive voice. "We recorded vital signs every 15 minutes" is sharper than "Vital signs were recorded every 15 minutes." A useful editing trick: if you can insert "by zombies" after the verb and the sentence still makes grammatical sense, it is in the passive voice.

The exception is the methods section, where the passive voice is conventional and appropriate: "Participants were recruited from three hospitals." The focus there is on the procedure, not the researchers.

Compare the two methods sentences below; both are passive and both are correct for the methods section:

*"Participants were included if they met the following criteria: age ≥ 18 years, hospitalisation with a primary diagnosis of acute heart failure (ICD-10 I50), LVEF measured during admission, and survival to hospital discharge."*

The passive voice here keeps the focus on the inclusion logic. Switching to "We included patients who met..." would not be wrong, but in a busy methods section, passive voice reduces noise.

### Cut ruthlessly

Scientific writing improves most through subtraction. A few common patterns to eliminate:

- **Unnecessary words**: "many in number" → "many", "blue in colour" → "blue", "at this moment in time" → "now".
- **Nominalisations**: turning verbs into nouns adds length without adding meaning. "We gave much consideration to" → "We considered."
- **Indirect language**: "It was observed in our department that early beta-blocker initiation reduced readmissions..." → "We observed that early beta-blocker initiation reduced readmissions..."
- **Double negatives**: "It is not uncommon for patients with heart failure to experience dyspnoea on exertion" → "Dyspnoea on exertion is common in patients with heart failure."
- **"There is / there are" constructions**: "There was a significant increase in 30-day readmissions among older patients" → "Thirty-day readmissions increased significantly among older patients."

Pascal (or perhaps Mark Twain, or Cicero) wrote: "I have only made this letter rather long because I have not had time to make it shorter." The aphorism holds. Concision takes effort.

Melville could afford the cetological digressions of *Moby-Dick* [@melville1851mobydick]; his readers signed up for a novel. Scientific readers did not. Every tangent you keep is attention spent somewhere other than your finding.

A healthcare example. Before:

> *"In this particular study, which was conducted at our institution over a period of five years, we were able to observe that there was a statistically significant increase in the rate of 30-day hospital readmissions among patients who were discharged following hospitalisation for acute heart failure with NT-proBNP concentrations that were elevated in comparison to those patients whose NT-proBNP concentrations were lower."* (63 words)

After:

> *"Between 2018 and 2023, patients discharged after acute heart failure with higher NT-proBNP were more likely to be readmitted within 30 days."* (23 words)

Same fact. One-third the length. Less noise; no content lost.

Revision is where the real writing happens. A rough draft says everything you know; a final draft says only what the reader needs. Cut the first draft ruthlessly, then cut it again.

### Hedging

Academic writing requires precision about certainty. When you do not have absolute evidence, hedging is appropriate [@hyland1998hedging]. Hedging protects your reputation, conveys honesty, and reflects the genuine uncertainty inherent in most research.

A calibration exercise. The same finding (higher NT-proBNP at discharge is associated with 30-day readmission after acute heart failure, adjusted HR 1.31, 95% CI 1.08--1.59, p = 0.005), stated at three different levels of confidence:

- **Unhedged causal claim.** *"Elevated NT-proBNP at discharge causes 30-day heart failure readmission."*
  A causal claim from an observational design. Not supported by the data.

- **Appropriate.** *"In our cohort, higher NT-proBNP at discharge was associated with 30-day readmission (adjusted HR 1.31, 95% CI 1.08--1.59), independent of LVEF and NYHA class; residual confounding from unmeasured severity cannot be excluded."*
  States the association, the direction, the adjusted estimate, and the design-imposed limit.

- **Over-hedged.** *"It is possible that NT-proBNP might perhaps have some form of weak association with readmission in certain patients, though the data do not definitively establish this."*
  Buries a finding the data clearly support. The 95% CI excludes 1; the p-value is 0.005.

A useful test: if you removed the hedge, would you still be comfortable standing by the claim? If not, the hedge is doing its job. If yes, the hedge may be hiding a finding you should state directly.

> [!warning]
## When hedges hurt

A hedge protects your reputation when the data do not support certainty. It buries your findings when the data do. Hedge the claims that exceed your design. State clearly what the data do support. Readers cannot always tell which you meant; do not leave them guessing.

Vague hedging ("it is thought that", "it is possible that") avoids precision rather than replacing it. A well-hedged sentence names what is uncertain, how uncertain it is, and why: *"Our findings suggest an association, but residual confounding from unmeasured diuretic adherence and dietary sodium cannot be excluded."*

### Abbreviations

Define every abbreviation at first use. Do not use an abbreviation if it appears fewer than three times in the text; the effort of abbreviation is not worth the minimal space saved. The [AMA Manual of Style](https://www.amamanualofstyle.com/) is the standard reference for medical abbreviations.

Ambiguous abbreviations are a genuine risk in clinical writing:

- "MS" could mean multiple sclerosis, mitral stenosis, or mental status
- "BP" could mean blood pressure or British Pharmacopoeia
- "HF" means heart failure in cardiology, but high frequency in audiology or ventilator settings; spell it out at first use in any cross-disciplinary paper
- "COPD" is widely understood, but always spell it out at first use for international readerships
- "IV" could mean intravenous or invasive (as in invasive mechanical ventilation)
- "AMI" could mean acute myocardial infarction or, in chart notes, against medical advice

When in doubt, write it out. A reader from a different specialty or country should never have to guess.

Drug abbreviation errors have caused patient harm. Never abbreviate drug names in clinical documents. Write "insulin" not "INS", "morphine" not "MRP". The [ISMP List of Error-Prone Abbreviations](https://www.ismp.org/recommendations/error-prone-abbreviations-list) is a useful reference for clinical writing, and many journals will not accept drug name abbreviations.

## Presenting data effectively

Readers look at tables and figures before they read the text. Each one must stand alone, legible without flipping back to the methods. Together, they should carry the paper's main message for someone who reads only the abstract, skims the headings, and studies the figures.

### Choosing the right format

The decision is simple.

- **Text** when a result is one or two numbers and no comparison is needed ("Participants were mostly female, 3,300 (83%)").
- **Table** when exact values matter, or when readers may want to compare more than two or three numbers.
- **Figure** when the pattern, distribution, or trend matters more than individual values.

Never repeat the same result across text, table, and figure; most journals will flag duplicate reporting in review.

A worked example of why the format choice matters. The same finding (*"participants were mostly female, 3,300 (83%)"*) plotted as a pie chart and a bar chart:

::: {#fig-overkill layout-ncol=2}

![A pie chart of a single proportion: two slices, one short sentence of information, several seconds of reader effort to estimate the angle.](notes/sw/figures/05-pie-overkill.png){#fig-pie-overkill}

![A bar chart of the same proportion: two bars, the y-axis carries no extra meaning, and the reader still has to read the number off the label.](notes/sw/figures/06-bar-overkill.png){#fig-bar-overkill}

Both charts occupy valuable space to communicate a single number. The sentence *"Participants were mostly female, 3,300 (83%)"* conveys the same information in less space, with no risk of misreading.

Rule of thumb: if a sentence will do the job, let it.

### Tables

Effective tables follow a few consistent rules. Avoid vertical lines. Use horizontal lines sparingly: top, bottom, and under the header is usually enough. Make the legend self-explanatory. Put units in the row or column labels, not in the cells. Keep decimal places consistent and proportionate to how precisely the variable was measured. Report group sizes in the header (`n = 242`) so every percentage is interpretable without arithmetic. Define any abbreviation in a footnote, even if it is already spelled out in the text.

A full worked example. The two tables below carry the same baseline characteristics of a (fictional) acute heart failure cohort, stratified by 30-day readmission. The first would not pass review; the second is close to what most journals expect.

**Avoid:**

| Variable    | Group 1               | Group 2                | p         |
|-------------|-----------------------|------------------------|-----------|
| Age (years) | 72.431 ± 11.89        | 70.112 ± 12.203        | 0.1823    |
| Gender      | 380 males, 260 females| 2,510 males, 2,054 females | 0.234 |
| Bmi         | 28.1 (24--31)         | 27.6                   | 0.45      |
| Smoking     | Yes 22% No 78%        | Yes 19% No 81%         | NS        |
| LVEF        | 34.56789              | 39.2                   | p = 0.000 |
| Mortality   | 82/640 (12.812%)      | 371/4564 (8.129%)      | p<.001    |

Problems: spurious precision (`72.431`, `12.812%`); inconsistent labels (`Gender`, `Bmi`); missing units on BMI and LVEF; mixed formats inside a single column; `NS` with no number; `p = 0.000` (no p-value is literally zero); `p<.001` missing both the leading zero and the space around the operator; missing thousands separator in `4564`; group sizes not in the header, forcing the reader to recompute percentages; the category label `Gender` describes a variable that is actually sex at birth, which many journals now distinguish.

**Prefer:**

| Characteristic                           | Readmitted (n = 640) | Not readmitted (n = 4,564) | p        |
|------------------------------------------|----------------------|----------------------------|----------|
| Age (years), mean ± SD                   | 72.4 ± 11.9          | 70.1 ± 12.2                | 0.18     |
| Male sex, n (%)                          | 380 (59.4)           | 2,510 (55.0)               | 0.23     |
| BMI (kg/m²), median (IQR)                | 28.1 (24.6--31.4)    | 27.6 (24.1--31.0)          | 0.45     |
| Current smoker, n (%)                    | 141 (22.0)           | 867 (19.0)                 | 0.09     |
| NYHA class III--IV, n (%)                | 402 (62.8)           | 2,191 (48.0)               | <0.001   |
| LVEF (%), mean ± SD                      | 34.6 ± 11.3          | 39.2 ± 12.6                | <0.001   |
| NT-proBNP at discharge (pg/mL), median (IQR) | 1,820 (950--3,410) | 780 (410--1,510)         | <0.001   |
| eGFR (mL/min/1.73 m²), median (IQR)      | 52 (38--68)          | 64 (49--81)                | <0.001   |
| Prior HF admission, n (%)                | 312 (48.8)           | 1,205 (26.4)               | <0.001   |
| In-hospital mortality, n (%)             | 82 (12.8)            | 371 (8.1)                  | <0.001   |

Improvements: decimals consistent and proportionate to measurement precision; units in the variable labels; `n (%)` for every categorical variable; medians with IQR for skewed variables (BMI, eGFR, NT-proBNP, the latter always reported on a skewed scale); group sizes in the header; p-values reported to two decimals, or `<0.001` when smaller; precise category labels (`Male sex`); rows ordered by a clinically intuitive logic (demographics, anthropometry, behaviour, severity, biomarkers, comorbidity, outcomes).

### Reporting numbers

Precision matters more than volume. A few rules avoid most problems in peer review.

- **Decimals.** Match the measurement precision. Age to one decimal; p-values to two or three; percentages to one decimal when n is small. More digits than the data supports looks unserious (`67.423 years` implies you know age in seconds).
- **p-values.** Two decimals when p ≥ 0.01. Three decimals when 0.001 ≤ p < 0.01. Below that, report `<0.001`. Never `p = 0.000`. Never `NS`; give the actual number so the reader can judge.
- **Estimate + 95% CI with every p-value.** A p-value says whether a difference is unlikely by chance; it does not say whether it is clinically meaningful. Report the estimate (mean difference, OR, HR, RR) with its confidence interval.
- **Statistical significance is not clinical importance.** A finding can be statistically significant and clinically trivial (e.g. *"mean LDL fell by 0.03 mmol/L (95% CI 0.01--0.05, p = 0.002)"* is significant and clinically negligible), or clinically meaningful but not statistically significant in an underpowered study. Use "significant" only when you mean statistical significance, and always pair it with the effect size so the reader can judge.
- **Missing data.** State the denominator for every analysis. If 134 of 5,204 participants have a missing NT-proBNP value, say so (`NT-proBNP available for 5,070 of 5,204 patients, 97.4%`) and describe how you handled the missingness (complete-case, multiple imputation). STROBE item 12 covers this.
- **Units.** SI units for laboratory values (μmol/L, mmol/L) unless the target journal specifies otherwise, and consistent throughout the paper.

### Graphs

The principles of good data visualisation are rooted in Edward Tufte's core insight: maximise the ratio of data to ink, and eliminate everything that does not help the reader understand the data [@tufte2001visual]. Common errors include truncated axes that exaggerate small differences, dual y-axes that create misleading visual correlations, unnecessary 3D effects, and pie charts with too many categories. Avoid bar charts for continuous outcomes; a boxplot, violin plot, or strip plot shows the distribution, not just the mean with an error bar.

Claus Wilke's taxonomy of bad figures is useful here [@wilke2019fundamentals]. An *ugly* figure has aesthetic problems but is otherwise clear. A *bad* figure has problems related to perception: it is confusing, misleading, or overcomplicated. A *wrong* figure is mathematically incorrect. All three deserve attention during revision.

Accessibility matters. Roughly 8% of men have some form of colour vision deficiency [@birch2012diagnosis]. Use colour palettes designed for universal readability ([viridis](https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html) and [ColorBrewer](https://colorbrewer2.org/) are reliable choices), and do not rely on colour alone to distinguish categories. Duplicate colour distinctions with shape, line style, or pattern.

The same fictional heart failure data, plotted four different ways, shows each failure mode and a publication-ready counterpart.

::: {#fig-wilke layout-ncol=2}

![**Ugly.** Harsh red/green defaults, lowercase axis labels, no units. Accurate, but unpublishable.](notes/sw/figures/01-ugly.png){#fig-ugly}

![**Bad.** Bar chart with SD error bars on a right-skewed biomarker. The distribution is log-normal; the bars imply a symmetric sampling distribution that does not exist here.](notes/sw/figures/02-bad-bar.png){#fig-bad-bar}

![**Bad.** A truncated y-axis turns a ~15% true difference (1,000 vs 1,150 pg/mL, clinically modest) into what looks like a 4-fold effect. The same numbers on a zero-anchored axis would look unremarkable.](notes/sw/figures/03-bad-truncated.png){#fig-bad-trunc}

![**Good.** Boxplot with jittered raw data, log-scaled y-axis (appropriate for a right-skewed biomarker), accessible two-colour palette, and a caption that makes the figure self-contained.](notes/sw/figures/04-good.png){#fig-good}

NT-proBNP at discharge by 30-day readmission status (simulated). Panels A, B, and D share the same cohort (n = 200 per group); panel C uses a separate, deliberately modest scenario to isolate the truncation effect. Source code: [`figures.R`](figures.R).

### Figure legends

Figure legends are part of the figure, not the text. A reader who sees only the figure must understand what it shows, on whom, and how it was analysed. A complete legend includes:

- a short title (what is being shown);
- a description of groups or conditions (what each colour, line, or symbol means);
- the statistical test, and which groups are being compared;
- the sample size for each group;
- definitions of any abbreviations or symbols.

Keep interpretation out of the legend. *"Kaplan-Meier curves for 30-day readmission after acute heart failure, stratified by NT-proBNP at discharge (above vs below the cohort median). Log-rank test. n = 2,602 per group."* belongs in the legend. *"Showing that NT-proBNP identifies high-risk patients at discharge..."* belongs in the results and discussion.

Figures for **posters** and **oral presentations** follow different conventions: larger type, fewer panels, one take-home per slide or panel. I have written short guides on both in the *Breathe* journal's *Doing Science* series: posters [@jacinto2013poster] and oral presentations [@jacinto2014oral].

## The editorial process

![From manuscript to publication. Editorial screening filters submissions in 1--5 days; external peer review takes 4--12 weeks; the decision routes to publication, revisions, or, on reject-and-resubmit, onto a new journal.](notes/sw/figures/editorial-process.svg){fig-align="center"}

### Choosing a journal

Before writing, decide where you want to submit. Consider the journal's scope (does it publish work like yours?), its audience (who will read it?), its impact factor and quartile ranking, average review time, and publication fees [@ecarnot2015writing]. Tools like [JANE (Journal/Author Name Estimator)](https://jane.biosemantics.org/) and the [Scimago Journal Rank](https://www.scimagojr.com/) (which provides free quartile rankings) can help narrow the choice.

Check whether the journal requires open access and what article processing charges (APCs) apply; this is particularly relevant if your institution has a read-and-publish agreement or if you are funded under Plan S, which mandates immediate open access.

A paper is only one part of the research cycle. **Grant applications** share many of the same writing virtues (specific question, clear methods, realistic milestones), but have their own conventions and reviewers. I have written a companion piece on funding applications for the *Breathe* *Doing Science* series [@hardavella2016funding].

A useful journal shortlist has three to five candidates at different impact factor levels. Submitting to the highest-impact journal first is tempting, but submitting to a lower-impact journal where the editors are a better fit for your specific finding often results in faster review and higher acceptance. Speed matters for clinical findings that need to reach practice quickly.

### Predatory journals

Predatory journals accept almost anything for a fee, skip genuine peer review, and can damage the record of authors who publish in them. Warning signs include unsolicited email invitations that praise a paper the sender cannot have read; guaranteed publication in days or weeks; editorial boards with no verifiable affiliations; "impact factor" claims that do not appear in Web of Science or Scopus; and aggressive follow-up emails. A paper in a predatory journal is effectively invisible to hiring and promotion committees, and several funders deduct such publications from track-record assessments.

Two safeguards before submission. Run the journal through the [Think. Check. Submit.](https://thinkchecksubmit.org/) checklist. For open access, confirm the journal is listed in the [Directory of Open Access Journals (DOAJ)](https://doaj.org/). If a senior colleague has not heard of the journal and it is not indexed in PubMed/MEDLINE, treat it as suspect.

### Preprints and open access

Posting a preprint on [medRxiv](https://www.medrxiv.org/) or [bioRxiv](https://www.biorxiv.org/) at the time of submission establishes priority, makes the work citable while the paper is under review, and invites informal community feedback. Most clinical and biomedical journals accept manuscripts that have been preprinted; a few do not. Check the journal's policy on [Jisc's Open Policy Finder](https://openpolicyfinder.jisc.ac.uk/) (the successor to SHERPA/RoMEO) before posting.

Open access comes in two main forms [@piwowar2018state]. *Gold* open access makes the article of record open at publication, usually in exchange for an APC that can be several thousand euros. *Green* open access lets you post the accepted manuscript in an institutional repository, sometimes after an embargo. Check whether your institution has a transformative or read-and-publish agreement that waives or reduces APCs with specific publishers; the [ESAC Initiative](https://esac-initiative.org/) maintains a public registry. If your funding carries [Plan S](https://www.coalition-s.org/) obligations (Wellcome, the ERC, Horizon Europe, and other [cOAlition S signatories](https://www.coalition-s.org/plan-s-funders-implementation/)), immediate open access without embargo is usually mandatory. The [NIH Public Access Policy](https://publicaccess.nih.gov/), revised in 2024 and in effect since 2025, imposes similar requirements on US-funded research.

### Before submission

A manuscript is rarely as good as its authors think. Two steps before submission reduce surprise rejections:

1. **Check against the reporting guideline.** Map every item of CONSORT, STROBE, PRISMA, or whichever applies to your manuscript. Editors do this on receipt, and missing items are the fastest path to desk rejection.
2. **Ask two people who are not co-authors to read it.** One from inside the target journal's readership (does the argument land?) and one from outside the field (is the language clear to a non-specialist?). Give each a specific question, for example *"after reading the abstract, what do you expect the main finding to be?"*, rather than asking for "any thoughts."

Confirm the obvious before hitting submit: author order and affiliations are current; all ICMJE authorship criteria are met; funding, ethics approval, and data-availability statements are present; every table and figure is referenced in the text; the reference list has no broken DOIs.

Realistic timelines for a healthcare paper. First draft to submission-ready: 3--6 months. Submission to first decision: 1--3 months (often longer at high-impact journals). Revision and resubmission: 2--6 months. Acceptance to print: 1--6 months. A "quick" paper in clinical research is typically 12--18 months from idea to PubMed-indexed publication. Plan accordingly.

### Cover letters

Keep cover letters short. State the manuscript title, the main finding, and why it is relevant to this journal's readership. Include the standard declarations (original work, no simultaneous submission, all authors have approved, conflicts of interest disclosed). Two to three paragraphs are sufficient.

A standard structure that works well:

```text
Dear Dr [Editor name],

We would like to submit our manuscript, "NT-proBNP at discharge
predicts 30-day readmission in acute heart failure: a retrospective
cohort study," for consideration for publication in [Journal Name].
We report that NT-proBNP at discharge was independently associated
with 30-day unplanned readmission (adjusted HR 1.31, 95% CI 1.08–1.59)
in a cohort of 5,204 adults hospitalised for acute heart failure,
after adjustment for age, sex, LVEF, and NYHA class.
This finding has direct implications for discharge risk stratification
and post-discharge follow-up planning.

The manuscript is original, has not been published elsewhere, and is
not under consideration at any other journal. All authors have approved
the submitted version. We confirm no conflicts of interest. The study
was approved by [Ethics Committee Name] (approval number: XXX/YYYY).

Please address all correspondence to the corresponding author.
The manuscript is 3,842 words, with 4 figures and 3 tables.

Sincerely,
Tiago Jacinto
```

If the journal's editorial system asks you to suggest reviewers, include three to five relevant experts with their institutional affiliations. Editors appreciate this; it speeds up the editor-in-chief's search and often results in better-matched reviewers than random assignment. Never suggest someone with a conflict of interest.

### Peer review

Systematic external peer review took shape in journals such as *Science* and the *New England Journal of Medicine* in the 1940s and became routine across medicine in the early 1970s [@spier2002history]. It attempts to ensure that published work meets minimum standards of quality, but it is not infallible. Hans Krebs's 1937 paper on the urea cycle was famously rejected by *Nature* before being published elsewhere; many other now-landmark papers have been rejected or heavily revised before publication. This is not failure of the system but evidence that it works imperfectly.

Peer review is a floor, not a ceiling: it filters out obvious errors, not subtle ones. Your responsibility for your own work does not end when reviewers sign off.

### Responding to reviewers

When reviewer comments arrive, pause before responding. Read the comments, wait until any emotional reaction subsides, and then draft a structured, point-by-point response. For each comment: thank the reviewer, state what you changed (with the revised text quoted), and, if you disagree, say so politely and back it with evidence. Reviewers and editors are unpaid volunteers; a clear, well-organised response makes their job easier and improves your chances of a favourable decision.

A worked example. A reviewer's comment and a response that does its job:

> **Reviewer 2, comment 3.** *"The authors do not adjust for estimated glomerular filtration rate (eGFR), which is a well-established confounder of the relationship between NT-proBNP and cardiovascular outcomes. This is a significant omission."*

> **Response.** *"We thank the reviewer for this point. eGFR was available for 5,070 of 5,204 patients (97.4%). We have added it as a covariate in the multivariable Cox model (revised Table 3). The association between NT-proBNP at discharge and readmission was attenuated but remained significant (adjusted HR 1.24, 95% CI 1.03--1.49, p = 0.02). The Methods (page 7, paragraph 2) and Discussion (page 14, paragraph 3) have been updated to describe this analysis and to note that the two variables may share predictive information."*

Three things make this response work. It thanks the reviewer without grovelling. It states exactly what changed, with numbers and page references. It is honest about the analytical consequence (the coefficient attenuated) rather than hiding it.

When you disagree, a respectful template works: *"We appreciate the reviewer's suggestion. We considered this option but, on balance, prefer to retain the original analysis because [specific reason]. We have added a sentence to the Limitations section acknowledging this alternative interpretation."* Never argue; explain.

### Revisions and rejections

Most manuscripts receive *major revisions* on first review. Treat the revision as an extension of the writing process, not a formality. Typical deadlines are four to six weeks. Address every comment in the point-by-point response, even comments you disagree with; silence reads as dismissal.

*Minor revisions* usually mean the editor has decided to accept but wants specific fixes. Turn these around within one to two weeks. This is not the moment to reopen scientific debates.

*Rejection after review* is the common outcome at high-impact journals. Read the reviews carefully; they are free pre-submission feedback for the next journal. Incorporate the reasonable suggestions, choose a new target that fits the finding, and submit within two to four weeks while the work is still fresh in your head.

*Rejection without review* (desk rejection) is not a judgement on the science. It usually means the paper fell outside scope, did not match the audience, or fell below the journal's significance threshold. Do not appeal unless you have a specific, factual error to point out. Move on quickly.

### Reviewing other people's work

Most ECRs are invited to review before they feel ready. Accept invitations that match your expertise and decline (politely, quickly) those that do not. Reviewing well is a skill that grows with practice, and nothing else teaches you faster how editors actually read manuscripts.

A useful review has three parts:

1. **A short summary of the paper.** Two or three sentences in your own words. This confirms to the editor that you read the manuscript and gives the authors a chance to see how a careful reader understood their argument.
2. **Major comments.** The issues that, in your view, would need to change before publication: methodological problems, missing analyses, overreach, unsupported claims. Numbered, specific, and actionable.
3. **Minor comments.** Typographical, stylistic, and sentence-level suggestions. Numbered.

Two conventions matter. Write to the authors, not about them: *"the authors should consider..."* rather than *"the authors failed to..."*. And separate *confidential comments to the editor* (where you make a recommendation and may be candid about fit or significance) from comments sent to the authors.

Expect to spend four to eight hours on a first full review. Claim credit via [ORCID](https://orcid.org/) or the publisher's integration with Web of Science Reviewer Recognition. Reviewing is unpaid work, but it builds editorial judgement that steadily improves your own writing.

## Reporting guidelines

For any study design, consult the relevant reporting guideline before writing. The [EQUATOR Network](https://www.equator-network.org/) maintains a comprehensive database. The most common guidelines in clinical and biomedical research:

| Study design                  | Guideline                                                                          | Scope                                                            |
|-------------------------------|-------------------------------------------------------------------------------------|------------------------------------------------------------------|
| Randomised trial              | [CONSORT](https://www.consort-statement.org/) (2025 update)                        | Individually randomised, parallel-group trials                   |
| Non-randomised intervention   | [TREND](https://www.equator-network.org/reporting-guidelines/trend-statement/)     | Evaluations of non-randomised interventions                      |
| Observational study           | [STROBE](https://www.strobe-statement.org/)                                        | Cohort, case-control, and cross-sectional studies                |
| Systematic review / meta-analysis | [PRISMA](https://www.prisma-statement.org/)                                    | Systematic reviews and meta-analyses of interventions            |
| Study protocol (trial)        | [SPIRIT](https://www.spirit-statement.org/)                                        | Protocols of clinical trials                                     |
| Study protocol (review)       | [PRISMA-P](https://www.prisma-statement.org/)                                      | Protocols of systematic reviews                                  |
| Diagnostic accuracy study     | [STARD](https://www.equator-network.org/reporting-guidelines/stard/)               | Diagnostic test accuracy                                         |
| Prediction model (incl. AI)   | [TRIPOD+AI](https://www.equator-network.org/reporting-guidelines/tripod-statement/) | Development, validation, and updating of multivariable prediction models, including machine-learning models |
| Case report                   | [CARE](https://www.care-statement.org/)                                            | Individual clinical cases                                        |
| Qualitative research          | [SRQR](https://www.equator-network.org/reporting-guidelines/srqr/)                 | Qualitative studies                                              |
| Statistical reporting         | [SAMPL](https://www.equator-network.org/reporting-guidelines/sampl/)               | Statistical analyses and methods, applicable across study designs |

Using the appropriate checklist improves completeness, transparency, and the likelihood of acceptance. Use it as a *writing* guide from the start, not as a pre-submission audit; a manuscript drafted around the checklist is almost always easier to revise than one retrofitted to it.

If you are writing a randomised trial, the CONSORT checklist is mandatory: most journals will not publish without it, and editors will check it. CONSORT 2025 added items on harms reporting, protocol deviations, and handling of missing outcome data. A poorly reported trial is often a poorly conducted one.

## Reference management

Do not track citations by hand. A reference manager keeps metadata, PDFs, annotations, and formatted citations in one searchable library; formatting a reference list that might take hours in Word plus a folder of PDFs takes minutes. [Zotero](https://www.zotero.org/) is the most common choice in healthcare research, with free cloud sync and strong community support. [Mendeley](https://www.mendeley.com/) and [EndNote](https://endnote.com/) are widely used alternatives. All three export to [BibTeX](https://en.wikipedia.org/wiki/BibTeX) (for LaTeX or Quarto) and to most journal styles via [CSL](https://citationstyles.org/).

I have written a longer [note on using Zotero](/notes/zotero/) that covers installation, tagging, collections, annotations, and integration with Word, LibreOffice, and Quarto. The short version for PhD students: pick one tool, commit to it, and import every paper you cite from your first week. A library you trust saves hours in the final weeks before submission, which is where most manuscripts come apart.

## Working with co-authors

Most papers are written by more than one person. A few habits prevent the most common problems.

- **One authoritative version.** Keep a single master file: name it by date or version (`manuscript_2026-04-19_v07.docx`) and make sure every co-author knows which file is current. Better still: use a collaborative editor (Google Docs, Overleaf) or a plain-text, version-controlled setup. My own workflow is Markdown in [Zettlr](/notes/zettlr/) with [Git](/notes/git/) for versioning and Quarto for rendering; Pandoc (used under the hood by both Quarto and Zettlr) exports the same source to Word (`.docx`) in a single command, so co-authors who live inside Microsoft Word can still receive a tracked-changes copy to mark up.
- **Track changes, then clean copy.** Circulate drafts with track changes on. When a section is settled, accept all changes and carry the clean text forward. Never circulate tracked and clean copies simultaneously; it invites version drift. If the manuscript lives in Markdown or Quarto, Git serves the same purpose: each commit is a version, and `git diff` shows exactly what changed between drafts. For longer revision cycles, the tools in [Advanced Git for research](/notes/advanced-git/) (`stash`, `bisect`, branches) earn their keep.
- **Explicit deadlines.** *"Please send comments by Friday 3 May, 12:00 Lisbon time"* works better than *"when you have time"*. Silence after a stated deadline counts as consent.
- **Merge by meeting, not by stitching.** When two co-authors give contradictory suggestions on the same paragraph, resolve it in a 15-minute conversation rather than trying to honour both. Stitched compromises read poorly.
- **Escalate judiciously.** If a supervisor and a senior co-author disagree, the corresponding author decides and documents the reasoning in writing so the same argument does not recur at resubmission.

Writing with good co-authors is the single largest accelerator of a scientific career. Writing with poor or absent ones is a slow, private trauma. Pick carefully, and be the kind of co-author you wish you had.

## A writing workflow

Advice drawn from Saramäki [@saramaki2022write] and Heard [@heard2016scientist]:

1. **Choose your key result.** Condense it into one or two sentences. This is the nucleus of your paper.

   ::: {.column-margin}
   A weak key result: *"This study looked at heart failure readmissions."*

   A strong key result: *"Among 5,204 adults discharged after hospitalisation for acute heart failure, the 30-day unplanned readmission rate was 12.3% (95% CI 11.5--13.1%). NT-proBNP ≥ 1,000 pg/mL at discharge was independently associated with readmission (adjusted HR 1.31, 95% CI 1.08--1.59)."*

   The strong version tells the reader exactly what was found, on whom, with what precision. If you cannot write a clear one-sentence version, the paper is not ready to write.
   :::

2. **Write the abstract first,** following the hourglass structure. It forces you to clarify the story before writing the full text.
3. **Draft the title.** Short titles work better. Make sure the title and abstract are aligned.
4. **Sketch the outline.** For each section, write one sentence per paragraph stating its point. A twenty-paragraph paper gets twenty sentences; if two say the same thing, merge them, and if one does not connect to the argument, cut it. Choose your figures and draft their captions before writing the results.
5. **Write paragraph by paragraph.** One point per paragraph, topic sentence first. Sketch the paragraph's content before filling it in.
6. **Complete a rough first draft quickly.** Do not revise as you go. A bad draft is progress; an unfinished one is not. Saramäki's version of this principle: your first draft is allowed to be bad [@saramaki2022write]. Get everything down, then revise [@sterk2008joy].
7. **Revise for structure and content.** Is the paper focused? Is there enough context? Does the story answer an important question?
8. **Revise for sentences and words.** Is each sentence clear? Are subject and verb close together? Can you cut anything?
9. **Repeat.** Revise with co-authors. Ask colleagues for comments. Use test readers.

Or, as I tell my students: revise, revise, revise. And then, revise.

> [!tip]
## If you remember one thing

The writers you admire are not smarter than you. They have cut more sentences. Keep writing, keep cutting, keep reading papers you admire. Everything else follows.

## References

::: {#refs}

If you have any comments or questions, feel free to [reach out](mailto:tiagojacinto@med.up.pt).
