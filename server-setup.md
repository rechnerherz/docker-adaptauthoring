
# Setup for full stack with adapt-authoring, adminmongo, vsftpd, nginx, certbot, and portainer

## install docker

```
apt-get update
apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository    "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install docker-ce
```

## install docker-compose

```
curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
```

## install git

```
apt install git
```

## create ssl cert

```
git clone https://github.com/wmnnd/nginx-certbot.git
```

- Change example.org domain in data/nginx/app.conf
- Set email and change domain in init-letsencrypt.sh

```
./init-letsencrypt.sh
```

- Stop and remove containers

## install adapt-authoring, adminmongo, vsftpd, nginx, certbot, and portainer  

```
git clone https://github.com/rechnerherz/docker-adaptauthoring.git

cd docker-adaptauthoring/
git checkout v0.11.3

# or create a .env file:
export COMPOSE_PROJECT_NAME=adapt
export ADAPT_FTP_PASSWORD="REPLACE_ME"
export ADAPT_ADMINMONGO_PASSWORD="REPLACE_ME"

docker-compose up -d

docker cp install-without-github-api.js adapt-authoring:/adapt_authoring/install-without-github-api.js
docker exec -it adapt-authoring node install-without-github-api \
--useJSON n \
--install y \
--serverPort 5000 \
--serverName localhost \
--dataRoot data \
--authoringToolRepository "https://github.com/adaptlearning/adapt_authoring.git" \
--frameworkRepository "https://github.com/adaptlearning/adapt_framework.git" \
--frameworkRevision v5.37.7 \
--dbName adapt-tenant-master \
--useConnectionUri n \
--dbConnectionUri n \
--dbHost adapt-db \
--dbPort 27017 \
--dbUser n \
--dbPass n \
--dbAuthSource n \
--useSmtp n \
--useSmtpConnectionUrl n \
--fromAddress n \
--rootUrl n \
--smtpService none \
--smtpUsername n \
--smtpPassword n \
--smtpConnectionUrl n \
--masterTenantName master \
--masterTenantDisplayName Master \
--suEmail admin
docker restart adapt-authoring

echo "/var/lib/docker/volumes/adapt-data/_data/ /var/lib/docker/volumes/vsftpd-data/_data/aatftp/adapt-data none bind 0 0" >> /etc/fstab
mount -a
```

## recreate nginx after config change

```
docker-compose up --build --force-recreate --no-deps -d nginx
```
