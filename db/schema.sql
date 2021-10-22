DROP TABLE IF EXISTS votes;

DROP TABLE IF EXISTS voters;

DROP TABLE IF EXISTS candidates;

DROP TABLE IF EXISTS parties;

CREATE TABLE parties (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description TEXT
);

CREATE TABLE candidates (
    id INTEGER AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    party_id INTEGER,
    industry_connected BOOLEAN NOT NULL,
    CONSTRAINT fk_party FOREIGN KEY (party_id) REFERENCES parties(id) ON DELETE
    SET
        NULL
);

CREATE TABLE voters (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(30) NOT NULL,
  email VARCHAR(50) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE votes (
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  voter_id INTEGER NOT NULL,
  candidate_id INTEGER NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT uc_voter UNIQUE (voter_id),
  CONSTRAINT fk_voter FOREIGN KEY (voter_id) REFERENCES voters(id) ON DELETE CASCADE,
  CONSTRAINT fk_candidate FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE
);

-- This will drop/delete the tables every time you run the schema.sql file, ensuring that you start with a clean slate.

--CONSTRAINT allows us to flag the party_id field as an official foreign key and tells SQL which table and field it references.
--In this case, it references the id field in the parties table.
--This ensures that no id can be inserted into the candidates table if it doesn't also exist in the parties table.

--DATETIME field's value will look something like 2020-01-01 13:00:00.

--DEFAULT: If you don't specify NOT NULL, then a field could potentially be NULL if that value isn't provided in an INSERT statement.
--With DEFAULT, however, you can specify what the value should be if no value is provided.

--CURRENT_TIMESTAMP: This will return the current date and time in the same 2020-01-01 13:00:00 format.
--Note that the time will be based on what time it is according to your server, not the client's machine.

-- The next two constraints are foreign key constraints, which you've seen before.
-- The difference now is the ON DELETE CASCADE statement.
-- Previously, ON DELETE SET NULL would set the record's field to NULL if the key from the reference table was deleted.
-- With ON DELETE CASCADE, deleting the reference key will also delete the entire row from this table.