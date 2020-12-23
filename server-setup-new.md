
# docker

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

# adapt

```
aptitude install git
git clone https://github.com/rechnerherz/docker-adaptauthoring.git

cd docker-adaptauthoring/

export ADAPT_FTP_PASSWORD="REPLACE_ME"
export ADAPT_ADMINMONGO_PASSWORD="REPLACE_ME"
export ADAPT_NGINX_SERVER_NAME="learn.macschneider.at"

mkdir /var/www

docker-compose --project-name=adapt up -d

docker cp install-without-github-api.js adapt-authoring2:/adapt_authoring/install-without-github-api.js
docker exec -it adapt-authoring2 node install-without-github-api \
--useJSON n \
--install y \
--serverPort 5000 \
--serverName localhost \
--dataRoot data \
--authoringToolRepository "https://github.com/adaptlearning/adapt_authoring.git" \
--frameworkRepository "https://github.com/adaptlearning/adapt_framework.git" \
--frameworkRevision v5.8.0 \
--dbName adapt-tenant-master \
--useConnectionUri n \
--dbConnectionUri n \
--dbHost adapt-db2 \
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
docker restart adapt-authoring2

echo "/var/lib/docker/volumes/adapt-data/_data/ /var/lib/docker/volumes/vsftpd-data/_data/aatftp/adapt-data none bind 0 0" >> /etc/fstab
mount -a
```

# utils

```
aptitude install htop molly-guard rsync
```