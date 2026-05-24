---
title: 'Advanced Git for research: stash, bisect, submodules, and automation'
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-02-03'
date-modified: '2026-04-20'
description: 'Beyond the basics: Git tools for the situations that arise later in a research project, including interrupted work, regression hunting, reproducible data sourcing, and automated pipelines.'
image: cover.png
lang: en
citation:
  url: https://tiagojct.eu/notes/advanced-git/
tags:
- Git
- GitHub
- Tutorials
draft: false
---

The core Git workflow (init, add, commit, branch, push) covers most of what you need day to day. But research projects have patterns that the basics do not handle cleanly: you are mid-analysis when something urgent comes in; a result that was correct last month is now wrong and you cannot find why; a dataset you depend on is updated by someone else and you need a way to pin the version you actually used.

This post covers the Git features built for exactly those situations. It assumes you are comfortable with the workflow described in the [previous post](/notes/git/).

## 1. Stash: shelve work without committing

You are 40 minutes into rewriting the imputation logic when your supervisor messages asking you to urgently re-run the published analysis with a corrected data extract. Your current work is not ready to commit, but you cannot lose it, and you cannot mix it with the urgent fix.

```bash
# Save your in-progress work to a named stash
git stash push -m "WIP: multiple imputation rewrite — not yet tested"
```

```
Saved working directory and index state On main: WIP: multiple imputation rewrite — not yet tested
```

```bash
# Your working directory is now clean — switch task freely
git checkout main
# ... do the urgent work, commit it ...

# Come back to your stash
git stash list
```

```
stash@{0}: On main: WIP: multiple imputation rewrite — not yet tested
```

```bash
git stash pop
```

```
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)

        modified:   scripts/cohort_selection.py

Dropped stash@{0} (e8f3c21a4d5b6789012345678901234567890abc)
```

If you have accumulated multiple stashes:

```bash
git stash list
```

```
stash@{0}: On analysis/cox-model: WIP: time-varying covariates
stash@{1}: On main: WIP: multiple imputation rewrite — not yet tested
```

```bash
# Apply a specific one without removing it
git stash apply stash@{1}
```

```
On branch main
Changes not staged for commit:
        modified:   scripts/cohort_selection.py
```

```bash
# Delete a stash you no longer need
git stash drop stash@{1}
```

```
Dropped stash@{1} (f4c2e89a1b3d567890123456789012345678abcd)
```

```bash
# Clear all stashes
git stash clear
```

```
# (no output — all stashes removed)
```

`git stash pop` = apply the most recent stash + delete it from the list. `git stash apply` = apply it but keep it in the list. Use `apply` when you are not sure the restoration worked correctly.

## 2. Bisect: find when a result changed

A result you produced three months ago no longer matches when you re-run the same script. Something in the code changed at some point, but you have 60+ commits since then and no idea which one introduced the discrepancy. `git bisect` narrows it down with a binary search.

```bash
# Start bisect mode
git bisect start

# Tell Git that the current state is broken
git bisect bad
```

```
# (no output — bisect mode begins)
```

```bash
# Tell Git a known-good commit (find it with git log --oneline)
git bisect good a3f892c
```

```
Bisecting: 31 revisions left to test after this (roughly 5 steps)
[c7d4e1f] Add sensitivity analysis for age subgroups
```

Git has checked out the midpoint commit. Test your analysis and tell Git what you found:

```bash
python3 analysis.py        # does it produce the correct result?

git bisect good            # this commit was fine
```

```
Bisecting: 15 revisions left to test after this (roughly 4 steps)
[9a2b8c3] Switch exclusion filter from ≥18 to >18
```

```bash
# or
git bisect bad             # this commit has the problem
```

```
Bisecting: 7 revisions left to test after this (roughly 3 steps)
[f1e4d2a] Add baseline characteristics table
```

Git halves the search space at each step. After 6–7 rounds of a 60-commit range, it identifies the exact commit that introduced the problem:

```
b91f3e2 is the first bad commit
Author: Tiago Jacinto
Date:   Mon Jan 13 2026

    Switch exclusion filter from ≥18 to >18 — now excludes 18-year-olds
```

```bash
git bisect reset
```

```
Previous HEAD position was b91f3e2 Switch exclusion filter from ≥18 to >18 — now excludes 18-year-olds
Switched to branch 'main'
```

This is a powerful debugging tool for a class of problem that is otherwise genuinely hard to diagnose: a result that drifted quietly over weeks of changes.

## 3. Blame: who changed what, and when

`git blame` annotates every line of a file with the commit and author that last modified it. In a research context, this is most useful for your own history: finding where a specific line came from.

```bash
# Annotate every line in a script
git blame scripts/analysis.py
```

```
e3f2a1b (Tiago Jacinto 2026-01-22 14:30:11 +0000  1) import pandas as pd
e3f2a1b (Tiago Jacinto 2026-01-22 14:30:11 +0000  2) import numpy as np
b2c5e93 (Tiago Jacinto 2026-02-03 09:11:43 +0000  3) from sklearn.impute import IterativeImputer
...
b91f3e2 (Tiago Jacinto 2026-02-17 11:04:22 +0000 42) df = df[df['age'] > 18]
```

```bash
# Focus on a specific range of lines
git blame -L 40,60 scripts/analysis.py
```

```
b91f3e2 (Tiago Jacinto 2026-02-17 11:04:22 +0000 40) # Apply age exclusion
b91f3e2 (Tiago Jacinto 2026-02-17 11:04:22 +0000 41) # Note: changed from >= to > per protocol clarification
b91f3e2 (Tiago Jacinto 2026-02-17 11:04:22 +0000 42) df = df[df['age'] > 18]
e3f2a1b (Tiago Jacinto 2026-01-22 14:30:11 +0000 43) 
a9d4f07 (Tiago Jacinto 2026-02-06 09:11:43 +0000 44) df = df[df['primary_icd10'].str.startswith('I21')]
```

```bash
# Show the full commit hash (useful for copying into git show)
git blame -l scripts/analysis.py
```

```
b91f3e2a4d5c6e7f8901234567890abcdef012345 (Tiago Jacinto 2026-02-17 11:04:22 +0000 42) df = df[df['age'] > 18]
```

The output for each line follows the pattern `<short-sha> (<author> <date> <line>) <content>`. From there, `git show <short-sha>` gives the full context of that commit, including what else changed at the same time and what the commit message said.

In a collaborative project, `git blame` answers the question *"who introduced this line and why?"* without needing to search through the commit log manually.

## 4. Submodules: embedding a versioned dataset

If your analysis depends on a public dataset that is itself version-controlled on GitHub, submodules let you lock your project to a specific snapshot of that dataset, rather than just hoping the dataset hasn't changed since you ran the analysis.

```bash
# Add the OWID COVID-19 dataset as a submodule
git submodule add https://github.com/owid/covid-19-data.git data/owid
```

```
Cloning into '/Users/tiago/phd/sepsis-readmission/data/owid'...
remote: Enumerating objects: 84312, done.
remote: Counting objects: 100% (1204/1204), done.
remote: Compressing objects: 100% (489/489), done.
Receiving objects: 100% (84312/84312), 1.23 GiB | 4.21 MiB/s, done.
```

```bash
# This creates a .gitmodules file and a special reference in your repo
git add .gitmodules data/owid
git commit -m "Add OWID COVID-19 data as submodule — pinned to 2026-01-20 snapshot"
```

```
[main 4d8e2c1] Add OWID COVID-19 data as submodule — pinned to 2026-01-20 snapshot
 2 files changed, 4 insertions(+)
 create mode 100644 .gitmodules
 create mode 160000 data/owid
```

When a collaborator clones your repository:

```bash
git clone --recurse-submodules https://github.com/you/your-project.git
```

```
Cloning into 'your-project'...
Submodule 'data/owid' (https://github.com/owid/covid-19-data.git) registered for path 'data/owid'
Cloning into '/Users/collaborator/your-project/data/owid'...
Submodule path 'data/owid': checked out 'a1b2c3d4e5f6...'
```

```bash
git submodule update --remote data/owid
git add data/owid
git commit -m "Update OWID data to 2026-02-01 snapshot"
```

```
[main 7c3a9f2] Update OWID data to 2026-02-01 snapshot
 1 file changed, 1 insertion(+), 1 deletion(-)
```

A submodule is a pointer to a specific commit in another repository. Your repo does not store the external files; it stores the reference. Cloning with `--recurse-submodules` fetches both.

This is the cleanest answer to *"which version of the dataset did you use?"*: the version is recorded in your repository's commit history, and anyone who clones the repo gets exactly the same data.

## 5. GitHub Actions: automated analysis pipelines

GitHub Actions runs scripts automatically in response to events: a push to `main`, a pull request, or a scheduled time. For research, the most useful application is a pipeline that re-runs your analysis whenever new data or code is pushed.

Create `.github/workflows/analysis.yml`:

```yaml
name: Run analysis pipeline

on:
  push:
    branches: [main]
  schedule:
    - cron: '0 6 * * 1'   # every Monday at 06:00 UTC — picks up updated data

jobs:
  analyse:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v4
        with:
          submodules: true   # also fetch submodules (e.g. OWID dataset)

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: Install dependencies
        run: pip install -r requirements.txt

      - name: Run cohort selection
        run: python scripts/cohort_selection.py

      - name: Run main analysis
        run: python scripts/analysis.py

      - name: Upload results as artefacts
        uses: actions/upload-artifact@v4
        with:
          name: results-${{ github.sha }}
          path: results/
```

Every Monday, GitHub fetches your repository, runs the full pipeline, and stores the outputs as downloadable artefacts labelled with the commit hash. If the dataset was updated over the weekend, you will see it in the new results the same morning.

This is useful for surveillance analyses, living systematic reviews, or any project where the underlying data changes on a regular schedule.

## 6. A realistic scenario: the analysis that broke between drafts

Here is a situation that combines several of the tools above. The scenario: you submitted a draft three months ago. Your supervisor now wants to update the analysis for a revised submission, but the numbers are different from the ones in the draft, and you cannot immediately explain why.

### Step 1: Find the submission snapshot

```bash
# List all tags to find the submission tag
git tag
```

```
v1.0-submission-lancet
```

```bash
# Check out the exact state at submission
git checkout v1.0-submission-lancet
```

```
Note: switching to 'v1.0-submission-lancet'.
You are in 'detached HEAD' state.
HEAD is now at 3e8c1a2 Add baseline characteristics table
```

```bash
# Run the analysis and compare outputs with the draft
python3 scripts/analysis.py
```

```
Loading cohort data...
Final cohort: n = 5,204
Median age: 68 (IQR 58–76)
30-day readmission rate: 12.3%
```

### Step 2: Compare commits since the tag

```bash
# Return to the current state
git checkout main
```

```
Switched to branch 'main'
```

```bash
# See all commits since the submission tag
git log v1.0-submission-lancet..HEAD --oneline
```

```
4e7b3f1 Fix ICD-10 filter: now includes I21.0–I21.9
7c3a9f2 Update OWID data to 2026-02-01 snapshot
d2e4f8a Add sensitivity analysis for age subgroups
```

### Step 3: Narrow it down with bisect

```bash
git bisect start
git bisect bad                    # current main is producing wrong numbers
git bisect good v1.0-submission-lancet
```

```
Bisecting: 1 revision left to test after this (roughly 1 step)
[4e7b3f1] Fix ICD-10 filter: now includes I21.0–I21.9
```

```bash
# Test at each step until Git finds the culprit commit
python3 scripts/analysis.py
git bisect bad
```

```
4e7b3f1 is the first bad commit
Author: Tiago Jacinto <tiagojacinto@med.up.pt>
Date:   Wed Apr 8 10:22:15 2026 +0000

    Fix ICD-10 filter: now includes I21.0–I21.9
```

```bash
git bisect reset
```

```
Switched to branch 'main'
```

### Step 4: Understand what changed

```bash
# See the full diff of the culprit commit
git show 4e7b3f1
```

```
commit 4e7b3f1
Author: Tiago Jacinto <tiagojacinto@med.up.pt>
Date:   Wed Apr 8 10:22:15 2026 +0000

    Fix ICD-10 filter: now includes I21.0–I21.9

diff --git a/scripts/cohort_selection.py b/scripts/cohort_selection.py
-icd10_filter = df["primary_icd10"] == "I21.0"
+icd10_filter = df["primary_icd10"].str.startswith("I21")
```

```bash
# Check which lines in the script are from that commit
git blame -L 1,50 scripts/cohort_selection.py
```

```
4e7b3f1 (Tiago Jacinto 2026-04-08 10:22:15 +0000 17) icd10_filter = df["primary_icd10"].str.startswith("I21")
```

### Step 5: Decide and document

```bash
git commit -m "Restore I21 filter to exact match (I21.0 only) per original protocol — see issue #31"
```

```
[main c4f7d9e] Restore I21 filter to exact match (I21.0 only) per original protocol — see issue #31
 1 file changed, 1 insertion(+), 1 deletion(-)
```

```bash
git tag -a v2.0-revision-lancet -m "Revised submission — restores original cohort definition"
```

```
# (no output — tag created silently)
```

The entire investigation is now traceable in the repository history.

---

## Summary

| Tool | When to use it |
|---|---|
| `git stash` | Interrupted mid-task; need a clean working directory without committing |
| `git bisect` | A result changed at some unknown point; need to find the culprit commit |
| `git blame` | Need to know when a specific line was introduced and why |
| Submodules | External dataset needs to be pinned to the version used in the analysis |
| GitHub Actions | Automate the full pipeline to run on push or on a schedule |

: Key takeaways {.striped .hover}

These tools matter most when something goes wrong, which is exactly when you will be glad you used them from the start.

None of these features require setup beyond what you already have. `git stash`, `git bisect`, and `git blame` work on any existing repository. Submodules and Actions require a GitHub repository, which is covered in the [GitHub post](/notes/github/).

When an AI agent starts making many changes to a repository, these tools earn their keep quickly; see the [OpenCode post](/notes/opencode/) for how branches, `stash`, and `bisect` pair with agent-driven revision cycles.

If you have any comments or questions, feel free to [reach out](mailto:tiagojacinto@med.up.pt).
