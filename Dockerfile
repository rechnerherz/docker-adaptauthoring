FROM keymetrics/pm2:8-stretch

LABEL maintainer="dario@rechnerherz.at"

RUN apt-get update && apt-get install -y libssl-dev

RUN npm install -g grunt-cli

WORKDIR /
RUN git clone https://github.com/adaptlearning/adapt_authoring.git

WORKDIR /adapt_authoring
RUN npm install --production
RUN mkdir conf

EXPOSE 5000

CMD pm2 start --no-daemon server.js
