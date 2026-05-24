---
title: 'OpenCode: an AI research assistant in your terminal'
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-03-01'
date-modified: '2026-04-20'
description: OpenCode is an open-source AI coding agent that runs in your terminal with direct access to your files. It supports 75+ models, from frontier Claude and GPT, through free-tier Gemini and Groq,
  down to fully local Ollama. Here is how to use it for health research.
image: cover.png
lang: en
citation:
  url: https://tiagojct.eu/notes/opencode/
tags:
- OpenCode
- AI
- Tutorials
draft: false
---

When you describe your data to an AI assistant in a browser and paste snippets of code, you are working around a fundamental limitation: the assistant cannot see your actual project. It can only work with what you describe. [OpenCode](https://opencode.ai/) removes that constraint.

OpenCode is an open-source AI coding agent that runs inside your terminal and has direct, live access to your file system. It can read every file in your project directory, execute shell commands, create and modify files, and chain these operations together. It is provider-agnostic, supporting 75+ models via [Models.dev](https://models.dev/), from frontier Claude and GPT down to locally-hosted open-weight models, so you can choose the cost, privacy, and quality trade-off that fits your project. The difference is not cosmetic: it changes what the tool can actually do for your research.

## Why an AI agent and not just a chatbot?

If you already paste code and error messages into ChatGPT, Claude, or Gemini in the browser, you are using a large language model as a *chatbot*. OpenCode is different in kind: it is an *agent*, a program that can take several steps on its own, read and write files, run shell commands, and observe the results before deciding what to do next.

For health research, four practical differences matter.

- **It reads your actual files.** A chatbot only sees what you paste into the box. An agent opens `patients.csv`, checks the column names, reads the codebook, and only then answers. Mistakes from misremembered schemas disappear.
- **It runs code, sees the error, and fixes it.** Instead of the copy-paste loop (*"here is my error"* → *"try this"* → *"here is the new error"*), the agent tries a fix, runs the script, reads the traceback, and iterates on its own until the error is gone.
- **It chains steps.** *"Filter to acute MI patients, fit a Cox model, save the output, draft a Results paragraph from that output."* A chatbot writes four replies for you to stitch together; an agent performs four actions and hands you the result.
- **Your project is the memory.** You never re-paste the codebook or the data dictionary at the start of a new session. The agent reads them on demand.

What the agent does *not* fix:

- **Privacy.** By default, the text of every file the agent reads is sent to the model provider's API. For identifiable clinical data this is usually unacceptable. The workarounds are to run a local model (see Ollama, below), to use a synthetic or de-identified extract, or to keep the sensitive files outside the directory where the agent is working.
- **Mistakes.** The agent can delete files, overwrite code, or introduce subtle bugs. Run it inside a [Git](/notes/git/) repository so every change is recoverable with `git diff` and `git checkout`.
- **Cost.** On cloud providers you pay per token. A long session can cost a few euros. Free-tier providers (Google Gemini, Groq) exist for this reason; a local model is fully free after download.

A useful mental model: OpenCode is a research assistant who can read your drive and type on your keyboard, very fast, very cheap, occasionally wrong, and in need of a supervisor. Used well, it collapses the friction between *"I want to do X to this dataset"* and *"X is done, tested, and written up."*

## 1. Prerequisites

OpenCode runs on macOS, Linux, and Windows. Before installing, make sure the following are in place.

### A working terminal

- **macOS**: the built-in `Terminal.app` works; [iTerm2](https://iterm2.com/) is a popular free alternative with better defaults.
- **Windows**: install [Windows Terminal](https://apps.microsoft.com/detail/9n0dx20hk701) from the Microsoft Store.
- **Linux**: whatever shell ships with your distribution.

If you have rarely used a terminal, spend twenty minutes with a short tutorial before installing OpenCode; commands like `cd`, `ls`, and `pwd` will appear constantly in the agent's output, and recognising them speeds everything up. The note [The terminal for health researchers](/notes/terminal/) covers the essentials from a research angle; the [MDN introduction to the command line](https://developer.mozilla.org/en-US/docs/Learn_web_development/Getting_started/Environment_setup/Command_line) is a good generic fallback.

### A package manager for your OS

- **macOS**: [Homebrew](https://brew.sh/). Install with
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
- **Windows**: [Scoop](https://scoop.sh/) (recommended) or [Chocolatey](https://chocolatey.org/). Install Scoop with
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
  Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
  ```
- **Linux**: whichever package manager your distribution ships (`apt`, `dnf`, `pacman`).

A package manager is not strictly required (you can install OpenCode via `npm`, see below), but it is the simplest way to install the other small tools you will want (Node, Ollama, Git).

### Node.js (only if you install OpenCode via npm)

The package-manager routes above do not require Node. If you prefer the cross-platform `npm install` path, you need Node.js 18 or newer. Three easy options:

- Download the LTS release from [nodejs.org](https://nodejs.org/).
- macOS: `brew install node`.
- Windows: `winget install OpenJS.NodeJS`.

Verify with `node --version` and `npm --version`.

### Git (strongly recommended)

OpenCode will modify files in your project. Version control is how you see and undo those changes.

- macOS: already installed after `xcode-select --install`; otherwise `brew install git`.
- Linux: pre-installed on most distributions; if not, install via your package manager.
- Windows: one-click installer from [git-scm.com](https://git-scm.com/).

If Git is new to you, [Git for health researchers](/notes/git/) covers the essentials.

## 2. Installation

Pick one method. The Homebrew and Scoop paths are the simplest on their respective platforms; `npm` works everywhere Node is installed.

### macOS (Homebrew)

```bash
brew install anomalyco/tap/opencode
```

### Windows (Scoop)

```powershell
scoop install opencode
```

Or via Chocolatey:

```powershell
choco install opencode
```

### Anywhere (npm)

```bash
npm install -g opencode-ai@latest
```

### Verify

```bash
opencode --version
```

```
0.3.12
```

## 3. Connecting to a model

OpenCode supports 75+ LLM providers via [Models.dev](https://models.dev/). The quickest path inside the interface is `/connect`, which walks you through authentication and stores credentials at `~/.local/share/opencode/auth.json`. Below are the providers that matter most for health research, ordered from highest quality (and cost) down to fully free.

Configuration lives in `opencode.json`, either at the project root (per-project) or `~/.config/opencode/opencode.json` (global). Keep API keys out of the config file by referencing environment variables with `{env:VAR_NAME}`.

Never commit an API key. Either use the environment-variable pattern shown below, or keep any `opencode.json` that contains secrets out of version control by adding it to `.gitignore`.

### Anthropic (Claude): the strongest default

Create a key at [console.anthropic.com](https://console.anthropic.com) and export it:

```bash
export ANTHROPIC_API_KEY="sk-ant-api03-..."

# Persist it
echo 'export ANTHROPIC_API_KEY="sk-ant-api03-..."' >> ~/.zshrc   # macOS
echo 'export ANTHROPIC_API_KEY="sk-ant-api03-..."' >> ~/.bashrc  # Linux
```

Then point OpenCode at a Claude model in `opencode.json`:

```json
{
  "model": "anthropic/claude-sonnet-4-6",
  "small_model": "anthropic/claude-haiku-4-5",
  "provider": {
    "anthropic": {
      "options": { "apiKey": "{env:ANTHROPIC_API_KEY}" }
    }
  }
}
```

Claude Opus 4.7 is the most capable for long-context code and manuscripts; Sonnet 4.6 is the usual day-to-day choice. `small_model` handles lightweight tasks like title generation.

### OpenAI (GPT)

Create a key at [platform.openai.com](https://platform.openai.com/api-keys), export `OPENAI_API_KEY`, and set:

```json
{ "model": "openai/gpt-5" }
```

### Google Gemini: generous free tier

[Google AI Studio](https://aistudio.google.com/app/apikey) issues API keys with a free tier that is enough for most interactive sessions. Export `GOOGLE_GENERATIVE_AI_API_KEY` and set:

```json
{ "model": "google/gemini-2.5-pro" }
```

### Groq: free tier, very fast inference

[Groq](https://console.groq.com/) runs open-weight models (Llama, Mixtral, Qwen, Kimi) on custom accelerators at several hundred tokens per second. The free tier is generous enough for day-to-day research use.

```bash
export GROQ_API_KEY="gsk_..."
```

```json
{ "model": "groq/llama-3.3-70b-versatile" }
```

### OpenRouter: one key, many models (including free)

[OpenRouter](https://openrouter.ai) aggregates most commercial providers behind a single API key, which is useful when comparing models without juggling credentials. It also exposes several models for free, rate-limited to a few requests per minute; search `:free` on the [models page](https://openrouter.ai/models) for the current list.

```bash
export OPENROUTER_API_KEY="sk-or-v1-..."
```

```json
{ "model": "openrouter/deepseek/deepseek-chat-v3:free" }
```

### Z.AI (GLM): free tier

Create a key at [z.ai/manage-apikey](https://z.ai/manage-apikey). GLM-4.7 is competitive with mid-tier closed models and ships a free tier.

```bash
export ZAI_API_KEY="..."
```

```json
{ "model": "zai/glm-4.7" }
```

### Ollama: local, fully free, offline

For a setup that costs nothing and never sends data to an external API, run [Ollama](https://ollama.com/) and point OpenCode at its local server. This is often the only defensible option for work with identifiable or sensitive clinical data.

```bash
brew install ollama          # or: curl -fsSL https://ollama.com/install.sh | sh
ollama serve &
ollama pull qwen2.5-coder:14b
```

```json
{
  "provider": {
    "ollama": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "Ollama (local)",
      "options": { "baseURL": "http://localhost:11434/v1" },
      "models": {
        "qwen2.5-coder:14b": { "name": "Qwen 2.5 Coder 14B" }
      }
    }
  },
  "model": "ollama/qwen2.5-coder:14b"
}
```

Quality on a 14B-parameter coder model is noticeably below frontier cloud models, but for structured tasks (boilerplate, docstrings, refactors, small debugging) it is often good enough on a modern laptop. A 70B model on a Mac with 64+ GB unified memory approaches mid-tier cloud quality.

Rough guide for choosing a provider: **frontier quality, paying per token** → Anthropic or OpenAI; **free for day-to-day** → Google Gemini or Groq; **offline / privacy-critical** → Ollama. Nothing stops you from switching between them by editing one line in `opencode.json`.

## 4. Starting OpenCode

Always launch from your project directory; that is the context the agent will work within.

```bash
cd my-phd-project
opencode
```

```
  ██████╗ ██████╗ ███████╗███╗   ██╗ ██████╗ ██████╗ ██████╗ ███████╗
 ██╔═══██╗██╔══██╗██╔════╝████╗  ██║██╔════╝██╔═══██╗██╔══██╗██╔════╝
 ██║   ██║██████╔╝█████╗  ██╔██╗ ██║██║     ██║   ██║██║  ██║█████╗
 ██║   ██║██╔═══╝ ██╔══╝  ██║╚██╗██║██║     ██║   ██║██║  ██║██╔══╝
 ╚██████╔╝██║     ███████╗██║ ╚████║╚██████╗╚██████╔╝██████╔╝███████╗
  ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝

  claude-sonnet-4-6 · ~/phd/my-phd-project · build

> 
```

Key controls:

| Key | Action |
|-----|--------|
| `Enter` | Send message |
| `Shift+Enter` | New line |
| `Tab` | Toggle between `build` and `plan` agents |
| `Ctrl+C` | Exit |
| `/clear` | Clear conversation history |
| `/help` | Show all commands |

: OpenCode controls {.striped .hover}

**Two agents, two modes:**

- **build**: full read/write access. Can create and modify files, run commands, execute scripts. Use this for active work.
- **plan**: read-only. Analyses and explains without changing anything. Use this when you want to understand before acting.

Switching between them with `Tab` is a quick way to get a second opinion on what the build agent is about to do.

## 5. Research workflows

The most useful thing about OpenCode for health research is that you can describe what you want in plain language, and the agent will read your actual files before doing anything. These are prompts that work well in practice.

### Explore an unfamiliar dataset

```
I have just cloned the MIMIC-III demo dataset. Explore the folder
structure, read the README, identify the most clinically relevant
tables for a study on ICU readmission, and summarise what each
table contains and how they relate to each other.
```

**What OpenCode produces (condensed):**

```
Read README.md (1,187 lines)
Read 25 CSV files and their schema descriptions

Folder structure
  mimic-iii-demo/
  ├── README.md
  ├── ADMISSIONS.csv        129 admissions,     19 columns
  ├── ICUSTAYS.csv          136 ICU stays,      12 columns
  ├── PATIENTS.csv          100 patients,        8 columns
  ├── DIAGNOSES_ICD.csv   1,761 diagnoses
  ├── LABEVENTS.csv     107,535 lab results
  ├── CHARTEVENTS.csv   758,354 chart entries
  └── ...

Tables most relevant to ICU readmission

  1. ICUSTAYS    — one row per ICU episode. INTIME / OUTTIME bracket
                   each stay; LOS gives ICU length of stay.
  2. ADMISSIONS  — DISCHTIME and DEATHTIME are needed to compute
                   post-ICU survival and the readmission window.
                   ADMITTIME + ADMISSION_TYPE distinguish unplanned
                   from planned.
  3. PATIENTS    — DOB and DOD_HOSP anchor age at admission and
                   death dates for censoring.
  4. DIAGNOSES_ICD — ICD-9 codes per admission. Use these to define
                   the cohort (acute HF, MI, sepsis, etc.).
  5. LABEVENTS / CHARTEVENTS — feed SOFA / APACHE / Elixhauser scores,
                   typically via helper macros.

Join keys
  SUBJECT_ID ─┬─ PATIENTS
              └─ ADMISSIONS ─┬─ HADM_ID ─ ICUSTAYS
                             └─ HADM_ID ─ DIAGNOSES_ICD
                             └─ HADM_ID ─ LABEVENTS
```

Notice what the agent actually did: it opened the files, counted rows, read the schemas, and recovered the relational structure of the data. A browser chatbot can describe MIMIC-III from memory, but it cannot tell you that this particular local copy has 5,204 rows in ICUSTAYS or that CHARTEVENTS weighs in at ~750k rows on your laptop.

### Write analysis code from a description

```
Read the file patients.csv and write a Python script called
cohort_selection.py that applies the following inclusion/exclusion
criteria: age 18–75, primary diagnosis ICD-10 I21 (acute MI),
first admission only, minimum 30-day follow-up. Print a CONSORT-style
flow diagram of exclusions to stdout. Use pandas only.
```

### Fix code that does not work

```
The script cohort_selection.py throws a KeyError on line 34.
Read the script and the data file, diagnose the problem, and fix it.
```

### Debug an R script that broke after a tweak

A very common case for health researchers: your analysis ran last week, you changed one small thing, and now you get an inscrutable R error. Point the agent at the script and the data:

```
I ran sofa_model.R and got the error below. Read the script and
the data file (cohort.csv), find the cause, fix it, and tell me
what you changed.

Error in model.frame.default(...) :
  variable lengths differ (found for 'sofa_score')
```

**What OpenCode does (condensed):**

```
Read file sofa_model.R (247 lines)
Read file cohort.csv (5,204 rows, 23 columns)

Diagnosis
  Line 34 filters the cohort to adults only, assigning the result
  to `cohort_adult` (4,891 rows). Line 52 then fits a Cox model on
  the unfiltered `cohort` (5,204 rows) while referencing
  `cohort_adult$sofa_score`. The two have different lengths, which
  triggers the error.

Fix — sofa_model.R, line 52
  - fit <- coxph(Surv(days, readmit) ~ sofa_score + age, data = cohort)
  + fit <- coxph(Surv(days, readmit) ~ sofa_score + age, data = cohort_adult)

Re-run
  $ Rscript sofa_model.R
  Cox proportional-hazards regression
  n = 4891, number of events = 587
  ...
  Exited with status 0.

Summary
  Root cause: mismatched data frames in coxph() call. Fixed by using
  `cohort_adult` consistently. The model now fits on 4,891 participants
  (adults only); 313 paediatric records previously present in `cohort`
  are excluded, consistent with the study's inclusion criteria.
```

The agent did not guess. It opened the CSV, counted 5,204 rows, saw which rows survive the filter on line 34, and then matched that to the object used on line 52. A browser chatbot cannot do any of those steps without you pasting both files in full.

For a companion on structuring the R project itself (`here::here()`, `renv`, organised sub-folders), see [RStudio: best practices for scientific work](/notes/rst-bp/). The tidier the project, the better the agent performs on it.

### Write a methods or results section from actual output

```
Read the file model_results.txt and write a Results section for a
clinical journal (target: European Heart Journal style). Include all
reported statistics. Use past tense, passive voice where appropriate,
and do not interpret; only report. Save as results_draft.md.
```

### Peer review your own work

```
Read every file in this project — data, scripts, outputs, and the
draft manuscript. Act as a statistical reviewer for a high-impact
clinical journal. Identify: methodological weaknesses, missing
sensitivity analyses, inconsistencies between the reported methods
and the actual code, and any results that require stronger justification.
```

### Generate a reproducibility package

```
Read all scripts in this project and create:
1. A requirements.txt with exact package versions
2. A Makefile with targets: data, analysis, figures, report
3. A REPRODUCE.md explaining how to recreate every result from scratch
4. A .github/workflows/ci.yml that runs the analysis pipeline on push
```

For the GitHub side of the same workflow (pushing the repository, running the CI, and sharing the analysis with co-authors), see [GitHub for health researchers](/notes/github/). For managing the long revision history that tends to come out of agent-driven work, the tools covered in [Advanced Git for research](/notes/advanced-git/) (branches, `bisect`, `stash`) pay off quickly.

## 6. Working with a cloned public dataset

A natural workflow: clone a small public dataset, open OpenCode inside it, and let the agent guide the analysis step by step.

For this example, use Peter Higgins's [`medicaldata`](https://github.com/higgi13425/medicaldata) package: twenty curated teaching datasets published as CSVs and R binaries under a permissive licence. One of them, `strep_tb.csv`, is the 1948 Medical Research Council streptomycin trial for pulmonary tuberculosis, widely taught as the first modern randomised controlled trial. It is small (107 patients), real, and rich in the kind of imperfections that make it useful to reason about out loud.

```bash
git clone https://github.com/higgi13425/medicaldata.git
cd medicaldata
opencode
```

```
  claude-sonnet-4-6 · ~/phd/medicaldata · build

>
```

Then, in stages:

```
Step 1:
Read data-raw/strep_tb.csv. List every column with its type,
number of non-missing values, and a one-sentence description of
what it represents. Separate the columns into baseline
characteristics, intervention, and outcomes, and flag any
ambiguous coding.

Step 2:
Write an R script called strep_tb_analysis.R that:
- Loads data-raw/strep_tb.csv
- Builds a CONSORT-style Table 1 of baseline characteristics by
  treatment arm (streptomycin vs control)
- Fits an ordinal logistic regression of the 6-month radiographic
  outcome on treatment arm, adjusted for baseline condition
  and baseline cavitation
- Saves Table 1 as output/table1.csv and the model coefficients
  as output/model_coefficients.csv
- Writes a short interpretation to output/interpretation.txt

Step 3:
Run the script, read the outputs, and write structured Methods
and Results sections (~250 words each) suitable for a historical
methods journal. Save as draft_section.md.
```

The agent reads the actual column names, data types, and distributions at each step. It is not working from memory, and it will flag any coding ambiguities (for example, the ordered levels of the radiographic-outcome variable) before writing the script.

The `medicaldata` package is a goldmine for teaching. Beyond `strep_tb`, it includes the reconstructed [James Lind scurvy trial](https://github.com/higgi13425/medicaldata) (`scurvy.csv`, 1757), a colorectal polyps RCT, COVID-19 testing data, and a theophylline pharmacokinetics dataset relevant to asthma treatment. Swap the filename in Step 1 to switch topics.

## 7. Non-interactive mode: for pipelines and scripts

OpenCode can also run a single prompt without opening the interactive TUI, which is useful for automated workflows. The command is `opencode run`; `--model` (or `-m`) picks a model, and `--format json` gives structured output for programmatic use.

```bash
# Run a single prompt and print the output
opencode run "Summarise the key findings in results.txt in three sentences"
```

```
The analysis identified 6,841 patients meeting the inclusion criteria, with a
30-day readmission rate of 12.3% (95% CI: 11.5–13.1%). Age (OR 1.03 per year,
p < 0.001) and Charlson comorbidity index (OR 1.21 per point, p < 0.001) were
the strongest independent predictors of readmission. Multiple imputation for
missing SOFA scores did not materially change the primary estimates.
```

```bash
# Pipe output to a file
opencode run "Generate a STROBE checklist for the study described in manuscript.md" \
  > strobe_checklist.md

# Force a specific model for a single call (for example, a free one)
opencode run -m google/gemini-2.5-pro \
  "List all variables in patients.csv with their data types"

# JSON output for programmatic use
opencode run --format json \
  "List all variables in patients.csv with their data types"
```

```json
{
  "variables": [
    { "name": "patient_id",       "type": "string" },
    { "name": "admission_date",   "type": "date (YYYY-MM-DD)" },
    { "name": "discharge_date",   "type": "date (YYYY-MM-DD)" },
    { "name": "primary_icd10",    "type": "string" },
    { "name": "age",              "type": "integer" },
    { "name": "sex",              "type": "categorical (M/F)" }
  ]
}
```

This can be part of a Makefile or a GitHub Actions workflow; for example, automatically generating a plain-language summary of updated results every time the analysis pipeline runs.

---

## Summary

| Use case | What to ask OpenCode to do |
|---|---|
| Unfamiliar dataset | Explore structure, read codebook, map relevant variables |
| Analysis code | Write scripts from inclusion/exclusion criteria or methods descriptions |
| Debugging | Read the script and data, diagnose and fix errors |
| Writing | Draft methods/results from actual output files |
| Review | Act as a statistical reviewer across the whole project |
| Reproducibility | Generate `requirements.txt`, `Makefile`, `REPRODUCE.md` |
| Automation | Non-interactive mode in pipelines or GitHub Actions |

: OpenCode use cases for health research {.striped .hover}

The rule of thumb: if you would normally paste a file into a chat window to get help with it, OpenCode can do the same thing, but with access to all your files at once, the ability to run things, and no copy-paste.

If you have any comments or questions, feel free to [reach out](mailto:tiagojacinto@med.up.pt)).
