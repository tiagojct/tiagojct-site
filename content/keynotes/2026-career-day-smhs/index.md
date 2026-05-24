---
title: AI and Digital Tools for Professional Performance
date: '2026-05-21'
venue: Career Day '26, Santa Maria Health School (SMHS)
location: Porto, Portugal
description: A hands-on workshop for bachelor's students in Nursing, Physiotherapy, and Occupational Therapy on choosing, using, and limiting AI tools for employability and professional practice — with
  a ready-to-use prompt library and a curated resource list.
slides: https://careerday2026.tiagojct.eu/slides.html
video: ''
handout: https://careerday2026.tiagojct.eu/recursos.html
event-page: https://careerday2026.tiagojct.eu
language: Portuguese (pt-PT)
license: CC BY 4.0
tags:
- AI in health
- Digital health
- Health professions education
- Workshop
- AI tools
- Digital health
- Professional development
- Health professions
- GDPR
- Prompt engineering
draft: false
---

<header class="talk-header">

<span class="type-badge">Workshop</span>
<span class="talk-venue">Career Day '26, Santa Maria Health School (SMHS)</span>
<span class="talk-location">Porto, Portugal</span>
<span class="talk-language">Portuguese (pt-PT)</span>

</header>

Event microsite: [careerday2026.tiagojct.eu](https://careerday2026.tiagojct.eu) (slides + handout with the full prompt library and resource list).

The students in this room are entering health professions at a moment when every clinical workflow they learn will have an AI-adjacent version: a documentation assistant, a risk-scoring tool, a translation service, a literature summary. The question is not whether to engage with these systems. The question is how to engage with them without surrendering either clinical judgment or professional ethics.

The workshop runs in two sessions of one hour each, with groups of 30–35 final-year students from Nursing, Physiotherapy, and Occupational Therapy. The structure is three blocks: employability tools (CV feedback, interview preparation, cover letters, portfolio), professional performance tools (literature search, clinical documentation, guideline study, cross-language communication), and ethical limits (GDPR, hallucinations, algorithmic bias). Each block includes live demonstrations and one hands-on exercise.

Prompts in the live exercises follow a *P·T·T* skeleton (Papel, Tarefa, Tom — role, task, tone), the simplest scaffold I have found for students writing their first deliberate prompts.

The central argument across all three blocks is the same: the advantage is not knowing that a tool exists. The advantage is knowing when to use it, how to write a prompt that produces a useful output, and when to stop and verify (or refuse).

---

## Tools by category

### Employability

**[ChatGPT](https://chatgpt.com)** — General-purpose AI assistant; strong for text tasks such as CV feedback in a recruiter role, cover letter drafting, and interview role-play.\
Free (limited) / Plus €20/month.\
*GDPR: US-based (OpenAI). Inputs are used for training by default — disable in Settings → Data Controls → Improve the model for everyone. Never enter patient data.*

**[Claude](https://claude.ai)** — General-purpose AI assistant; tends to follow complex, structured instructions reliably and to state uncertainty more explicitly than most alternatives.\
Free (limited) / Pro €20/month.\
*GDPR: US-based (Anthropic). Not used for training by default. Never enter patient data.*

**[Gamma](https://gamma.app)** — AI-powered slide and page builder; creates a professional portfolio page from bullet points in a few minutes.\
Free (limited) / Paid.\
*GDPR: US-based. Content is processed on Gamma's servers.*

**[Canva](https://canva.com)** — Design platform with AI-assisted templates; useful for portfolio pages and presentation decks.\
Free / Pro ~€13/month.\
*GDPR: GDPR-compliant; data centres in Australia and the US.*

**[NotebookLM](https://notebooklm.google.com)** — Google's AI research assistant that grounds its responses in documents you upload; load a clinical guideline and ask interview-style questions from it.\
Free.\
*GDPR: Google (US). Documents are linked to your Google account. Do not upload documents containing patient data.*

---

### Professional performance

**[Consensus](https://consensus.app)** — Searches and summarises peer-reviewed papers; gives evidence-based answers grounded in the scientific literature rather than generating text.\
Free (limited) / Premium.\
*GDPR: US-based. Searches published papers only — no patient data involved.*

**[Elicit](https://elicit.com)** — Literature research assistant; extracts and synthesises findings across multiple studies, useful for rapid evidence reviews.\
Free (limited) / Plus.\
*GDPR: US-based. Searches published literature only.*

**[NotebookLM](https://notebooklm.google.com)** — Load a clinical guideline and ask for summaries, specific recommendations by evidence grade, or revision questions; answers are anchored to the document you uploaded.\
Free.\
*GDPR: see above — do not upload documents containing patient data.*

---

## Prompt library

Ready to copy. Replace the bracketed placeholders with your own context.

---

**CV feedback in the recruiter role**

```
Assume o papel de recrutador de [profissão] em Portugal. Analisa o seguinte CV e aponta três fraquezas concretas. Para cada fraqueza, reescreve a secção correspondente. O tom deve ser direto e construtivo.

[colar CV aqui]
```

---

**Interview questions and model answers**

```
Vou a uma entrevista para [cargo] em [tipo de instituição]. Gera cinco perguntas difíceis que o painel pode fazer e, para cada uma, uma resposta-tipo de três a quatro frases que destaque competências práticas e experiência relevante.
```

---

**Cover letter from bullet points**

```
Com base nos seguintes pontos, escreve uma carta de motivação para [cargo/instituição]. Tom: profissional mas genuíno. Extensão: máximo uma página A4. Não acrescentes informação que não esteja nos bullets.

- [ponto 1]
- [ponto 2]
- [ponto 3]
```

---

**Plain-language summary for the patient**

```
Reescreve o seguinte texto clínico em linguagem simples, compreensível para um doente sem formação médica. Não omitas informação importante. Usa frases curtas e evita jargão técnico.

[texto clínico]
```

---

**Literature for a clinical decision** *(use in Consensus or Elicit, not in ChatGPT or Claude)*

```
[tipo de doente ou situação clínica]
[intervenção ou decisão em causa]
[resultado clínico relevante]
```

Consensus and Elicit interpret structured queries better than conversational ones. Do not use ChatGPT or Claude for literature searches — they fabricate references with apparent confidence.

---

**Guideline summary** *(use in NotebookLM with the guideline loaded)*

```
Resume esta guideline focando em: indicações principais, contraindicações, recomendações de grau A ou B, e principais alterações face à versão anterior (se mencionadas).
```

---

**Translate and adapt for a non-Portuguese-speaking patient**

```
Traduz a seguinte mensagem para [língua]. Adapta o registo para ser compreensível por um doente sem formação médica. Mantém um tom respeitoso e empático. Não inventes informação que não esteja no texto original.

[mensagem em português]
```

Verify with a native speaker before using in high-stakes clinical communication.

---

## What not to do

**GDPR and professional secrecy.** No information that identifies a patient enters a public chatbot — no name, no date of birth, no record number, no combination of details that could identify a person. This is not a technical precaution; it is a legal requirement under the GDPR, and a violation can be a disciplinary or criminal matter. The rule applies even when the use seems harmless.

**Hallucinations.** AI models produce wrong answers with full apparent confidence and no warning signal. They fabricate references, invent dates and statistics, and describe clinical guidance that does not exist — all in fluent, authoritative prose. Anything with clinical or professional consequences must be verified in the original source. The model is not responsible for an error; you are.

**Algorithmic bias.** Models reflect the data they were trained on. When training data underrepresents a population, the model fails that population — without flagging the failure. The pulse oximetry case illustrates the cost: devices calibrated mainly on lighter skin tones overestimated oxygen saturation in patients with darker skin, a bias that influenced clinical decisions during the COVID-19 pandemic. Before relying on any AI tool in clinical practice, ask: on what population was this developed, on what population was it validated, and is my patient population represented?

---

## Recommended reading

- FMUP AI Governance Proposal *(link to be added when published)*
- Topol, E.J. (2019). [High-performance medicine: the convergence of human and artificial intelligence](https://doi.org/10.1038/s41591-018-0300-7). *Nature Medicine*, 25, 44–56. The most-cited accessible overview of what AI can and cannot do in clinical practice.
- Jacinto, T. (2024). [Implementing AI in health](/essays/ai-health/). tiagojct.eu. The argument for why implementation is harder than the prototype, and what evaluation actually requires.
- Vasey, B. et al. (2022). [Reporting guideline for the early stage clinical evaluation of decision support systems driven by artificial intelligence: DECIDE-AI](https://doi.org/10.1038/s41591-022-01772-9). *Nature Medicine*, 28, 924–933. For when you want to assess whether a published AI system has credible evidence behind it.
