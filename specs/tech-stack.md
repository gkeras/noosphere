# Tech Stack

## Stack

| Layer | Technology | Why |
|---|---|---|
| Desktop runtime | **Tauri 2** (Rust) | Native performance, small binary, local filesystem access, SQLite embedding. |
| Frontend | **React 19 + TypeScript** | Component model, strict types, large ecosystem. |
| Bundler | **Vite 7** | Fast HMR, first-class Tauri integration. |
| Database | **SQLite** via `rusqlite` | Local-first, single-file, zero-config. |
| Migrations | **refinery** (embedded) | Compile-time embedded SQL migrations in Rust. |

## Architecture rules (never violate)

1. **Tauri commands are the only bridge.** The frontend never touches the filesystem or database directly — all data flows through `#[tauri::command]` functions.
2. **One Tauri command per use case.** Commands are thin: validate input, call a domain function, return a result. No business logic in the command handler itself.
3. **Frontend is presentation only.** React components fetch data via `invoke()`, display it, and send user actions back. No data transformation beyond display formatting.
4. **No new dependencies without explicit approval.**

## Data rules

- **Source of truth:** The applied migration files under `src-tauri/migrations/`. Whatever has been migrated is the real schema.
- **Design reference:** [`database/target-schema.sql`](file:///home/marsz/Documents/noosphere/database/target-schema.sql) is a design goal showing the intended final shape of the database. It is not executed and may be revised as features are built. `database/schema.dbml` is deprecated reference only.
- **Migrations:** SQL files under `src-tauri/migrations/`, applied by `refinery` at startup. Past migrations are immutable — schema changes go into new migration files. Each feature spec decides which tables/columns from `target-schema.sql` to bring in.
- **Soft deletes:** Tables with a `deleted_at` column (`works`, `volumes`, `copies`, `work_notes`, `person_notes`) are never physically deleted with `DELETE`. Set `deleted_at` instead. All read queries filter with `WHERE deleted_at IS NULL`.
- **Timestamps:** Stored as ISO 8601 text (`strftime('%Y-%m-%dT%H:%M:%fZ', 'now')`). Always UTC.
- **Connection pragmas:** Every connection enforces `foreign_keys = ON`, `journal_mode = WAL`, `synchronous = NORMAL`.

## Conventions

- **Language:** All-English policy. Code, docs, UI copy, error messages, commit messages — everything in English.
- **TypeScript:** Strict mode (`strict: true`, `noUnusedLocals`, `noUnusedParameters`). No `any` without a comment explaining why.
- **Rust:** Follow `clippy` defaults. Use `thiserror` for typed errors exposed to the frontend.
- **Folder layout (frontend):**
  ```
  src/
    components/    # Reusable UI components
    pages/         # Top-level views / screens
    hooks/         # Custom React hooks (including Tauri invoke wrappers)
    types/         # Shared TypeScript types
    lib/           # Utility functions
  ```
- **Folder layout (backend):**
  ```
  src-tauri/
    src/
      main.rs      # Entry point
      lib.rs       # Tauri builder setup
      commands/    # Tauri command handlers (one file per domain)
      db/          # Database connection, migrations, query functions
      models/      # Rust structs for domain entities
    migrations/    # refinery SQL migration files
  ```
- **Error handling:** Rust functions return `Result<T, E>`. Tauri commands map errors to serializable types the frontend can display. Frontend shows user-friendly messages; raw errors go to the console.
- **Naming:** snake_case in Rust and SQL, camelCase in TypeScript. Database columns match schema.sql exactly.

## Verification commands

| Command | Run from | Status |
|---|---|---|
| `npx tsc --noEmit` | project root | works |
| `npm run build` | project root | works (frontend only) |
| `cargo check` | `src-tauri/` | works |
| `cargo test` | `src-tauri/` | works (no tests yet) |
| `cargo clippy` | `src-tauri/` | to configure |
| `npm run tauri build` | project root | to verify |

## Git

- Never work on the default branch (`main`). Branches: `feat/<story>`, `fix/<description>`, `docs/<name>`.
- Atomic commits, Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`, `test:`).
- Merge through a pull request if the remote is set up, otherwise local merge, after validation passes.
