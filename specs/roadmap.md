# Roadmap

Each item is a user story: `As a <user>, I want <task>, so that <benefit>.`
When a story gets a spec, append `(spec: specs/YYYY-MM-DD-name)`. Tick it when merged.

## Phase 1: Walking skeleton

The thinnest end-to-end slice: app boots, user can add a work and see it.

- [ ] As a user, I want to add a new work with its title and author, so that I can start building my library.
- [ ] As a user, I want to see a list of all my works, so that I can browse what I have.
- [ ] As a user, I want to view a work's details and its author, so that I can see everything about it in one place.

## Phase 2: Full catalog CRUD

Complete creation, editing, and deletion for all core entities.

- [ ] As a user, I want to edit a work's details, so that I can correct or update information.
- [ ] As a user, I want to remove a work from my library, so that I can keep my catalog clean.
- [ ] As a user, I want to manage people (create, list, edit, remove), so that I can maintain accurate author and contributor records.
- [ ] As a user, I want to add a volume (edition) to a work, so that I can track which publications I own.
- [ ] As a user, I want to add a copy to a volume with its format and condition, so that I can record each physical or digital instance I own.
- [ ] As a user, I want to track a copy's reading status (unread / reading / finished), so that I know what I've read and what's pending.
- [ ] As a user, I want to record a copy's shelf or location, so that I can find my physical books.

## Phase 3: Search and notes

Find things fast and start capturing knowledge.

- [ ] As a user, I want to search my library by title or author, so that I can quickly find a specific work.
- [ ] As a user, I want to filter works by reading status, so that I can see what I've read and what's pending.
- [ ] As a user, I want to create a note (note, quote, or summary) linked to a work, so that I can capture my thoughts alongside the book.
- [ ] As a user, I want to view and edit my notes on a work, so that I can revisit and refine what I've written.
- [ ] As a user, I want to create and view notes linked to a person, so that I can record insights about an author or thinker.

## Phase 4: Relationships and navigation

Connect entities and let the user move between them.

- [ ] As a user, I want to assign roles (translator, editor) to people on a volume, so that I can track who contributed to each edition.
- [ ] As a user, I want to manage publishers and collections, so that I can organize volumes by publisher series.
- [ ] As a user, I want to navigate from a work to its volumes and copies, so that I can see every edition and instance I own.
- [ ] As a user, I want to navigate from a person to all their works, so that I can explore an author's catalog.

## Later

- [ ] As a user, I want to save external links on a work, so that I can collect articles and references in one place.
- [ ] As a user, I want to attach a PDF file to a copy and open it, so that I can access my digital books from the app.
- [ ] As a user, I want to import works in bulk, so that I can populate my library without entering each one manually.
