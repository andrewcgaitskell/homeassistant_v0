source setenv.sh

rm ../postgres/init.sql

echo "\c data" > ../postgres/init.sql

echo "CREATE SCHEMA data;" >> ../postgres/init.sql

echo "GRANT ALL PRIVILEGES ON SCHEMA data TO ${ENV_POSTGRES_USER};" >> ../postgres/init.sql

echo "ALTER ROLE ${ENV_POSTGRES_USER} SET search_path TO data, public;" >> ../postgres/init.sql

echo "SET search_path TO data;" >> ../postgres/init.sql

echo "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA data TO ${ENV_POSTGRES_USER};" >> ../postgres/init.sql

echo "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ${ENV_POSTGRES_USER};" >> ../postgres/init.sql

echo "GRANT ALL PRIVILEGES ON SCHEMA public TO ${ENV_POSTGRES_USER};" >> ../postgres/init.sql

echo "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO ${ENV_POSTGRES_USER};" >> ../postgres/init.sql

echo "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO ${ENV_POSTGRES_USER};" >> ../postgres/init.sql

echo "ALTER DEFAULT PRIVILEGES IN SCHEMA data GRANT ALL PRIVILEGES ON TABLES TO ${ENV_POSTGRES_USER};" >> ../postgres/init.sqll

echo "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO ${ENV_POSTGRES_USER};" >> ../postgres/init.sql

echo "ALTER SCHEMA public OWNER TO ${ENV_POSTGRES_USER};" >> ../postgres/init.sql

echo "ALTER SCHEMA data OWNER TO ${ENV_POSTGRES_USER};" >> ../postgres/init.sql


echo "CREATE USER wikiuser WITH PASSWORD '${ENV_WIKI_PASSWORD}';" >> ../postgres/init.sql

echo "$(cat createwikidatabase.sql)" >> ../postgres/init.sql

echo "CREATE USER aboutuser WITH PASSWORD '${ENV_ABOUT_PASSWORD}';" >> ../postgres/init.sql

echo "$(cat createaboutdatabase.sql)" >> ../postgres/init.sql

echo "\c about" >> ../postgres/init.sql

echo "$(cat createabouttables.sql)" >> ../postgres/init.sql

echo "\c data" >> ../postgres/init.sql

echo "$(cat createdatatables.sql)" >> ../postgres/init.sql


