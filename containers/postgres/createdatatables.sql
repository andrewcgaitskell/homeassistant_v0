-- Create the "node" table
CREATE TABLE IF NOT EXISTS data.node (
    id SERIAL PRIMARY KEY,
    type  VARCHAR, 
    properties JSONB,  -- JSONB column for storing attributes
    created TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Timestamp with timezone
    updated TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Timestamp with timezone
    archived TIMESTAMPTZ  -- Nullable timestamp with timezone
);


CREATE TABLE IF NOT EXISTS data.relationship (
    id SERIAL PRIMARY KEY,
    label VARCHAR,
    properties JSONB,              -- JSONB column for storing attributes
    source INTEGER,               -- Reference to a node, without foreign key constraint
    destination INTEGER,                 -- Reference to a node, without foreign key constraint
    created TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    archived TIMESTAMPTZ        -- Nullable timestamp with timezone
);
