# https://hub.docker.com/r/keymetrics/pm2
FROM keymetrics/pm2:14-stretch

LABEL maintainer="dario@rechnerherz.at"

# Install libssl-dev and grunt-cli, then install adapt_authoring
# https://github.com/adaptlearning/adapt_authoring/wiki/Installing-the-Authoring-Tool
RUN set -x\
 && apt-get update\
 && apt-get install --no-install-recommends -y libssl-dev\
 && rm -rf /var/lib/apt/lists/*\
 && npm install -g grunt-cli\
 && git clone https://github.com/adaptlearning/adapt_authoring.git\
 && cd /adapt_authoring\
 && git fetch --all --tags\
 && git checkout tags/v0.11.3 -b release-0.11.3\
 && npm install --production\
 && mkdir conf

#EXPOSE 5000

WORKDIR /adapt_authoring

CMD [ "pm2-runtime", "start", "server.js" ]
