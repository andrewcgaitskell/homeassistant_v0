FROM node:22.6-bookworm
RUN apt-get update
//RUN apt-get -y install curl gnupg
//RUN curl -sL https://deb.nodesource.com/setup_20.x  | bash -
//RUN apt-get -y install nodejs

RUN mkdir -p /home/node/app/node_modules && chown -R node:node /home/node/app

# Add a work directory
WORKDIR /home/node/app

# Cache and Install dependencies
COPY package.json ./
#COPY yarn.lock .
#COPY package-lock.json .

USER node

RUN npm install --package-lock-only url-parse

#RUN yarn install
RUN npm i
RUN npm install mqtt --save

# Copy app files
COPY --chown=node:node . .

# Expose port
EXPOSE 4002

ENV PORT=4002
ENV HOST=0.0.0.0
ENV CI=true

# Start the app
CMD [ "npm", "start" ]
