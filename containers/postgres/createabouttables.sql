-- Create the "node" table
CREATE TABLE IF NOT EXISTS about.node (
    id SERIAL PRIMARY KEY,
    type  VARCHAR, 
    properties JSONB,  -- JSONB column for storing attributes
    created TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Timestamp with timezone
    updated TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,  -- Timestamp with timezone
    archived TIMESTAMPTZ  -- Nullable timestamp with timezone
);

-- We are keeping security related information in a separate database, hence nodes cross between databases
CREATE TABLE IF NOT EXISTS about.relationship (
    id SERIAL PRIMARY KEY,
    label VARCHAR,
    properties JSONB,              -- JSONB column for storing attributes
    source INTEGER,               -- Reference to a node, without foreign key constraint
    destination INTEGER,                 -- Reference to a node, without foreign key constraint
    created TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    archived TIMESTAMPTZ        -- Nullable timestamp with timezone
);
