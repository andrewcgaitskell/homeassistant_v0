FROM node:latest

ARG BUILD_ENV_USERNAME
ARG BUILD_ENV_UID
ARG BUILD_ENV_GID 
ARG BUILD_ENV_GROUPNAME

ENV ENV_USERNAME=$BUILD_ENV_USERNAME
ENV ENV_USER_UID=$BUILD_ENV_UID
ENV ENV_USER_GID=$BUILD_ENV_GID 
ENV ENV_USER_GROUPNAME=$BUILD_ENV_GROUPNAME

# Set working directory
WORKDIR /app
RUN mkdir /app/public
RUN mkdir /app/src
RUN mkdir -p /app/node_modules

RUN echo groupadd --gid ${ENV_USER_GID} ${ENV_USERNAME}
RUN groupadd --gid ${ENV_USER_GID} ${ENV_USERNAME}
RUN echo useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}
RUN useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}

RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /app

COPY package.json /app/node_modules/package.json
COPY ./src/ /app/src
COPY ./public/ /app/public

RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /app/node_modules/package.json
RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /app/src
RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /app/public
RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /app/node_modules

USER ${ENV_USER_UID}:${ENV_USER_GID}

RUN npm install --prefix /app /app/node_modules

RUN npm update --prefix /app /app/node_modules

#ENV CI=true
ENV PORT=4000

## CMD [ "npm", "start" ]
CMD ["npm", "--prefix",  "/app", "start"]

