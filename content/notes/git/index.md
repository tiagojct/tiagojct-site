---
title: 'Git for health researchers: version control from day one'
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-01-27'
date-modified: '2026-04-20'
description: How to use Git to track every change in your analysis, recover from mistakes, and build an auditable record of every decision, from the first commit to a journal submission.
image: cover.png
lang: en
citation:
  url: https://tiagojct.eu/notes/git/
tags:
- Git
- Tutorials
draft: false
---

Here is a situation that comes up constantly in research: you run an analysis, get results, adjust a variable definition, re-run, get different results, and then, three weeks later, cannot remember which version of the script produced which table. You try reverting manually. You have five files called `analysis_final_v3_REVISED.py`. You are not sure which one you actually used.

"analysis_final.py", "analysis_final_v2.py", "analysis_final_v2_REVISED.py", "analysis_final_v2_REVISED_submitted.py", "analysis_USE_THIS_ONE.py" and etc.

You can probably solve this with Git; it tracks every change you make to every file, lets you go back to any previous state, and creates a complete, timestamped record of your decisions. There is a learning curve, but once it becomes habit it is second nature, and you will wonder why you did not start using it years ago.

This post assumes you are comfortable with the terminal. There's a [tutorial](/notes/terminal/) for that: start there first.

## 1. What Git actually does

Git watches a folder you designate (a **repository**). Every time you decide to save a snapshot (called a **commit**), Git records exactly what changed, who changed it, and what you wrote about the change. Nothing is overwritten. Everything is recoverable.

The workflow has three stages:

1. You edit files.
2. You **stage** the changes you want to include in the next snapshot (`git add`).
3. You **commit**: save the snapshot with a description (`git commit`).

That is it. Everything else is built on top of these three steps.

## 2. One-time setup

Before using Git for the first time, tell it who you are:

```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
git config --global core.editor "nano"        # or: vim, code, etc.
git config --global init.defaultBranch main
```

These commands produce no output; silence means success. You can verify your settings at any time:

```bash
git config --global --list
```

```
user.name=Your Name
user.email=your@email.com
core.editor=nano
init.defaultbranch=main
```

These settings are stored globally and apply to every repository on your machine. You only need to do this once.

## 3. Starting a repository

Navigate to your project folder and run:

```bash
cd ~/phd/cohort-study
git init
```

```
Initialized empty Git repository in /Users/you/phd/cohort-study/.git/
```

That is all. Git creates a hidden `.git` folder that stores the entire history of the project. You never need to touch that folder directly.

## 4. The daily workflow

```bash
# See what has changed since the last commit
git status
```

```
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)

        modified:   scripts/cohort_selection.py

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        results/tables/table1_baseline.csv

no changes added to commit (use "git add" and/or "git commit -a")
```

`git status` is the command you will run most often. It tells you what has changed, what is staged, and what Git is not yet tracking.

```bash
# Stage a specific file
git add scripts/cohort_selection.py

# Stage everything that changed
git add .

# Stage specific folders
git add scripts/ outputs/

# Commit with a description
git commit -m "Add baseline characteristics table"
```

```
[main 3e8c1a2] Add baseline characteristics table
 2 files changed, 47 insertions(+), 3 deletions(-)
 create mode 100644 results/tables/table1_baseline.csv
```

Always run `git status` before `git add .`; it shows exactly what will be staged. It is the single most effective habit for avoiding accidental commits of raw data, API keys, or half-finished edits.

```bash
# View the history
git log --oneline
```

```
3e8c1a2 Add baseline characteristics table
e3f2a1b Switch from complete-case to multiple imputation for missing SOFA score
a9d4f07 Fix: primary_diagnosis column was named differently in 2020 extract
b2c5e93 Add cohort selection: ICU admissions 2018-2022, age 18+, first admission
c1a8d42 Initialise project with .gitignore
```

```bash
git log --oneline --graph --all   # visual view, useful with branches
```

```
* f1b3c09 (experiment/logistic-regression) Add logistic regression model — 30-day readmission as binary outcome
* 3e8c1a2 (HEAD -> main) Add baseline characteristics table
* e3f2a1b Switch from complete-case to multiple imputation for missing SOFA score
* a9d4f07 Fix: primary_diagnosis column was named differently in 2020 extract
* b2c5e93 Add cohort selection: ICU admissions 2018-2022, age 18+, first admission
* c1a8d42 Initialise project with .gitignore
```

Each `*` is a commit; the labels in parentheses show where each branch tip currently points. `--all` includes commits from every branch, not just the current one.

### Writing commit messages that are useful

The message you write at commit time is the note you leave for your future self. Be specific about what changed and, more importantly, why.

```bash
# Not useful six months later
git commit -m "Update script"
git commit -m "Fix"
git commit -m "Changes"

# Useful
git commit -m "Restrict cohort to first admissions only — aligns with protocol v2"
git commit -m "Switch from complete-case to multiple imputation for missing BMI"
git commit -m "Correct ICD-10 filter: I21 was including I21.0 only, now includes I21.0–I21.9"
```

Each of those messages answers the question a reviewer or collaborator would actually ask.

## 5. Inspecting changes

```bash
# What changed in a file since the last commit?
git diff scripts/analysis.py
```

```
diff --git a/scripts/analysis.py b/scripts/analysis.py
index 4b825dc..9e3a1c8 100644
--- a/scripts/analysis.py
+++ b/scripts/analysis.py
@@ -12,7 +12,7 @@ df = pd.read_csv("data/processed/cohort.csv")
 # Define outcome
-outcome = df["readmission_90d"]
+outcome = df["readmission_30d"]

 # Covariates
```

Lines starting with `-` are what was there before; lines with `+` are the new version. Everything else is context.

```bash
# What was staged but not yet committed?
git diff --staged
```

```
diff --git a/scripts/analysis.py b/scripts/analysis.py
index 9e3a1c8..c2f4d31 100644
--- a/scripts/analysis.py
+++ b/scripts/analysis.py
@@ -28,6 +28,9 @@ model = smf.logit(
     data=df
 ).fit()

+# Export model summary
+model.summary().tables[1].to_csv("results/tables/model_coefficients.csv")
+
 print(model.summary())
```

```bash
# What changed between two commits?
git diff HEAD~3 HEAD -- scripts/analysis.py

# Full history of one file, including renames
git log --follow scripts/cohort_selection.py
```

```
commit e3f2a1b
Author: Tiago Jacinto <tiagojacinto@med.up.pt>
Date:   Mon Feb 10 14:22:05 2026 +0000

    Switch from complete-case to multiple imputation for missing SOFA score

commit a9d4f07
Author: Tiago Jacinto <tiagojacinto@med.up.pt>
Date:   Thu Feb 6 09:11:43 2026 +0000

    Fix: primary_diagnosis column was named differently in 2020 extract

commit b2c5e93
Author: Tiago Jacinto <tiagojacinto@med.up.pt>
Date:   Mon Feb 3 16:44:18 2026 +0000

    Add cohort selection: ICU admissions 2018-2022, age 18+, first admission
```

## 6. Undoing things

This is where Git earns its keep. Every researcher eventually runs the wrong analysis, saves over the wrong file, or commits something they should not have.

```bash
# Discard all unsaved changes to a file (back to the last commit)
git restore scripts/analysis.py
```

```
# (no output — the file is silently restored to its last committed state)
```

```bash
# Unstage a file — keep the changes, just remove it from the next commit
git restore --staged scripts/analysis.py
```

```
# (no output — the file moves from staged back to modified)
```

```bash
# Recover a specific old version of a file (without losing history)
git checkout abc1234 -- scripts/analysis.py
```

```
# (no output — the old version replaces the current one in your working directory;
#  it is automatically staged, ready for you to commit or inspect)
```

```bash
# Revert a commit — creates a new commit that undoes it (safe for shared repos)
git revert abc1234
```

```
[main 7f4c2d1] Revert "Switch from complete-case to multiple imputation for missing SOFA score"
 1 file changed, 8 insertions(+), 14 deletions(-)
```

**Quick decision tree.** If you modified a file and have not staged it yet → `git restore`. If you already staged it → `git restore --staged`. If you already committed → `git revert` (safe on shared repos) or `git reset` (only on local work that has never been pushed).

Never use `git reset --hard` on work that has already been pushed to a shared repository. It rewrites history in a way that creates conflicts for everyone else.

## 7. What to never commit: `.gitignore`

Create a `.gitignore` file at the root of your project before your first commit. This tells Git which files to ignore entirely.

```
# Raw and processed patient data — never commit these
data/raw/
data/processed/

# Common raw-data formats (extra safety for files outside data/)
*.xlsx
*.dta
*.sav

# API keys and credentials
.env
config_local.py
*.key

# Python artefacts
__pycache__/
*.pyc
.venv/
*.egg-info/

# R artefacts
.Rhistory
.RData
.Rproj.user/

# System files
.DS_Store
Thumbs.db

# Large model outputs (use Git LFS or store separately)
models/*.pkl
results/figures/*.png
```

Raw patient-level data must never be committed to a repository, even a private one on a platform you control. Commit only aggregated outputs, anonymised samples, or synthetic data. This is more than good practice; in many jurisdictions it is a legal requirement under data governance frameworks.

Note that this example excludes the `data/` sub-folders entirely, but does *not* exclude `*.csv` globally, so small result tables (like `results/tables/table1_baseline.csv`) can still be committed. If you prefer a stricter rule, ignore `*.csv` at the top level and explicitly allow `!results/tables/*.csv`.

## 8. Branching: exploring without breaking what works

A branch is an independent line of development. You create one when you want to try a different analytical approach without touching the code that is currently working.

```bash
# Create a new branch and switch to it
git checkout -b experiment/logistic-regression
```

```
Switched to a new branch 'experiment/logistic-regression'
```

```bash
# List all branches (* marks the current one)
git branch -a
```

```
  main
* experiment/logistic-regression
```

```bash
# Switch between branches
git checkout main
```

```
Switched to branch 'main'
```

```bash
git checkout experiment/logistic-regression
```

```
Switched to branch 'experiment/logistic-regression'
```

```bash
# Merge a branch into main when the experiment succeeded
git checkout main
git merge experiment/logistic-regression
```

```
Updating 3e8c1a2..f1b3c09
Fast-forward
 scripts/logistic_model.py | 52 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 scripts/logistic_model.py
```

```bash
# Delete the branch after merging
git branch -d experiment/logistic-regression
```

```
Deleted branch experiment/logistic-regression (was f1b3c09).
```

**Suggested naming conventions for research:**

```
analysis/survival-model
experiment/feature-selection-elastic-net
fix/missing-data-imputation
data/add-ukbiobank-cohort
sensitivity/complete-case-only
```

A branch name like `experiment/elastic-net-regularisation` tells you immediately what the branch is for, and it stays in the history even after it is deleted.

### Merge conflicts

Sooner or later two branches will change the same lines of the same file, and Git will not know which version to keep. That is a **merge conflict**: Git asking you to decide, rather than a failure.

```bash
git merge experiment/elastic-net
```

```
Auto-merging scripts/cohort_selection.py
CONFLICT (content): Merge conflict in scripts/cohort_selection.py
Automatic merge failed; fix conflicts and then commit the result.
```

Open the file and you will find conflict markers:

```python
<<<<<<< HEAD
cohort = cohort[(cohort["age"] >= 18) & (cohort["age"] <= 75)]
=======
cohort = cohort[(cohort["age"] >= 21) & (cohort["age"] <= 80)]
>>>>>>> experiment/elastic-net
```

Everything between `<<<<<<< HEAD` and `=======` is the version on your current branch. Everything between `=======` and `>>>>>>> experiment/elastic-net` is the version from the branch you are merging in. Edit the file to the version you want (which may be either side, both sides, or a combination), delete the three marker lines, save, then:

```bash
git add scripts/cohort_selection.py
git commit
```

Git records the merge and you are done. If you panic half way through, `git merge --abort` puts everything back to before the merge started.

Resolving a conflict is a decision about the science, not a mechanical operation. The worst thing to do is accept whatever is easiest; the best thing to do is read both sides carefully, pick the correct one, and explain the choice in the commit message.

## 9. Tagging submissions: answering "what code did you run?"

When you submit a paper, tag the exact state of the repository at that point:

```bash
git tag -a v1.0-submission-nejm -m "Code as submitted to NEJM, 2026-03-15"
```

```
# (no output — the tag is created silently)
```

```bash
# List all tags
git tag
```

```
v1.0-submission-nejm
```

```bash
# Push tags to GitHub
git push origin --tags
```

```
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), 190 bytes | 190.00 KiB/s, done.
Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
To https://github.com/you/sepsis-readmission.git
 * [new tag]         v1.0-submission-nejm -> v1.0-submission-nejm
```

```bash
# Check out the exact code at a tag (read-only inspection)
git checkout v1.0-submission-nejm
```

```
Note: switching to 'v1.0-submission-nejm'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, but these changes will not affect any branch.

HEAD is now at 3e8c1a2 Add baseline characteristics table
```

The "detached HEAD" message is expected; it just means you are viewing a snapshot, not a branch. Run `git checkout main` to go back to your working branch.

When a reviewer asks for the analysis code, or a journal requires a reproducibility package, you hand them the tag. The question *"what did you actually run for the paper?"* has a single, unambiguous answer.

---

## A realistic workflow across a research project

Here is how these commands fit together across the lifecycle of a typical cohort study, from setting up the project to submitting a revision.

### Day 1: starting the project

```bash
cd ~/phd
mkdir sepsis-readmission && cd sepsis-readmission
git init
```

```
Initialized empty Git repository in /Users/you/phd/sepsis-readmission/.git/
```

```bash
# Create folder structure — Git only tracks files, not empty folders,
# so these stay on disk but nothing is committed until files exist in them
mkdir -p data/raw data/processed scripts results/figures results/tables

# Create .gitignore before the first commit (see Section 7 for contents)
git add .gitignore
git commit -m "Initialise project with .gitignore"
```

```
[main (root-commit) c1a8d42] Initialise project with .gitignore
 1 file changed, 30 insertions(+)
 create mode 100644 .gitignore
```

### Week 1: building the cohort

```bash
# Write the cohort selection script
# ... edit scripts/cohort_selection.py ...

git add scripts/cohort_selection.py
git commit -m "Add cohort selection: ICU admissions 2018-2022, age 18+, first admission"
```

```
[main b2c5e93] Add cohort selection: ICU admissions 2018-2022, age 18+, first admission
 1 file changed, 84 insertions(+)
 create mode 100644 scripts/cohort_selection.py
```

```bash
# Run it, inspect outputs, fix a column name error
git add scripts/cohort_selection.py
git commit -m "Fix: primary_diagnosis column was named differently in 2020 extract"
```

```
[main a9d4f07] Fix: primary_diagnosis column was named differently in 2020 extract
 1 file changed, 3 insertions(+), 1 deletion(-)
```

### Week 3: trying a different statistical approach

```bash
# Current approach (Cox model) is on main — want to try a random-forest baseline
git checkout -b experiment/random-forest
```

```
Switched to a new branch 'experiment/random-forest'
```

```bash
# Work on the experiment
# ... edit scripts/rf_model.py ...
git add scripts/rf_model.py
git commit -m "Add random-forest baseline — 30-day readmission, 500 trees"
```

```
[experiment/random-forest 2d4e1f7] Add random-forest baseline — 30-day readmission, 500 trees
 1 file changed, 64 insertions(+)
 create mode 100644 scripts/rf_model.py
```

```bash
# Cross-validated AUC did not beat the Cox model — go back to main without losing the work
git checkout main
```

```
Switched to branch 'main'
```

The branch stays available if you ever want to revisit it.

### Week 5: supervisor asks about a decision made three weeks ago

```bash
# Find the commit where you changed the imputation method
git log --oneline --all | grep -i "imputation"
```

```
e3f2a1b Switch from complete-case to multiple imputation for missing SOFA score
```

```bash
# See exactly what changed in that commit
git show e3f2a1b
```

```
commit e3f2a1b
Author: Tiago Jacinto <tiagojacinto@med.up.pt>
Date:   Mon Feb 10 14:22:05 2026 +0000

    Switch from complete-case to multiple imputation for missing SOFA score

diff --git a/scripts/cohort_selection.py b/scripts/cohort_selection.py
index 4b825dc..9e3a1c8 100644
--- a/scripts/cohort_selection.py
+++ b/scripts/cohort_selection.py
@@ -45,7 +45,12 @@ df = pd.read_csv("data/processed/cohort.csv")
-# Drop rows with missing SOFA score
-df = df.dropna(subset=["sofa_score"])
+# Impute missing SOFA scores using multiple imputation
+from sklearn.experimental import enable_iterative_imputer
+from sklearn.impute import IterativeImputer
+imp = IterativeImputer(max_iter=10, random_state=42)
+df[["sofa_score"]] = imp.fit_transform(df[["sofa_score"]])
```

### Week 8: preparing for submission

```bash
# Ensure main has everything needed
git log --oneline
```

```
3e8c1a2 (HEAD -> main) Add baseline characteristics table
e3f2a1b Switch from complete-case to multiple imputation for missing SOFA score
a9d4f07 Fix: primary_diagnosis column was named differently in 2020 extract
b2c5e93 Add cohort selection: ICU admissions 2018-2022, age 18+, first admission
c1a8d42 Initialise project with .gitignore
```

```bash
# Tag the submission state
git tag -a v1.0-submission-lancet -m "Code submitted to The Lancet, 2026-03-10"
git push origin --tags
```

```
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), 195 bytes | 195.00 KiB/s, done.
Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
To https://github.com/you/sepsis-readmission.git
 * [new tag]         v1.0-submission-lancet -> v1.0-submission-lancet
```

### Week 12: major revision, reviewer asks for sensitivity analysis

```bash
# Create a branch for the revision
git checkout -b revision/sensitivity-complete-case
```

```
Switched to a new branch 'revision/sensitivity-complete-case'
```

```bash
# ... run sensitivity analysis, add results ...
git add scripts/sensitivity_complete_case.py results/tables/sensitivity_table.csv
git commit -m "Add sensitivity analysis: complete-case only (reviewer 2 request)"
```

```
[revision/sensitivity-complete-case 9c2b5e8] Add sensitivity analysis: complete-case only (reviewer 2 request)
 2 files changed, 73 insertions(+)
 create mode 100644 scripts/sensitivity_complete_case.py
 create mode 100644 results/tables/sensitivity_table.csv
```

```bash
# Merge back into main
git checkout main
git merge revision/sensitivity-complete-case
```

```
Updating 3e8c1a2..9c2b5e8
Fast-forward
 scripts/sensitivity_complete_case.py    | 73 +++++++++++++++++++++++++++++++
 results/tables/sensitivity_table.csv   |  1 +
 2 files changed, 74 insertions(+)
 create mode 100644 scripts/sensitivity_complete_case.py
 create mode 100644 results/tables/sensitivity_table.csv
```

```bash
# Tag the revised submission
git tag -a v2.0-revision-lancet -m "Revised submission to The Lancet, 2026-05-02"
```

```
# (no output — the tag is created silently)
```

By the time the paper is published, your repository is a complete, auditable record: every analytical decision has a commit, every submission has a tag, and every experiment lives in a named branch.

---

## Summary

| Concept | Command / practice |
|---|---|
| Initialise | `git init`, once, at project start |
| Check state | `git status`, constantly |
| Stage changes | `git add file` or `git add .` |
| Save snapshot | `git commit -m "Specific, meaningful message"` |
| Inspect changes | `git diff`, `git log --oneline` |
| Undo mistakes | `git restore`, `git revert` |
| Protect raw data | `.gitignore`, before the first commit |
| Try a new approach | `git checkout -b branch-name` |
| Mark a submission | `git tag -a v1.0-submission-journal` |

: Key takeaways {.striped .hover}

Start every new project with `git init` and a `.gitignore`. The cost is thirty seconds. The benefit is every version of every file, forever.

The next step is putting this history online: for backup, for collaboration, and for accessing real public health datasets. The [next post](/notes/github/) covers GitHub.

If you have any comments or questions, feel free to [reach out](mailto:tiagojacinto@med.up.pt).
