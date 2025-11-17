# https://hub.docker.com/_/node/tags
FROM node:18-bullseye

LABEL maintainer="dario@rechnerherz.at"

# Install libssl-dev, adapt_authoring, and pm2
# https://github.com/adaptlearning/adapt_authoring/wiki/Installing-the-Authoring-Tool
RUN set -x\
 && apt-get update\
 && apt-get install --no-install-recommends -y libssl-dev\
 && rm -rf /var/lib/apt/lists/*\
 && git clone https://github.com/adaptlearning/adapt_authoring.git\
 && cd /adapt_authoring\
 && git fetch --all --tags\
 && git checkout tags/v0.11.5 -b release-0.11.5\
 && npm install --production\
 && npm install --global pm2\
 && npm cache clean --force

#EXPOSE 5000

WORKDIR /adapt_authoring

CMD [ "pm2-runtime", "start", "server.js" ]
