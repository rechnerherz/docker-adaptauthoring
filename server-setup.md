
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
git checkout v0.11.5

# Create GitHub token with read:project https://github.com/settings/tokens
# Set token and passwords in the .env file, then
set -o allexport; source .env; set +o allexport

docker-compose up -d

docker exec -it adapt-authoring node install \
--useJSON n \
--install y \
--serverPort 5000 \
--serverName localhost \
--dataRoot data \
--authoringToolRepository "https://github.com/adaptlearning/adapt_authoring.git" \
--frameworkRepository "https://github.com/adaptlearning/adapt_framework.git" \
--frameworkRevision v5.53.5 \
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
--suEmail admin \
--suPassword "$SUPER_PASSWORD"
docker restart adapt-authoring

mkdir /var/lib/docker/volumes/adapt_vsftpd_data/_data/aatftp/adapt-data
echo "/var/lib/docker/volumes/adapt_data/_data/ /var/lib/docker/volumes/adapt_vsftpd_data/_data/aatftp/adapt-data none bind 0 0" >> /etc/fstab
mount -a

# allow group staff access for ftp
# owner must still be root
chown -R root:staff /var/lib/docker/volumes/adapt_vsftpd_data/_data/aatftp/adapt-data
chmod -R g+w /var/lib/docker/volumes/adapt_data/_data/
```

## recreate nginx after config change

```
docker-compose up --build --force-recreate --no-deps -d nginx
```
