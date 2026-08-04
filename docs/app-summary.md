# Noosphere (Working Name)

## Vision

Noosphere is a **local-first knowledge management system centered around books and works**, not merely a library catalog or PDF manager.

The goal is to unify everything related to a work—physical copies, PDFs, notes, authors, external resources, and personal knowledge—into a single coherent application.

The philosophy is:

> **Knowledge should be organized around works, while data remains owned by the user.**

---

# Core Problem

Current workflow is fragmented.

```text
Physical books
        ↓
Bookshelves

PDFs
        ↓
Directories

Book notes
        ↓
Obsidian

Useful articles
        ↓
Browser bookmarks

Author information
        ↓
Wikipedia / SEP

Memory
        ↓
"I think I own this book..."
```

Information is scattered across multiple applications.

Noosphere aims to become the central place where everything related to a work is connected.

---

# Main Concept

The application is **work-centric**, not book-centric.

Example:

```
Meditations
│
├── Author
├── Physical copies
├── PDF copies
├── Personal notes
├── Quotes
├── External links
├── Related works
└── Personal metadata
```

Everything revolves around the intellectual work.

---

# Terminology

## Work

An intellectual creation.

Examples:

- The Republic
- Meditations
- Crime and Punishment

---

## Volume

A physical or digital publication containing one or more works.

Examples:

- Penguin edition of Meditations
- Gredos Volume 24
- Complete Works of Plato

A volume may contain multiple works.

A work may exist in multiple volumes.

---

## Copy

A specific owned copy.

Examples:

- Physical hardcover
- Second-hand paperback
- PDF
- Scanned edition

Copies belong to volumes.

---

# Purpose

Noosphere is **not** trying to replace Calibre.

It is **not** trying to replace Obsidian.

Instead it connects:

- library
- notes
- PDFs
- knowledge
- references

around works.

---

# Platforms

## Desktop Application

Primary application.

Responsibilities:

- Manage library
- Import books
- Scan PDFs
- Open PDFs
- Edit metadata
- Manage shelves
- Write notes
- Add external links

The desktop application is the source of truth.

---

## Mobile Application

Secondary application.

Purpose:

- Search collection
- Check whether a work exists
- View shelves
- Read notes
- Read external links
- Browse authors

Should work offline.

No heavy editing.

---

# Local-first Philosophy

User owns the data.

Cloud is optional.

Data should remain usable without Noosphere.

Avoid vendor lock-in.

---

# Database Choice

Use SQLite locally on each device.

Each device has its own database:

Main PC
 └── noosphere.db

Laptop
 └── noosphere.db

Phone
 └── noosphere.db

SQLite stores:

books metadata
authors
tags
categories
reading status
notes
links
highlights metadata
reading progress
relationships between books and concepts


# Notes

Book notes belong inside Noosphere.

Reason:

Today the workflow is:

```
Book

↓

Remember there is an Obsidian note somewhere.
```

Desired workflow:

```
Book

↓

Notes
```

One click.

---

# PDFs

Desktop has the complete pdf book library and secondary devices have a copy of "currently reading" books only.

Example:

```
Meditations

✓ Physical copy

Shelf A3

✓ PDF available
```

No need to upload hundreds of gigabytes to the cloud.

---

# Synchronization

Knowledge
─────────
Notes
Links
Tags
Reading progress
Catalog
(always synchronized)

Reading
────────
Currently reading PDFs
(selected synchronization)

Library
────────
Complete archive
(main PC)

---

# Technologies (Current Direction)

## Desktop

- React
- Tauri
- SQLite 
- Markdown
- Local filesystem

---

## Database

SQLite

---

## Mobile

- React Native
- Expo
- Local SQLite
- Synchronization with cloud metadata

---

# Possible app file structure 

Noosphere/
│
├── Database/
│   └── noosphere.db          # Catalog, notes, links, reading state
│
├── Repository/               # Managed PDF storage
│   ├── 00/
│   ├── 01/
│   ├── ...
│
├── Active/                   # Only books selected for cross-device reading
│
├── Covers/                   # Generated cover images
│
├── Cache/                    # Temporary files, thumbnails, search indexes
│
├── Config/                   # User preferences and sync configuration
│
└── Logs/                     # Optional diagnostics

---

# Design Philosophy

Noosphere should answer questions like:

- Do I own this work?
- Where is my physical copy?
- Do I have a PDF?
- What have I written about it?
- Which works are related?
- Which philosopher influenced this author?
- Where can I read a trusted article?

instead of merely listing files.

---

# Long-term Vision

Noosphere should feel like a personal "sphere of human thought."

Books become entry points into knowledge.

Works connect to:

- authors
- notes
- philosophy
- history
- external references
- owned copies

instead of existing as isolated entries in a library database.

The application should make navigating one's personal library feel like navigating an interconnected knowledge graph rather than browsing folders.
