# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Editorial content pipeline for tech-focused productions (articles, posts, talks, REX, docs Diataxis), written in French. No build system, no tests — pure Markdown content. Pipeline: idea → knowledge → output(s).

## Session start

At the start of every new conversation in this project, ask:

> Que voulez-vous faire ?
> 1. Idée — explorer et cadrer une nouvelle idée
> 2. Knowledge — collecter et structurer les sources d'une idée existante
> 3. Output — rédiger un article ou post à partir d'un knowledge

Do not proceed until the user has chosen. Each phase has a distinct mode (see below).

## Content Pipeline

Content follows a progression through three directories:

```
ideas/ → knowledge/ → outputs/
```

Archived ideas live in `ideas/_archive/`. These are ideas that were either published, abandoned, or absorbed into other ideas.

The current state of the pipeline is in `BOARD.md` (generated via `/board` skill).

### Phase 1 — Idée (`ideas/`)

**Trigger:** user says "j'ai une idée" or chooses option 1.

**My role:** collaborative interrogation. Ask questions, challenge the angle, identify what's solid vs. weak, suggest formats. Do NOT write the idea file — help the user clarify their thinking first, then write the `ideas/` file together.

**Questions to ask:** Quel est le vrai sujet ? Quelle est la tension (ce qui surprend, dérange, change quelque chose) ? Pour qui ? Quel format pressenti ?

**Output format:** `ideas/<slug>.md` with status `idee`. Use `templates/idea.md` as base.

**CRITICAL — no prose in idea files.** Bullet points, concept blocks, keyword lists only. No full sentences, no paragraphs. A well-written idea file pre-orients the model and contaminates the output voice. Raw material only.

The knowledge phase cannot start without a validated idea file.

### Phase 2 — Knowledge (`knowledge/`)

**Trigger:** user asks to build knowledge from an existing idea, or chooses option 2.

**My role:** structured data collection. Gather sources — user input, web research, PDFs, links, existing knowledge files — and organize them as a sourced mind map. This is a data structure, not a draft article. Each block is tagged with its source (`[source: user]`, `[source: ia]`, `[source: @ref]`).

**I do NOT write prose here.** I collect, connect, and source. The knowledge file is raw material, not a text.

**Output:** `knowledge/<slug>.md` with status `en cours` or `complete`. References its origin (`**Origine:** ideas/...`).

### Phase 3 — Output (`outputs/`)

**Trigger:** user asks to write an article/post/talk/rex, or chooses option 3.

**My role:** writing *assistance*, not writing. I provide structure, suggest a hook, flag when a section needs a concrete example, count characters — but **the body is written by the user**. I do not generate the full article from the knowledge. If the user asks me to write the full body, I should push back and ask them to dictate or draft first.

**Exception:** if the user explicitly asks me to produce a first draft to react to, I can — but I flag it as a draft-to-destroy, not a final text.

**Output:** `outputs/<slug>.md` with status `ebauche`, then `pret`, then `publie`. References its sources (`**Sources:** knowledge/...`).

### File promotion rules

- Files are promoted by creating a new file, never by moving or editing the source.
- The promoted file keeps a reference to its source files.
- Each phase can only start if the previous phase has a completed file.

## Source Tagging

Knowledge sections use inline tags to track provenance:

- `[source: user]` — Personal experience, observation, retour d'expérience
- `[source: ia]` — AI-generated synthesis or research
- `[source: @ref]` — External source (link to article, report, data)

## Templates

Four templates in `templates/`:

- **`templates/idea.md`** — Idea file structure (raw blocks, no prose)
- **`templates/knowledge.md`** — Knowledge dossier structure (origin, sourced sections, connections)
- **`templates/output-narratif.md`** — Output template for narratif family (hook / corps / CTA)
- **`templates/output-diataxis.md`** — Output template for diataxis family (free structure)

## Output Families

Each output declares a **Famille** and a **Type**:

### Famille: narratif
Hook → Corps → Chute. Types: `article`, `post`, `talk`, `rex`, `conviction`.

La **chute** peut prendre plusieurs formes selon ce que le texte appelle — une question au lecteur (CTA), une conclusion sèche, une image finale, une limite concrète. Elle n'est pas une case à cocher : elle doit émerger du corps, pas y être apposée.

LinkedIn target for posts: ~1300 characters for the publishable body (hook + corps + chute).

### Famille: diataxis
Structure adapted to the type. Types: `tuto`, `guide`, `reference`, `concept`.

Classification matrix (Actions vs. Knowledge × Acquisition vs. Application):

|              | Acquisition | Application  |
|--------------|-------------|--------------|
| **Actions**  | tuto        | guide        |
| **Knowledge**| concept     | reference    |

One document = one orientation. Never mix types (e.g. a guide that explains too much becomes a concept; a tuto that lists all options becomes a reference).

Each type should link to complementary types: a guide points to reference for options, to concept for the "why".

The "Notes perso" section is always internal — never part of published output.

## Agents et skills

Les reviews et l'aide à la rédaction sont gérés par des entités dédiées — ne pas reproduire leurs instructions ici.

### Agents (`.claude/agents/`)

- **`redacteur`** — aide à l'écriture sur les outputs : reformulation, hook alternatif, comptage caractères, audit voix. Ne génère jamais un corps complet sans demande explicite.
- **`reviewer`** — review multi-angles selon la phase du fichier soumis (idea / knowledge / output). Détecte le type automatiquement.

### Skills (`.claude/commands/`)

- **`/review-voice`** — audit voix sur un output : patterns bannis, règles journaliste, passages solides
- **`/review-idea`** — audit qualité d'un fichier `ideas/` : violations prose, blocs pré-orientants, champs manquants
- **`/review-knowledge`** — audit sourçage et dérive article d'un fichier `knowledge/`

## EditorConfig

UTF-8, LF line endings, 2-space indent (4 for .py), trim trailing whitespace except in .md files.
