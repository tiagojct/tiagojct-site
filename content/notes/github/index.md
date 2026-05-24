---
title: 'GitHub for health researchers: sharing, collaborating, and open science'
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-02-20'
date-modified: '2026-04-20'
description: How to use GitHub to publish your work, collaborate with a research team, and access real public health datasets, with a worked example using COVID-19 data.
image: cover.png
lang: en
citation:
  url: https://tiagojct.eu/notes/github/
tags:
- Git
- GitHub
- Tutorials
draft: false
---

Git tracks your work locally. GitHub takes it further: it backs up your repository online, makes it shareable with collaborators, and (this is the part that often surprises students) gives you direct access to real, continuously updated public health datasets.

This post assumes you are comfortable with basic Git. If you are not, start with the [Git post](/notes/git/) first.

## 1. Authentication

The easiest way to connect to GitHub from the terminal is via the GitHub CLI.

```bash
# Install GitHub CLI
brew install gh            # macOS
sudo apt install gh        # Ubuntu/Debian
winget install GitHub.cli  # Windows

# Authenticate
gh auth login
```

```
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations? HTTPS
? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI? Login with a web browser

! First copy your one-time code: A1B2-C3D4
Press Enter to open github.com in your browser...
✓ Authentication complete.
✓ Configured git protocol
✓ Logged in as tiagojct
```

Follow the prompts. Choose HTTPS when asked, and authenticate via a web browser; it is the least error-prone method.

## 2. Creating and publishing a repository

```bash
# Create a new repo and push your local work in one step
gh repo create my-phd-project --private --push --source=.
```

```
✓ Created repository tiagojct/my-phd-project on GitHub
  https://github.com/tiagojct/my-phd-project
✓ Added remote https://github.com/tiagojct/my-phd-project.git
✓ Pushed commits to https://github.com/tiagojct/my-phd-project.git
```

```bash
# Or add a remote to an existing local repository
git remote add origin https://github.com/username/repo.git
git push -u origin main
```

```
Enumerating objects: 18, done.
Counting objects: 100% (18/18), done.
Delta compression using up to 8 threads
Compressing objects: 100% (14/14), done.
Writing objects: 100% (18/18), 4.21 KiB | 1.40 MiB/s, done.
Total 18 (delta 2), reused 0 (delta 0), pack-reused 0
To https://github.com/username/repo.git
 * [new branch]      main -> main
branch 'main' set up to track 'origin/main'.
```

Start with `--private`. You can make a repository public later. The reverse (making public data private after a mistake) is more complicated.

## 3. Cloning real public health datasets

This is where GitHub becomes a research tool rather than a backup service. Many major health and epidemiology datasets are version-controlled and publicly available.

```bash
# Our World in Data — COVID-19, mortality, disease burden
git clone https://github.com/owid/covid-19-data.git
```

```
Cloning into 'covid-19-data'...
remote: Enumerating objects: 84312, done.
remote: Counting objects: 100% (1204/1204), done.
Receiving objects: 100% (84312/84312), 1.23 GiB | 5.14 MiB/s, done.
```

```bash
# MIMIC — ICU clinical data code and utilities
git clone https://github.com/MIT-LCP/mimic-code.git

# Johns Hopkins CSSE — COVID-19 time series (archived, but canonical)
git clone https://github.com/CSSEGISandData/COVID-19.git

# UK Biobank analysis notebooks
git clone https://github.com/UK-Biobank/UKB-RAP-Notebooks.git

# medicaldata — 20 small teaching datasets as CSVs (good for workshops)
git clone https://github.com/higgi13425/medicaldata.git
```

For a live teaching session, `medicaldata` is often the better first choice: the CSVs in `data-raw/` are small (`strep_tb.csv` is 107 rows, `scurvy.csv` is 12), the cohort is real, and the entire clone completes in under a second.

Cloning gives you the full dataset history. You can see exactly what changed between any two dates, which matters when a dataset gets revised after a paper is published.

### Keeping a cloned dataset up to date

Public health datasets update continuously.

```bash
cd covid-19-data
git pull                   # fetch the latest data
```

```
remote: Enumerating objects: 12, done.
remote: Counting objects: 100% (12/12), done.
Unpacking objects: 100% (7/7), done.
From https://github.com/owid/covid-19-data
   a1b2c3d..f4e5d6c  master -> origin/master
Updating a1b2c3d..f4e5d6c
Fast-forward
 public/data/owid-covid-data.csv | 2440 ++++++++++++++++--
 1 file changed, 2312 insertions(+), 128 deletions(-)
```

```bash
git log --oneline -10      # see what changed recently
```

```
f4e5d6c Update data: 2026-02-20
a1b2c3d Update data: 2026-02-19
9e8d7f6 Update data: 2026-02-18
3c4b2a1 Update data: 2026-02-17
...
```

```bash
git diff HEAD~5 HEAD -- public/data/excess_mortality/   # see data changes
```

```
diff --git a/public/data/excess_mortality/excess_mortality.csv b/public/data/excess_mortality/excess_mortality.csv
index a2b3c4d..e5f6a7b 100644
--- a/public/data/excess_mortality/excess_mortality.csv
+++ b/public/data/excess_mortality/excess_mortality.csv
@@ -14821,6 +14821,7 @@ Portugal,PRT,2026-02-13,...
 Portugal,PRT,2026-02-14,2.3,1.1,...
+Portugal,PRT,2026-02-15,2.1,1.0,...
```

## 4. Worked example: excess mortality analysis

This section walks through a complete workflow from cloning to committing your own analysis on top of a public dataset.

### Step 1: Clone and explore

```bash
git clone https://github.com/owid/covid-19-data.git
cd covid-19-data
ls public/data/
```

```
biofuels/             co2/                  energy/
excess_mortality/     owid-covid-data.csv   testing/
vaccinations/
```

```bash
head -5 public/data/owid-covid-data.csv
```

```
iso_code,continent,location,date,total_cases,new_cases,...,excess_mortality_cumulative_per_million
AFG,Asia,Afghanistan,2020-01-05,,,,...,
AFG,Asia,Afghanistan,2020-01-06,,,,...,
AFG,Asia,Afghanistan,2020-01-07,,,,...,
AFG,Asia,Afghanistan,2020-01-08,,,,...,
```

```bash
wc -l public/data/owid-covid-data.csv
```

```
383412 public/data/owid-covid-data.csv
```

### Step 2: Write and run your analysis

With OpenCode (or any editor), write a script `excess_mortality_europe.py` that:

- Loads `owid-covid-data.csv`
- Filters for Portugal, Spain, France, Germany, Italy, Netherlands
- Extracts weekly excess mortality (`p_scores`) and vaccination rates
- Calculates Pearson and Spearman correlations between vaccination coverage and excess mortality per country
- Saves a summary table as `excess_mortality_table.csv`

### Step 3: Commit only your work

```bash
# Your analysis files are separate from the cloned data
git add excess_mortality_europe.py excess_mortality_table.csv
git commit -m "Add excess mortality analysis — Europe 2021-2023"
```

```
[main 8a3f1c2] Add excess mortality analysis — Europe 2021-2023
 2 files changed, 94 insertions(+)
 create mode 100644 excess_mortality_europe.py
 create mode 100644 excess_mortality_table.csv
```

### Step 4: Publish to your own repository

```bash
gh repo create excess-mortality-europe --private --push --source=.
```

```
✓ Created repository tiagojct/excess-mortality-europe on GitHub
  https://github.com/tiagojct/excess-mortality-europe
✓ Pushed commits to https://github.com/tiagojct/excess-mortality-europe.git
```

The original OWID data stays in its own repository. Your analysis sits cleanly on top, with its own version history.

## 5. Contributing back: forks and pull requests

When you spot an error in a public dataset or want to propose an improvement:

```bash
# Fork via GitHub CLI
gh repo fork owid/covid-19-data --clone
```

```
✓ Created fork tiagojct/covid-19-data
Cloning into 'covid-19-data'...
remote: Enumerating objects: 84312, done.
✓ Cloned fork
```

```bash
# Make your changes on a named branch
git checkout -b fix/portugal-data-correction
```

```
Switched to a new branch 'fix/portugal-data-correction'
```

```bash
# ... edit files ...
git add .
git commit -m "Correct Portugal excess mortality baseline (2015–2019)"
```

```
[fix/portugal-data-correction 2c7e4d1] Correct Portugal excess mortality baseline (2015–2019)
 1 file changed, 6 insertions(+), 6 deletions(-)
```

```bash
git push origin fix/portugal-data-correction
```

```
Enumerating objects: 7, done.
To https://github.com/tiagojct/covid-19-data.git
 * [new branch]      fix/portugal-data-correction -> fix/portugal-data-correction
```

```bash
# Open a pull request
gh pr create --title "Correct Portugal baseline" \
  --body "Fixes calculation error in baseline period"
```

```
https://github.com/owid/covid-19-data/pull/4821
```

This is how open science works in practice: read, use, and, when you have something to contribute, give back.

## 6. Collaborating with a research team

```bash
# Clone a collaborator's repository
git clone https://github.com/supervisor/shared-analysis.git
cd shared-analysis
```

```
Cloning into 'shared-analysis'...
remote: Enumerating objects: 241, done.
Receiving objects: 100% (241/241), 1.84 MiB | 3.12 MiB/s, done.
```

```bash
# Create your own branch
git checkout -b yourname/add-cox-model
```

```
Switched to a new branch 'yourname/add-cox-model'
```

```bash
# After committing your work, push your branch
git push origin yourname/add-cox-model
```

```
To https://github.com/supervisor/shared-analysis.git
 * [new branch]      yourname/add-cox-model -> yourname/add-cox-model
```

```bash
# Open a pull request for review
gh pr create
```

```
? Title: Add Cox proportional hazards model for 30-day readmission
? Body: <Received>
? What's next? Submit
https://github.com/supervisor/shared-analysis/pull/7
```

```bash
# Sync your local branch with changes from the main branch
git fetch origin
git rebase origin/main
```

```
Successfully rebased and updated refs/heads/yourname/add-cox-model.
```

> [!note]
Never commit directly to `main` in a shared repository. Always work on a named branch and open a pull request, even when working alone. It creates a reviewable record that supervisors and collaborators can follow.

### Issues as a research log

Use GitHub Issues to document analytical decisions, not just bugs:

```
Issue #12 — Decision to exclude patients with <6 months follow-up
Issue #15 — Switch from complete-case to multiple imputation
Issue #21 — Sensitivity analysis: restricted to primary care records only
```

Reference issues in commits:

```bash
git commit -m "Implement multiple imputation for missing BMI values — closes #15"
```

```
[yourname/add-cox-model 9b4f2e7] Implement multiple imputation for missing BMI values — closes #15
 1 file changed, 22 insertions(+), 4 deletions(-)
```

This creates a permanent, auditable link between code and analytical decisions. When a reviewer asks *"why did you do it this way?"*, the answer is one click away.

## 7. Advanced: useful tools for longer projects

### Stash: shelve work temporarily

```bash
# You are mid-analysis and need to switch to an urgent task
git stash push -m "WIP: Cox model with time-varying covariates"
```

```
Saved working directory and index state On yourname/add-cox-model: WIP: Cox model with time-varying covariates
```

```bash
# List stashes
git stash list
```

```
stash@{0}: On yourname/add-cox-model: WIP: Cox model with time-varying covariates
```

```bash
# Return to your work
git stash pop
```

```
On branch yourname/add-cox-model
Changes not staged for commit:
        modified:   scripts/cox_model.py
Dropped stash@{0} (c3d4e5f6a7b8...)
```

### Submodules: pin an external dataset to a specific version

```bash
# Add a submodule (locks to the current commit of the external repo)
git submodule add https://github.com/owid/covid-19-data.git data/owid
```

```
Cloning into '/Users/tiago/phd/excess-mortality-europe/data/owid'...
Submodule path 'data/owid': checked out 'a1b2c3d...'
```

```bash
# Others cloning your repo also get the submodule
git clone --recurse-submodules https://github.com/you/your-project.git
```

```
Cloning into 'your-project'...
Submodule 'data/owid' registered for path 'data/owid'
Submodule path 'data/owid': checked out 'a1b2c3d...'
```

```bash
# Update submodule to latest
git submodule update --remote data/owid
git add data/owid
git commit -m "Update OWID data to 2026-02 snapshot"
```

```
[main 5e1c8a3] Update OWID data to 2026-02 snapshot
 1 file changed, 1 insertion(+), 1 deletion(-)
```

This is the right answer to *"which version of the dataset did you use?"*

### GitHub Actions: automated analysis pipelines

Create `.github/workflows/analysis.yml`:

```yaml
name: Run analysis pipeline

on:
  push:
    branches: [main]
  schedule:
    - cron: '0 6 * * 1'   # every Monday at 06:00 UTC

jobs:
  analyse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Run cohort selection
        run: python cohort_selection.py

      - name: Run main analysis
        run: python analysis.py

      - name: Upload results
        uses: actions/upload-artifact@v4
        with:
          name: results
          path: results/
```

This runs your full pipeline automatically on every push, or on a schedule to pick up updated public data.

### README as part of the scientific record

```markdown
# Project Title

Brief description of the research question.

## Data sources

| Dataset | Version | Access | DOI/URL |
|---------|---------|--------|---------|
| OWID COVID-19 | 2026-01-15 | Public | github.com/owid/covid-19-data |
| Local cohort | N/A | Restricted | — |

## Reproducibility

All analyses were run with Python 3.11. To reproduce:

    git clone https://github.com/you/project.git
    cd project
    pip install -r requirements.txt
    make all

## File structure

    data/          — processed (non-identifiable) data only
    scripts/       — analysis scripts, numbered in execution order
    results/       — tables and figures
    manuscript/    — draft text
```

---

## The reproducible research stack

| Layer | Tool | Purpose |
|-------|------|---------|
| Compute environment | Terminal | Execute everything |
| Version control | Git | Track all changes |
| Remote backup and collaboration | GitHub | Share and publish |
| External data | `git clone` / submodules | Reproducible data sourcing |
| AI research assistant | [OpenCode + Claude](/notes/opencode/) | Accelerate without replacing judgement |

A paper built on this stack can be fully reproduced by anyone with the repository link, including the exact version of every external dataset, the precise code that generated every figure, and the complete history of every analytical decision.

That is the standard your work should meet.

---

## Summary

| Task | How |
|---|---|
| Publish a local repo | `gh repo create --push --source=.` |
| Clone a public dataset | `git clone <url>` |
| Stay up to date | `git pull` |
| Collaborate | Branch + pull request, never commit to `main` |
| Document decisions | GitHub Issues, referenced in commits |
| Pin a dataset version | Git submodules |
| Automate pipelines | GitHub Actions |

: Key takeaways {.striped .hover}

For the situations that come up later in a project (interrupted work, regression hunting, pinning dataset versions, automated pipelines), see the [advanced Git post](/notes/advanced-git/).

If you work in R, the [RStudio best-practices post](/notes/rst-bp/) covers the project-level conventions that pair naturally with a Git-tracked repository. Once a project is in a repo, [OpenCode](/notes/opencode/) can read, analyse, and modify it directly from the terminal.

If you have any comments or questions, feel free to [reach out](mailto:tiagojacinto@med.up.pt).
