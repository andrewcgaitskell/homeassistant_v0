ARG BUILD_ENV_USERNAME
ARG BUILD_ENV_UID
ARG BUILD_ENV_GID 
ARG BUILD_ENV_GROUPNAME

# Stage 1: Build Stage
FROM node:22.6-bookworm AS build

ARG BUILD_ENV_USERNAME
ARG BUILD_ENV_UID
ARG BUILD_ENV_GID 
ARG BUILD_ENV_GROUPNAME

ENV ENV_USERNAME=$BUILD_ENV_USERNAME
ENV ENV_USER_UID=$BUILD_ENV_UID
ENV ENV_USER_GID=$BUILD_ENV_GID 
ENV ENV_USER_GROUPNAME=$BUILD_ENV_GROUPNAME

WORKDIR /usr

## RUN npx create-next-app@latest
RUN npx create-next-app@latest reactjs --use-npm --typescript --eslint --app --src-dir --no-tailwind
RUN ls -Ral /usr/reactjs
# COPY . .

# Stage 2: Runtime Stage
FROM node:22.6-bookworm

ARG BUILD_ENV_USERNAME
ARG BUILD_ENV_UID
ARG BUILD_ENV_GID 
ARG BUILD_ENV_GROUPNAME

ENV ENV_USERNAME=$BUILD_ENV_USERNAME
ENV ENV_USER_UID=$BUILD_ENV_UID
ENV ENV_USER_GID=$BUILD_ENV_GID 
ENV ENV_USER_GROUPNAME=$BUILD_ENV_GROUPNAME

RUN echo groupadd --gid ${ENV_USER_GID} ${ENV_USERNAME}
RUN groupadd --gid ${ENV_USER_GID} ${ENV_USERNAME}
RUN echo useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}
RUN useradd --uid ${ENV_USER_UID} --gid ${ENV_USER_GID} -m ${ENV_USERNAME}

WORKDIR /usr/reactjs/src/app
COPY --from=build /usr/reactjs/src/app/node_modules ./node_modules
COPY --from=build /usr/reactjs/src/app ./
RUN chown -R ${ENV_USER_UID}:${ENV_USER_GID} /usr/reactjs/src/app

USER ${ENV_USER_UID}:${ENV_USER_GID}

EXPOSE 3000
CMD ["npm", "start"]
