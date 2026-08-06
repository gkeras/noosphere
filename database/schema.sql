CREATE TABLE persons (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  created_at TEXT,
  updated_at TEXT
);
CREATE TABLE works (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  original_title TEXT,
  original_language TEXT,
  first_publication_year INTEGER,
  slug TEXT NOT NULL UNIQUE,
  created_at TEXT,
  updated_at TEXT
);
CREATE TABLE work_notes (
  id INTEGER PRIMARY KEY,
  work_id INTEGER,
  title TEXT NOT NULL,
  path TEXT NOT NULL,
  note_type TEXT CHECK( note_type IN ( 'note', 'quote', 'summary' ) ) NOT NULL,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(work_id) REFERENCES works(id)
);
CREATE TABLE person_notes (
  id INTEGER PRIMARY KEY,
  person_id INTEGER,
  title TEXT NOT NULL,
  path TEXT NOT NULL,
  note_type TEXT CHECK( note_type IN ( 'note', 'quote', 'summary' ) ) NOT NULL,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(person_id) REFERENCES persons(id)
);
CREATE TABLE work_links (
  id INTEGER PRIMARY KEY,
  work_id INTEGER,
  url TEXT NOT NULL,
  label TEXT,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(work_id) REFERENCES works(id)
);
CREATE TABLE person_links (
  id INTEGER PRIMARY KEY,
  person_id INTEGER,
  url TEXT NOT NULL,
  label TEXT,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(person_id) REFERENCES persons(id)
);
CREATE TABLE work_authors (
  work_id INTEGER,
  person_id INTEGER,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(work_id) REFERENCES works(id),
  FOREIGN KEY(person_id) REFERENCES persons(id)
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
  isbn TEXT UNIQUE,
  cover_path TEXT,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(publisher_id) REFERENCES publishers(id),
  FOREIGN KEY(collection_id) REFERENCES collections(id)
);
CREATE TABLE collections (
  id INTEGER PRIMARY KEY,
  name TEXT,
  publisher_id INTEGER,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(publisher_id) REFERENCES publishers(id)
);
CREATE TABLE volume_persons (
  volume_id INTEGER,
  person_id INTEGER,
  role_id INTEGER,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(volume_id) REFERENCES volumes(id),
  FOREIGN KEY(person_id) REFERENCES persons(id),
  FOREIGN KEY(role_id) REFERENCES roles(id)
);
CREATE TABLE roles (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL UNIQUE,
  created_at TEXT,
  updated_at TEXT
);
CREATE TABLE volume_works (
  id INTEGER PRIMARY KEY,
  volume_id INTEGER,
  work_id INTEGER,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(volume_id) REFERENCES volumes(id),
  FOREIGN KEY(work_id) REFERENCES works(id)
);
CREATE TABLE volume_works_persons (
  id INTEGER PRIMARY KEY,
  volume_work_id INTEGER,
  person_id INTEGER,
  role_id INTEGER,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(volume_work_id) REFERENCES volume_works(id),
  FOREIGN KEY(person_id) REFERENCES persons(id),
  FOREIGN KEY(role_id) REFERENCES roles(id)
);
CREATE TABLE publishers (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  country TEXT,
  created_at TEXT,
  updated_at TEXT
);
CREATE TABLE copies (
  id INTEGER PRIMARY KEY,
  volume_id INTEGER,
  copy_format TEXT CHECK( copy_format IN ( 'physical', 'pdf', 'epub' ) ) NOT NULL,
  copy_condition TEXT CHECK( copy_condition IN ( 'excellent', 'good', 'acceptable', 'bad' ) ) NOT NULL,
  shelf TEXT,
  file_path TEXT,
  file_hash TEXT,
  reading_status TEXT CHECK( reading_status IN ( 'unread', 'currently_reading', 'finished' ) ) NOT NULL,
  created_at TEXT,
  updated_at TEXT,
  FOREIGN KEY(volume_id) REFERENCES volumes(id)
);
CREATE INDEX _ff616b32198040088d8b8dce48decb48 ON work_authors (work_id, person_id);
CREATE INDEX _92246cf27dae4ac68ff6d3484aac6f60 ON volume_persons (volume_id, person_id);
CREATE UNIQUE INDEX _d146216fd22445da80f306853501ead0 ON volume_works (volume_id, work_id);
CREATE UNIQUE INDEX _f7877e41b9c64a1bab0e1efcf488799c ON volume_works_persons (volume_work_id, person_id, role_id);
