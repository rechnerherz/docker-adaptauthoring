# https://hub.docker.com/r/keymetrics/pm2
FROM keymetrics/pm2:18-buster

LABEL maintainer="dario@rechnerherz.at"

# Install libssl-dev and adapt_authoring
# https://github.com/adaptlearning/adapt_authoring/wiki/Installing-the-Authoring-Tool
RUN set -x\
 && apt-get update\
 && apt-get install --no-install-recommends -y libssl-dev\
 && rm -rf /var/lib/apt/lists/*\
 && git clone https://github.com/adaptlearning/adapt_authoring.git\
 && cd /adapt_authoring\
 && git fetch --all --tags\
 && git checkout tags/v0.11.4 -b release-0.11.4\
 && npm install --production

#EXPOSE 5000

WORKDIR /adapt_authoring

CMD [ "pm2-runtime", "start", "server.js" ]
