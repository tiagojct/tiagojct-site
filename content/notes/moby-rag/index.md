---
title: A local RAG chatbot for Moby-Dick with Ollama, ChromaDB, and Streamlit
author:
  name: Tiago Jacinto
  affiliation: Faculty of Medicine, University of Porto
  orcid: 0000-0002-7897-1101
date: '2026-03-28'
date-modified: '2026-04-20'
description: 'How the moby-rag project works: downloading the text, building embeddings locally, retrieving relevant passages, and serving a Streamlit chat UI with a selectable model.'
image: ahab.jpg
lang: en
citation:
  url: https://tiagojct.eu/notes/moby-rag/
tags:
- AI
- RAG
- Tutorials
draft: false
---

[Retrieval-augmented generation](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) (RAG) does not require a cloud stack or a framework. Sometimes the most useful thing is a small project you can run on your own machine, understand from top to bottom, and adapt to a different corpus the next day.

That is what `moby-rag` is: a local chatbot about *Moby-Dick* built from plain text, local embeddings, ChromaDB, and a Streamlit interface. The point is to see the moving parts of a retrieval-augmented system in a form you can read in one sitting, debug in an afternoon, and adapt to a different corpus the next day.

## 1. What the project actually does

The workflow has four steps:

1. Download and clean the text of *Moby-Dick*.
2. Split it into chapters and smaller chunks.
3. Generate embeddings for each chunk and store them in ChromaDB.
4. Retrieve relevant chunks for a question and send them to a chat model.

The project structure is deliberately flat:

```text
moby-rag/
  01_download.py
  02_ingest.py
  03_rag.py
  04_app.py
  requirements.txt
  chroma_db/
  moby_dick_raw.txt
  moby_dick_clean.txt
```

Each file has one job. There is no framework scaffolding and no hidden application state outside the generated vector store.

## 2. Requirements

You need Python, Ollama for embeddings, and access to at least one chat model.

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

```bash
ollama list
```

```
NAME                  ID              SIZE
nomic-embed-text      ...             ...
phi3:3.8b             ...             ...
```

Embeddings are generated locally with `nomic-embed-text`. For the answer model, you can use any model available through Ollama — a small local model like `phi3:3.8b`, or a larger one if you have access to a server with more capable hardware.

If your institution is running a shared Ollama server for research use, you can point the same pipeline at larger models without changing anything else. Ask locally whether one is available; some groups (ours included) are piloting this kind of setup for internal testing, though such servers are typically not public.

This separation matters. Embeddings and answer generation are different tasks. Keeping embeddings local means the vector store is reproducible on your own machine even if you later swap the chat model.

## 3. Step 1 — downloading and cleaning the text

The first script downloads the Project Gutenberg text and removes the boilerplate.

```bash
python 01_download.py
```

```
Downloading Moby Dick from Project Gutenberg...
Raw text saved to moby_dick_raw.txt
Clean text saved to moby_dick_clean.txt
```

The output is a cleaned plain-text novel stored locally. That file is the corpus that every later step depends on.

The important design decision here is that the text is materialised as a normal file. You can open it, inspect it, diff it, or replace it with a different edition if you want to experiment. Nothing is locked away in a proprietary format.

## 4. Step 2 — chunking and embedding the book

The ingestion step does most of the real work.

```bash
python 02_ingest.py
```

```
Found 136 chapters
Total chunks: 1385
Generating embeddings (this may take a few minutes)...
  50/1385 chunks embedded...
  100/1385 chunks embedded...
  ...
Done. 1385 chunks stored in ./chroma_db
```

Three things happen inside this script.

### Chapter-level structure

The novel is first split by chapter heading. That preserves a meaningful literary unit before any finer chunking begins.

### Overlapping sub-chunks

Long chapters are split into smaller overlapping windows. This matters because embedding a whole chapter often makes retrieval too coarse, while embedding tiny fragments can destroy context.

The current chunker tries to break at paragraph or sentence boundaries and keeps overlap between neighbouring chunks. That overlap was important to get right: an earlier version could stall in a zero-progress loop when a break point fell too close to the start of a chunk. The fixed version guarantees that the window always advances.

### Batched Chroma writes

Embeddings are generated chunk by chunk, but written to ChromaDB in batches. That keeps memory usage predictable and avoids building a large in-memory list of all chunk payloads before storage.

## 5. Step 3 — retrieval and answer generation

You can query the system directly from the command line.

```bash
python 03_rag.py "Who is Queequeg?"
```

```
Question: Who is Queequeg?

Model: GPT-OSS 20B (FMUP)

Answer:
Queequeg is a harpooneer from the South Seas who becomes Ishmael's close companion on the Pequod...

Sources:
  - Chapter 110: Queequeg in His Coffin
  - Chapter 27: Knights and Squires
  - Chapter 33: The Specksnyder
```

The retrieval logic is no longer a single embedding lookup on the raw user question. It now does three extra things that make a visible difference for character-focused questions.

### Query expansion

If the prompt looks like it contains a character name, the system expands it into related retrieval queries such as:

```text
Who is Queequeg?
Queequeg
Queequeg character
describe Queequeg
Queequeg is
who is Queequeg harpooneer
```

That matters because vector retrieval is sensitive to phrasing. A question phrased as a full sentence does not always retrieve the same chunks as a compact name-based query.

### Lightweight reranking

Candidate chunks are reranked using a simple scoring rule that combines:

- embedding distance
- overlap with important query terms
- overlap with chapter titles
- explicit matches to likely character names
- a penalty for tiny heading-only chunks

This is a simple scoring rule, not a full reranker. It improves practical retrieval without adding complexity.

### Source-aware prompting

The prompt explicitly tells the model to name the most relevant chapter in the first sentence when the context makes that clear. That makes the answer more useful as a reading guide, not just a text generation output.

## 6. Step 4 — the Streamlit interface

The current interface is a Streamlit app.

```bash
streamlit run 04_app.py
```

Then open `http://localhost:8501`.

The app keeps the same simple logic as the CLI version, but adds a few controls that make the system much easier to inspect.

### Model selector

The sidebar lets you choose the answer model without rebuilding embeddings. Available models depend on your Ollama setup. A small local model (`phi3:3.8b`) works as a fallback. Larger models require more hardware — either your own GPU or access to a shared server.

### Top-k selector

Retrieval depth is not fixed anymore. The sidebar includes a `top-k` slider so you can decide how many chunks are retrieved for each question.

That is useful because different question types want different retrieval behaviour:

- **factual** questions often work best with fewer, sharper chunks
- **interpretive** questions often benefit from more context

### Debug panel

The sidebar also shows the retrieved chunks from the last answer. This is one of the most important features in the whole project, because it lets you inspect whether a bad answer is caused by bad generation or bad retrieval.

If the retrieved chunks are irrelevant, changing the model will rarely solve the real problem.

## 7. A realistic workflow

Here is what a full run looks like from an empty clone.

```bash
git clone <repo-url> moby-rag
cd moby-rag

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

```bash
python 01_download.py
python 02_ingest.py
```

```bash
python 03_rag.py "What does the whiteness of the whale symbolize?"
python 03_rag.py "How does Ishmael's relationship with Queequeg evolve?"
```

```bash
streamlit run 04_app.py
```

Once the vector store exists, you do not need to repeat steps 1 and 2 unless you change the corpus or chunking strategy.

## 8. Why this project is useful beyond literature

This is not just a literary toy.

This project is a compact teaching example of a local RAG pipeline. If you understand this version, you understand the essential mechanics you would also use for a guideline assistant, a protocol search tool, a thesis chatbot, or a domain-specific question-answering system over clinical documentation.

The pattern is the same:

1. Start with a trusted corpus.
2. Clean it into a stable text representation.
3. Chunk it in a way that preserves meaning.
4. Embed and store those chunks.
5. Retrieve the best matches for a user question.
6. Ask a chat model to answer only from that retrieved context.

The corpus happens to be *Moby-Dick*. The architecture is general.

## 9. What I would inspect first if the answers seem poor

When a RAG system gives a weak answer, the instinct is often to blame the model. More often, the problem is earlier in the pipeline.

Here is the order I would check.

### 1. Are the retrieved chunks relevant?

If not, the answer model is being asked to improvise from the wrong evidence.

### 2. Is the chunk size too large or too small?

Very large chunks dilute relevance. Very small chunks lose narrative context.

### 3. Is the question phrased in a way the retriever handles well?

Character names, titles, and compact noun phrases often retrieve better than long conversational prompts.

### 4. Is the answer model following the instruction to stay grounded?

If retrieval looks good but the answer still wanders, the issue is in prompting or model behaviour rather than vector search.

### 5. Is the corpus itself clean?

If chapter boundaries or Gutenberg boilerplate are wrong, retrieval quality will be noisy from the start.

## 10. Summary

| Component | What it does |
|---|---|
| `01_download.py` | Downloads and cleans the novel |
| `02_ingest.py` | Splits chapters, sub-chunks text, generates embeddings, stores Chroma vectors |
| `03_rag.py` | Retrieves relevant chunks and sends grounded prompts to the selected model |
| `04_app.py` | Provides a Streamlit chat UI with model and `top-k` controls |
| `chroma_db/` | Stores the local vector index |

: Moby-RAG at a glance {.striped .hover}

The most useful property of a small RAG project is not that it answers every question perfectly. It is that you can see *why* it answered the way it did.

If you want to adapt this pattern to another text, the next step is not rewriting the whole stack. It is replacing the corpus, adjusting the splitting logic, rebuilding the vector store, and keeping the rest of the pipeline simple.

## Related notes

- [OpenCode: an AI research assistant in your terminal](/notes/opencode/): the agent side of the same local-first stance; the Ollama section there is the same one used here as the answer model.
- [Implementing AI in health: some things I want to preserve](/essays/ai-health/): the philosophical frame for preferring legible, local AI in clinical and research settings.

If you have any comments or questions, feel free to [reach out](mailto:tiagojacinto@med.up.pt)).
