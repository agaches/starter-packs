# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This repository is a collection of starter packs — opinionated templates, base code, and project structures for various technical topics, ready to share or fork.

## Repository Organization

Each starter pack lives in its own top-level directory named after the technology or topic (e.g., `react-ts/`, `fastapi/`, `kafka-consumer/`). A pack typically contains:

- A `README.md` explaining the use case, prerequisites, and how to bootstrap
- Source code scaffolding ready to clone-and-go
- Configuration files (linters, formatters, CI, Docker, etc.) relevant to the stack

There is no monorepo build system at the root — each pack is self-contained and must be documented with its own setup instructions.

## Adding a New Starter Pack

1. Create a directory named after the stack or topic (kebab-case).
2. Include a `README.md` covering: purpose, prerequisites, how to run, and how to customize.
3. Keep dependencies pinned to a specific version so the template doesn't rot silently.
4. Add a one-line entry to a root `README.md` index (create it if missing) so packs are discoverable.

## Style

- Ton concis : moins de prose, plus de bullet points
- Pas de blabla introductif ni de phrases de transition inutiles
- Préférer une liste à puces à un paragraphe dès que possible

## Conventions

- Language/framework versions must be explicit — no `latest` tags in Docker images or version ranges in lockfiles.
- Each pack should be usable standalone: no cross-pack dependencies.
- Prefer documented, minimal configurations over feature-complete setups that are hard to understand at a glance.
