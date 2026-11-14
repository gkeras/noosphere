# Project Rules: Noosphere

## 1. Context & Current Scope
- **Product:** A *local-first* knowledge management system centered around intellectual works (`Work -> Volume -> Copy`). See `@docs/VISION.md` for full context.
- **Active Scope (Phase 1):** Desktop application only. Do not implement cloud synchronization or mobile features unless explicitly defined in a specification.

## 2. Tech Stack
- **Frontend:** React + TypeScript (clean, modular UI without unnecessary visual complexity).
- **Backend / Runtime:** Tauri (Rust).
- **Database:** Local SQLite strictly defined in `@database/schema.sql`.

## 3. Language Conventions
- **All-English Policy:** All communication, documentation, specifications, code identifiers (variables, functions, tables, columns), UI copy, and error messages must be written in **English**.

## 4. Database & Data Integrity Rules
- **Single Source of Truth:** All queries and migrations must strictly respect the types, `CHECK` constraints, indexes, and views in `@database/schema.sql`.
- **Soft Deletes:** Never physically delete rows using `DELETE` on tables with a `deleted_at` column (`works`, `volumes`, `copies`, `work_notes`, `person_notes`). Always filter with `WHERE deleted_at IS NULL` in read queries.

## 5. Mandatory Workflow (Spec-Driven Development)
- **Step 1 (Specification):** Do not write production code without an existing specification file in `/specs` (e.g., `specs/01-feature-name.md`) defining business rules, edge cases, and acceptance criteria.
- **Step 2 (Planning):** Before creating or modifying source files, present a concise technical plan listing affected files and wait for explicit approval.
- **Step 3 (Implementation & Testing):** No task is complete without corresponding automated tests and verification that the project compiles cleanly.

## 6. Git Conventions
- Keep changes atomic and suggest commit messages following the *Conventional Commits* standard (`feat:`, `fix:`, `docs:`, `chore:`, `test:`).
