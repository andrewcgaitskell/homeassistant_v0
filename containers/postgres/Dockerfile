FROM postgres:latest

ARG BUILD_ENV_USERNAME
ARG BUILD_ENV_UID
ARG BUILD_ENV_GID 
ARG BUILD_ENV_GROUPNAME

ARG BUILD_ENV_POSTGRES_USER
ARG BUILD_ENV_POSTGRES_PASSWORD
ARG BUILD_ENV_POSTGRES_DB

###

#podman build \
#--build-arg=BUILD_ENV_UID=${ENV_UID} \
#--build-arg=BUILD_ENV_USERNAME=${ENV_USERNAME} \
#--build-arg=BUILD_ENV_GID=${ENV_GID} \
#--build-arg=BUILD_ENV_GROUPNAME=${ENV_GROUPNAME} \
#--build-arg=BUILD_ENV_DB_HOST=${ENV_DB_HOST} \
#--build-arg=BUILD_ENV_POSTGRES_USER=${ENV_DB_USER} \
#--build-arg=BUILD_ENV_POSTGRES_PASSWORD=${ENV_DB_USER} \
#--build-arg=BUILD_ENV_POSTGRES_DB=${ENV_DB_NAME} \
#-t image_postgres .

ENV ENV_USERNAME=$BUILD_ENV_USERNAME
ENV ENV_USER_UID=$BUILD_ENV_UID
ENV ENV_USER_GID=$BUILD_ENV_GID 
ENV ENV_USER_GROUPNAME=$BUILD_ENV_GROUPNAME

ENV POSTGRES_USER=$BUILD_ENV_POSTGRES_USER
ENV POSTGRES_PASSWORD=$BUILD_ENV_POSTGRES_PASSWORD
ENV POSTGRES_DB=$BUILD_ENV_POSTGRES_DB

# POSTGRES_INITDB_ARGS – Sends arguments to postgres_initdb and adds functionality
# POSTGRES_INITDB_WALDIR – Defines a specific directory for the Postgres transaction log. A transaction is an operation and usually describes a change to your database. 
# POSTGRES_HOST_AUTH_METHOD – Controls the auth-method for host connections to all databases, users, and addresses
# PGDATA – Defines another default location or subdirectory for database files

RUN apt-get update && apt-get -y install vim && apt-get install -y pgagent
RUN apt-get -y install unzip

#RUN echo ${ENV_UID}

# Create the user
RUN echo groupadd --gid ${ENV_USER_GID} ${ENV_USER_GROUPNAME}
RUN groupadd --gid ${ENV_USER_GID} ${ENV_USER_GROUPNAME}
RUN echo useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}
RUN useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}

RUN mkdir /backup

RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /var/lib/postgresql/data

RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /backup

# Copy the initialization script to the Docker image
COPY ./init.sql /docker-entrypoint-initdb.d/

COPY ./x_create_pgagent_data.sql /docker-entrypoint-initdb.d/
COPY ./y_create_pgagent_about.sql /docker-entrypoint-initdb.d/

RUN echo ${ENV_USERNAME}

RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /docker-entrypoint-initdb.d/

USER ${ENV_USER_UID}:${ENV_USER_GID} 

# Expose the PostgreSQL port
EXPOSE 5432


