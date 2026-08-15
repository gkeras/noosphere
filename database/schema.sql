CREATE TABLE people (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    slug TEXT NOT NULL UNIQUE,
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now'))
);
CREATE TABLE works (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    original_title TEXT,
    original_language TEXT,
    first_publication_year INTEGER,
    slug TEXT NOT NULL UNIQUE,
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    deleted_at TEXT
);
CREATE TABLE work_notes (
    id INTEGER PRIMARY KEY,
    work_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    path TEXT NOT NULL,
    note_type TEXT CHECK( note_type IN ( 'note', 'quote', 'summary' ) ) NOT NULL DEFAULT 'note',
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    updated_at TEXT,
    deleted_at TEXT,
    FOREIGN KEY(work_id) REFERENCES works(id)
);
CREATE TABLE person_notes (
    id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    title TEXT NOT NULL,
    path TEXT NOT NULL,
    note_type TEXT CHECK( note_type IN ( 'note', 'quote', 'summary' ) ) NOT NULL DEFAULT 'note',
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    updated_at TEXT,
    deleted_at TEXT,
    FOREIGN KEY(person_id) REFERENCES people(id)
);
CREATE TABLE work_links (
    id INTEGER PRIMARY KEY,
    work_id INTEGER NOT NULL,
    url TEXT NOT NULL,
    label TEXT,
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY(work_id) REFERENCES works(id)
);
CREATE TABLE person_links (
    id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    url TEXT NOT NULL,
    label TEXT,
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY(person_id) REFERENCES people(id)
);
CREATE TABLE work_authors (
    work_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    PRIMARY KEY (work_id, person_id),
    FOREIGN KEY(work_id) REFERENCES works(id),
    FOREIGN KEY(person_id) REFERENCES people(id)
);
CREATE TABLE volumes (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    publisher_id INTEGER,
    collection_id INTEGER,
    collection_number INTEGER,
    edition TEXT,
    publication_year INTEGER,
    language TEXT,
    isbn TEXT,
    cover_path TEXT,
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    deleted_at TEXT,
    FOREIGN KEY(publisher_id) REFERENCES publishers(id),
    FOREIGN KEY(collection_id) REFERENCES collections(id)
);
CREATE TABLE collections (
    id INTEGER PRIMARY KEY,
    name TEXT,
    publisher_id INTEGER,
    FOREIGN KEY(publisher_id) REFERENCES publishers(id)
);
CREATE TABLE volume_people (
    volume_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    role_id INTEGER NOT NULL,
    PRIMARY KEY (volume_id, person_id, role_id),
    FOREIGN KEY(volume_id) REFERENCES volumes(id),
    FOREIGN KEY(person_id) REFERENCES people(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);
CREATE TABLE roles (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL UNIQUE
);
CREATE TABLE volume_works (
    id INTEGER PRIMARY KEY,
    volume_id INTEGER NOT NULL,
    work_id INTEGER NOT NULL,
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY(volume_id) REFERENCES volumes(id),
    FOREIGN KEY(work_id) REFERENCES works(id)
);
CREATE TABLE volume_works_people (
    id INTEGER PRIMARY KEY,
    volume_work_id INTEGER NOT NULL,
    person_id INTEGER NOT NULL,
    role_id INTEGER NOT NULL,
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    FOREIGN KEY(volume_work_id) REFERENCES volume_works(id),
    FOREIGN KEY(person_id) REFERENCES people(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);
CREATE TABLE publishers (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    country TEXT
);
CREATE TABLE copies (
    id INTEGER PRIMARY KEY,
    volume_id INTEGER NOT NULL,
    copy_format TEXT CHECK( copy_format IN ( 'physical', 'pdf', 'epub' ) ) NOT NULL,
    copy_condition TEXT CHECK( copy_condition IN ( 'excellent', 'good', 'acceptable', 'bad' ) ),
    shelf TEXT,
    file_path TEXT,
    file_hash TEXT,
    started_at TEXT,
    finished_at TEXT,
    created_at TEXT NOT NULL DEFAULT (strftime('%Y-%m-%dT%H:%M:%fZ', 'now')),
    deleted_at TEXT,
    FOREIGN KEY(volume_id) REFERENCES volumes(id)
);

CREATE UNIQUE INDEX idx_volumes_isbn_active ON volumes(isbn) WHERE deleted_at IS NULL;
CREATE UNIQUE INDEX idx_volume_works_unique ON volume_works (volume_id, work_id);
CREATE UNIQUE INDEX idx_volume_person_rol_unique ON volume_works_people (volume_work_id, person_id, role_id);

-- FK indexes: single-column FKs with no existing index coverage
CREATE INDEX idx_work_notes_work_id ON work_notes(work_id);
CREATE INDEX idx_person_notes_person_id ON person_notes(person_id);
CREATE INDEX idx_work_links_work_id ON work_links(work_id);
CREATE INDEX idx_person_links_person_id ON person_links(person_id);
CREATE INDEX idx_volumes_publisher_id ON volumes(publisher_id);
CREATE INDEX idx_volumes_collection_id ON volumes(collection_id);
CREATE INDEX idx_collections_publisher_id ON collections(publisher_id);
CREATE INDEX idx_copies_volume_id ON copies(volume_id);
 
-- FK indexes: second/third column of a composite PK or unique index,
-- not covered by the leftmost-prefix rule above
CREATE INDEX idx_work_authors_person_id ON work_authors(person_id);
CREATE INDEX idx_volume_people_person_id ON volume_people(person_id);
CREATE INDEX idx_volume_people_role_id ON volume_people(role_id);
CREATE INDEX idx_volume_works_work_id ON volume_works(work_id);
CREATE INDEX idx_volume_works_people_person_id ON volume_works_people(person_id);
CREATE INDEX idx_volume_works_people_role_id ON volume_works_people(role_id);

CREATE VIEW copies_with_status AS
SELECT *,
    CASE
        WHEN finished_at IS NOT NULL THEN 'finished'
        WHEN started_at IS NOT NULL THEN 'currently_reading'
        ELSE 'unread'
    END AS reading_status
FROM copies;

CREATE TRIGGER trg_work_notes_updated_at
AFTER UPDATE ON work_notes
FOR EACH ROW
WHEN NEW.updated_at IS OLD.updated_at
BEGIN
    UPDATE work_notes SET updated_at = strftime('%Y-%m-%dT%H:%M:%fZ', 'now') WHERE id = OLD.id;
END;

CREATE TRIGGER trg_person_notes_updated_at
AFTER UPDATE ON person_notes
FOR EACH ROW
WHEN NEW.updated_at IS OLD.updated_at
BEGIN
    UPDATE person_notes SET updated_at = strftime('%Y-%m-%dT%H:%M:%fZ', 'now') WHERE id = OLD.id;
END;
