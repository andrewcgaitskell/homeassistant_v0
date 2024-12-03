rm init.sql

source createinitsql.sh

ENVIRONMENT_PATH="/opt/dmtools/code/dmtools/"
DATA_PATH="/data/prod/"
STATUS="prod"

rm -rf "${DATA_PATH}data/postgres/data"
mkdir -p "${DATA_PATH}data/postgres/data"

## remove this once in production
rm -rf "${DATA_PATH}data/postgres/backup"
mkdir -p "${DATA_PATH}data/postgres/backup"

cd "${ENVIRONMENT_PATH}basecode/postgres"

rm "${ENVIRONMENT_PATH}basecode/postgres/initsql.sh"

source "${ENVIRONMENT_PATH}basecode/postgres/createinitsql.sh"

podman stop postgrescontainer${STATUS}
podman rm postgrescontainer${STATUS}
podman rmi postgres_image_1${STATUS}

podman build \
--build-arg=BUILD_ENV_UID=${ENV_UID} \
--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
--build-arg=BUILD_ENV_GID=${ENV_GID} \
--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
--build-arg=BUILD_ENV_POSTGRES_DB_HOST=${ENV_POSTGRES_DB_HOST} \
--build-arg=BUILD_ENV_POSTGRES_USER=${ENV_POSTGRES_USER} \
--build-arg=BUILD_ENV_POSTGRES_PASSWORD=${ENV_POSTGRES_PASSWORD} \
--build-arg=BUILD_ENV_POSTGRES_DB=${ENV_POSTGRES_DB} \
-t postgres_image_1${STATUS} .

uid=${ENV_UID} ##1001
gid=${ENV_GID} ##1002

subuidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
subgidSize=$(( $(podman info --format "{{ range \
   .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))

podman run -dt \
--name postgrescontainer${STATUS} \
--pod ${STATUS}_pod \
--volume ${DATA_PATH}data/postgres/data:/var/lib/postgresql/data:z \
--volume ${DATA_PATH}data/postgres/backup:/backup:z \
--user $uid:$gid \
localhost/postgres_image_1${STATUS}:latest

