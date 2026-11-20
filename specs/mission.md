# Mission

## Core idea

Noosphere is a local-first knowledge management system centered around intellectual works. It unifies physical copies, digital files, notes, authors, and external resources into a single coherent application so that knowledge is organized around *works*, not scattered across tools.

## Audience

A single user (the owner) who maintains a personal library of books, articles, and other intellectual works across physical and digital formats.

## Domain terms

- **Work:** An intellectual creation (e.g. *Meditations*, *The Republic*). The central entity everything else connects to.
- **Volume:** A published edition containing one or more works (e.g. "Penguin Meditations", "Gredos Complete Plato"). A volume may bundle several works; a work may appear in many volumes.
- **Copy:** A specific owned instance of a volume — physical book, PDF, EPUB. Copies track format, condition, shelf location, file path, and reading status.
- **Person:** An author, translator, editor, or other contributor linked to works and volumes through roles.
- **Note:** A Markdown document (note, quote, or summary) attached to a work or person, stored as a file on the local filesystem.

## Principles

1. **Work-centric, not file-centric.** The work is the primary object; volumes and copies are secondary.
2. **Local-first.** All data lives on the user's machine. Cloud is optional and out of scope for v1.
3. **User owns the data.** SQLite database and Markdown files — no proprietary formats, no vendor lock-in.
4. **Simplicity over features.** Ship fewer things well. No feature creep.
5. **Spec before code.** Every feature starts with a specification; nothing is built without one.

## v1 scope

- Desktop application only (Tauri).
- Full CRUD for the core catalog: Works, Volumes, Copies, People.
- Author / contributor associations (work ↔ person, volume ↔ person with roles).
- Publishers, collections, and edition metadata on volumes.
- Reading status tracking on copies (unread → reading → finished).
- Shelves and physical location tracking on copies.
- Search and filter the library (by title, author, reading status).
- Notes: create, view, edit, and delete Markdown notes (note, quote, summary) linked to works and people. Editor approach TBD (basic textarea for v1; integrated Markdown editor is a later refinement).
- Database bootstrap with migrations.

## Non-goals

- Cloud synchronization or multi-device sync.
- Mobile application.
- Integrated rich Markdown editor (a basic textarea is enough for v1).
- PDF viewer or reader.
- Import / batch operations.
- External API integrations (e.g. Open Library, Google Books).
