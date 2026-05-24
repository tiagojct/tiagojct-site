---
title: The terminal for health researchers
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-01-20'
date-modified: '2026-04-13'
description: 'A practical introduction to the terminal for medical and digital health students: navigating, inspecting data files, and automating the repetitive tasks that slow research down.'
image: chris-ried-LfG7RwMM6g8-unsplash.jpg
lang: en
citation:
  url: https://tiagojct.eu/notes/terminal/
tags:
- Terminal
- Tutorials
draft: false
---

At some point in your research you will be given access to a server, a cluster, or a shared environment where there is no graphical interface, only a blinking cursor. Or you will want to process hundreds of files at once, and clicking through a folder will not cut it. The terminal is the tool for both.

This post is written for medical and digital health students who are comfortable with Python or R but have spent little time in the command line. The goal is to understand the logic well enough to navigate confidently and to handle the situations that come up most often in research, rather than to memorise every command.

## 1. What the terminal is

The terminal is a text interface to your operating system. You type instructions, the system executes them, and the result comes back as text. There is no dragging, dropping, or clicking; just commands and output.

It feels slow at first. It becomes faster than any graphical interface once the commands are familiar, because you can combine them, repeat them, and automate them in ways that no file manager can match.

The Wikipedia page on the [Command-line interface](https://en.wikipedia.org/wiki/Command-line_interface) has a good overview of the history and concepts behind the terminal. It is worth a read after you have the basics down.

### Opening it

**macOS:** `Applications > Utilities > Terminal`, or `Cmd + Space` → type `Terminal`. The default shell is zsh.

![Terminal in macOS](notes/terminal/terminal-macos.png))

**Linux:** `Ctrl + Alt + T` on most distributions. Default shell is usually bash.

**Windows:** Install [Windows Terminal](https://aka.ms/terminal) from the Microsoft Store. For research work, also install [WSL2](https://learn.microsoft.com/en-us/windows/wsl/install) (Windows Subsystem for Linux); it gives you a real Linux environment inside Windows, which is what most servers and cloud platforms use.

## 2. The logic of navigation

Every command you type is executed *somewhere*: in a specific folder called the **working directory**. Before doing anything else, know where you are.

```bash
pwd          # print working directory — shows your current location
```

```
/Users/tiago/phd/cohort-study
```

From there, you move around exactly like you would in a file manager, except with text:

```bash
ls                  # list files and folders here
```

```
data/  results/  scripts/  cohort-study.Rproj
```

Plain `ls` hides dotfiles. To see them, add `-a`.

```bash
ls -la              # list everything, including hidden files, with details
```

```
total 24
drwxr-xr-x   7 tiago  staff   224 Jan 20 09:14 .
drwxr-xr-x  12 tiago  staff   384 Jan 20 09:10 ..
drwxr-xr-x   9 tiago  staff   288 Jan 20 11:32 .git
-rw-r--r--   1 tiago  staff   312 Jan 20 09:14 .gitignore
drwxr-xr-x   4 tiago  staff   128 Jan 20 09:14 data
drwxr-xr-x   3 tiago  staff    96 Jan 20 09:14 results
drwxr-xr-x   5 tiago  staff   160 Jan 20 10:45 scripts
```

```bash
cd Documents        # move into the Documents folder
cd ..               # go up one level
cd ~                # go to your home directory, from anywhere
cd ~/Documents/phd  # go directly to a path from home
```

Navigation commands produce no output; the prompt simply returns, now in a different location. Confirm with `pwd` if in doubt.

`~` is a shortcut for your home directory (`/Users/yourname` on macOS, `/home/yourname` on Linux). You will see it constantly.

The single most useful habit: before running any command that creates or modifies files, run `pwd` to confirm you are in the right place.

### Absolute vs. relative paths

```bash
/Users/tiago/phd/cohort-study/data/patients.csv   # absolute — works from anywhere
data/patients.csv                                  # relative — works only from cohort-study/
~/phd/cohort-study/data/patients.csv               # ~ shorthand — works from anywhere
```

Use absolute paths in scripts that will run on servers or be shared with collaborators. A relative path that works on your laptop will silently fail on someone else's machine if the folder structure differs by even one level.

## 3. Managing files and folders

```bash
mkdir cohort-study              # create a folder
mkdir -p cohort-study/data/raw  # create nested folders in one step

cp patients.csv data/raw/       # copy a file into a folder
cp -r scripts/ backup-scripts/  # copy a folder and all its contents

mv patients_v1.csv patients.csv # rename a file
mv data/raw/old.csv archive/    # move a file to another folder

rm scratch.py                   # delete a file — permanent, no Trash
rm -r temp-outputs/             # delete a folder and everything inside it
```

These commands are silent on success; no output means it worked. Errors are printed if a file does not exist or permissions are wrong:

```
cp: data/raw/: No such file or directory
rm: temp-outputs/: No such file or directory
```

> [!warning]
**`rm` is irreversible.** There is no undo and no Trash. Before running `rm -r`, double-check with `ls` first.

## 4. Inspecting data files

You will often receive a dataset and want to know its shape before opening it in Python or R. The terminal gives you that in seconds.

```bash
wc -l patients.csv              # count lines (rows including header)
```

```
48231 patients.csv
```

```bash
head -5 patients.csv            # first 5 lines — check column names and format
```

```
patient_id,admission_date,discharge_date,primary_icd10,age,sex
PT0001,2021-03-14,2021-03-18,I21.0,67,M
PT0002,2021-03-15,2021-03-22,J18.1,74,F
PT0003,2021-03-15,2021-03-16,K35.2,45,M
PT0004,2021-03-16,2021-03-19,I50.0,81,F
```

```bash
tail -5 patients.csv            # last 5 lines — check for trailing blank rows
```

```
PT48227,2022-12-29,2022-12-31,I21.9,59,M
PT48228,2022-12-30,2023-01-04,J44.1,70,F
PT48229,2022-12-30,2023-01-02,N18.4,66,M
PT48230,2022-12-31,2023-01-05,I63.3,78,F

```

The blank line at the end is a trailing newline; harmless but worth spotting before loading the file into R or Python.

By default `head` and `tail` show 10 lines. Override this with `-n N` (or just `-N`): `head -5` shows 5 lines, `tail -3` shows the last 3.

```bash
cat codebook.txt                # print a small file in full
```

Only use `cat` on small files. On a large dataset it will flood your terminal with thousands of lines. Use `head` and `tail` instead; they let you preview a file without loading it fully.

```
patient_id       — unique patient identifier (anonymised)
admission_date   — date of hospital admission (YYYY-MM-DD)
discharge_date   — date of discharge or death
primary_icd10    — primary diagnosis at discharge (ICD-10-CM)
age              — age at admission (years)
sex              — M / F
```

These commands chain together using the pipe symbol (`|`), which sends the output of one command directly into the next. It is the terminal's most powerful feature: small tools combined into powerful pipelines. You will see it constantly; it is worth understanding early.

`awk` is pre-installed on macOS and Linux. On Windows under WSL2 it is also available. If you are using Windows without WSL2, install `awk` via [Git Bash](https://git-scm.com/) or [Cygwin](https://www.cygwin.com/).

For larger files:

```bash
# Count data rows only (subtract the header)
tail -n +2 patients.csv | wc -l
```

```
48230
```

```bash
# Check the first field of every row (e.g. patient IDs for duplicates)
# tail -n +2 skips the header; awk extracts a column; sort/uniq/head do the rest
tail -n +2 patients.csv | awk -F',' '{print $1}' | sort | uniq -c | sort -rn | head -20
```

```
      2 PT12043
      1 PT48230
      1 PT48229
      1 PT48228
      ...
```

`PT12043` appears twice: a duplicate that needs investigating before the analysis.

```bash
# Find all rows containing a specific ICD-10 code
grep "I21" patients.csv | wc -l
```

```
1847
```

`grep -c` counts matching lines without piping to `wc`:

```bash
grep -c "I21" patients.csv
```

```
1847
```

```bash
# Check whether any row has an unexpected number of columns
awk -F',' '{print NF}' patients.csv | sort | uniq -c
```

```
  48230 6
      1 7
```

48,230 rows have 6 columns (correct), but one has 7; there is likely a comma inside a quoted field in that row. Worth tracking down before loading into Python or R.

## 5. Running scripts

```bash
python3 analysis.py                          # run a Python script
```

```
Loading cohort data...
n = 48230 rows loaded
Applying exclusion criteria...
Final cohort: n = 6,841
Model fitted. Results saved to results/model_output.csv
```

```bash
Rscript cohort_selection.R                   # run an R script
```

```
[1] "Reading admissions data..."
[1] "Rows loaded: 48230"
[1] "After exclusions: 6841"
Warning message:
In read.csv("data/raw/patients.csv") : incomplete final line found
```

```bash
# Save all output (stdout and errors) to a dated log file
python3 analysis.py > results_$(date +%Y%m%d).log 2>&1
```

```
# (no terminal output — everything is written to results_20260120.log)
```

```bash
# Run in the background — terminal stays free
python3 long_analysis.py &
```

```
[1] 84732
```

The number is the process ID (PID). You can use it to check on or stop the job.

`Ctrl + Z` suspends a running job: it pauses and returns you to the prompt. Bring it back with `fg` (foreground). `Ctrl + C` kills the job permanently; it cannot be recovered.

```bash
# Check what is running in the background
jobs
```

```
[1]+  Running    python3 long_analysis.py &
```

The `$(date +%Y%m%d)` pattern inserts today's date into the filename: a simple way to keep logs from overwriting each other across runs.

One more navigation trick: `cd -` jumps back to the previous directory, not the parent (that's `cd ..`). Useful when toggling between two locations.

When running long analyses on a shared server via SSH, use `nohup` to prevent the job from stopping when you disconnect:

```bash
nohup python3 long_analysis.py > results_$(date +%Y%m%d).log 2>&1 &
```

`nohup` ignores the hangup signal, and `&` puts the job in the background. The job continues running even if your terminal disconnects.

## 6. Searching

For any command, `man <command>` opens its manual; e.g., `man grep` shows every flag and option. Close it with `q`.

```bash
# Find a file by name
find . -name "patients.csv"
```

```
./data/raw/patients.csv
```

```bash
# Find all Python scripts modified in the last 7 days
find . -name "*.py" -mtime -7
```

```
./scripts/analysis.py
./scripts/cohort_selection.py
```

```bash
# Search for a string inside files
grep -r "exclude_missing" scripts/
```

```
scripts/cohort_selection.py:43:    df = df[exclude_missing(df, cols=["age", "sex"])]
scripts/utils.py:12:def exclude_missing(df, cols):
```

```bash
# Search case-insensitively
grep -ri "systolic" data/
```

```
data/raw/codebook.txt:systolic_bp  — systolic blood pressure at admission (mmHg)
```

```bash
# Show the filename and line number of each match
grep -rn "icd10" scripts/
```

```
scripts/cohort_selection.py:17:icd10_filter = df["primary_icd10"].str.startswith("I21")
scripts/cohort_selection.py:31:# Secondary ICD-10 codes not used in primary cohort definition
scripts/analysis.py:9:# icd10 column already filtered in cohort_selection.py
```

## 7. A realistic first day with a new dataset

Here is the sequence a junior researcher typically runs when they receive a new dataset for the first time. The scenario: you have been given a CSV of hospital admissions and need to understand it before writing any analysis code.

```bash
# 1. Navigate to the project folder
cd ~/phd/hospital-admissions

# 2. Confirm you are in the right place
pwd
```

```
/Users/tiago/phd/hospital-admissions
```

```bash
ls
```

```
data/  scripts/  results/
```

```bash
# 3. Check the size of the file
wc -l data/admissions.csv
```

```
48231 data/admissions.csv
```

48,231 lines means 48,230 data rows plus a header.

```bash
# 4. Look at the column names and first rows
head -3 data/admissions.csv
```

```
patient_id,admission_date,discharge_date,primary_icd10,age,sex,ward
PT0001,2021-03-14,2021-03-18,I21.0,67,M,cardiology
PT0002,2021-03-15,2021-03-22,J18.1,74,F,respiratory
```

```bash
# 5. Check the last rows for trailing blank lines or truncation
tail -3 data/admissions.csv
```

```
PT48229,2022-12-30,2023-01-02,N18.4,66,M,nephrology
PT48230,2022-12-31,2023-01-05,I63.3,78,F,neurology

```

```bash
# 6. Verify column count is consistent throughout
awk -F',' '{print NF}' data/admissions.csv | sort | uniq -c
```

```
  48231 7
```

One unique value across all rows: the structure is clean.

```bash
# 7. Count how many unique patients there are (column 1 = patient_id)
tail -n +2 data/admissions.csv | awk -F',' '{print $1}' | sort -u | wc -l
```

```
41504
```

41,504 unique patients from 48,230 rows; some patients were admitted more than once.

```bash
# 8. Check which ICD-10 codes are most frequent (column 4 = primary_icd10)
tail -n +2 data/admissions.csv | awk -F',' '{print $4}' | sort | uniq -c | sort -rn | head -20
```

```
   2341 I50.0
   1847 I21.0
   1603 J18.1
   1412 J44.1
    987 N18.4
    ...
```

```bash
# 9. Find any rows that might be malformed
grep -n "^," data/admissions.csv       # rows starting with a comma
grep -n ",," data/admissions.csv       # consecutive commas (empty fields)
```

```
# (no output — no malformed rows found)
```

```bash
# 10. Check disk usage before creating derivative files
du -sh data/
```

```
 14M    data/
```

By the end of this ten-step sequence, you know the number of rows, the column structure, the most common diagnosis codes, whether there are any obvious formatting issues, and how much space the data occupies. None of this required opening Python, R, or Excel. It took about 90 seconds.

## 8. Useful shortcuts

| Key | What it does |
|---|---|
| `Tab` | Autocomplete a file or folder name |
| `↑` / `↓` | Cycle through previous commands |
| `Ctrl + C` | Stop a running command |
| `Ctrl + L` | Clear the screen (same as `clear`) |
| `Ctrl + A` | Jump to the beginning of the line |
| `Ctrl + E` | Jump to the end of the line |
| `Ctrl + R` | Search command history interactively |

: Terminal shortcuts {.striped .hover}

`Ctrl + R` is underused. Start typing any part of a previous command and it surfaces the most recent match, much faster than pressing `↑` twenty times. For example, if you previously ran `python3 analysis.py` and now want to run it again, just press `Ctrl + R`, type `analy`, and it will show you the last command that contained "analy". Press `Enter` to run it again.

## Summary

| Task | Command |
|---|---|
| Where am I? | `pwd` |
| What is here? | `ls -la` |
| Move around | `cd folder`, `cd ..`, `cd ~` |
| Create folders | `mkdir -p path/to/folder` |
| Inspect a dataset | `head`, `tail`, `wc -l`, `awk` |
| Search inside files | `grep -rn "pattern" folder/` |
| Run a script with a log | `python3 script.py > log_$(date +%Y%m%d).log 2>&1` |
| Delete carefully | `ls` first, then `rm` |

: Key takeaways {.striped .hover}

The terminal feels unfamiliar for roughly the first two weeks. After that it becomes the fastest tool you have for anything involving files, data inspection, and script automation.

The next step is putting your project under version control. The [next post](/notes/git/) covers Git: how to track every change you make to your analysis and never lose work again.

## Where to go from here

- [Git for health researchers](/notes/git/): put your project under version control so nothing is ever lost.
- [GitHub for health researchers](/notes/github/): publish your work and access real public health datasets.
- [OpenCode: an AI research assistant in your terminal](/notes/opencode/): once the terminal is familiar, OpenCode lets you drive a research project by natural-language instructions while seeing every file change.

If you have any comments or questions, feel free to [reach out](mailto:tiagojacinto@med.up.pt)).
