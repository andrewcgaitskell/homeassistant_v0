CREATE DATABASE about OWNER aboutuser;

\c about

CREATE SCHEMA about;

GRANT ALL PRIVILEGES ON DATABASE about TO aboutuser;

GRANT ALL PRIVILEGES ON SCHEMA public TO aboutuser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO aboutuser;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO aboutuser;

ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO aboutuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO aboutuser;

GRANT ALL PRIVILEGES ON SCHEMA about TO aboutuser;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA about TO aboutuser;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA about TO aboutuser;

ALTER DEFAULT PRIVILEGES IN SCHEMA about GRANT ALL ON TABLES TO aboutuser;
ALTER DEFAULT PRIVILEGES IN SCHEMA about GRANT ALL ON SEQUENCES TO aboutuser;