
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

# mongo and adapt-authoring

Use defaults during `node install`, set email and password.

```
aptitude install git
git clone https://github.com/rechnerherz/docker-adaptauthoring.git
cd docker-adaptauthoring/
docker run -d --name adapt-db -v adapt-db:/data/db -v adapt-configdb:/data/configdb mongo
docker run -d --name adapt-authoring -p 5000:5000 --link adapt-db -v adapt-data:/adapt_authoring darioseidl/adapt-authoring:0.5.0
docker exec -it adapt-authoring mkdir conf
docker exec -it adapt-authoring node install --dbHost adapt-db
docker restart adapt-authoring
```

# second instance of mongo and adapt-authoring

See [this issue](https://github.com/adaptlearning/adapt_authoring/issues/2407) for command line args.

```
cd docker-adaptauthoring/
docker run -d --name adapt-db2 -v adapt-db2:/data/db -v adapt-configdb2:/data/configdb mongo
docker run -d --name adapt-authoring2 -p 5001:5000 --link adapt-db2 -v adapt-data2:/adapt_authoring darioseidl/adapt-authoring:0.10.5
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
```

# portainer

```
docker volume create portainer_data
docker run -d -p 9000:9000 --name portainer --restart always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```

# ftp

Replace `PASSWORD`.

```
docker run -d -v vsftpd-data:/home/vsftpd -v vsftpd-logs:/var/log/vsftpd \
-p 20:20 -p 21:21 -p 21100-21110:21100-21110 \
-e FTP_USER=aatftp -e FTP_PASS=PASSWORD \
-e PASV_ADDRESS=127.0.0.1 -e PASV_MIN_PORT=21100 -e PASV_MAX_PORT=21110 \
--name vsftpd --restart=always fauria/vsftpd

echo "/var/lib/docker/volumes/adapt-data/_data/ /var/lib/docker/volumes/adapt_vsftpd-data/_data/aatftp/adapt-data none bind 0 0" >> /etc/fstab
echo "/var/lib/docker/volumes/adapt-data2/_data/ /var/lib/docker/volumes/adapt_vsftpd-data/_data/aatftp/adapt-data2 none bind 0 0" >> /etc/fstab

mount -a
```

# adminmongo

Replace `PASSWORD`.

```
docker run -d -p 1234:1234 -e PASSWORD=PASSWORD --name adminmongo --restart=always --link adapt-db mrvautin/adminmongo /bin/sh -c "rm config/app.json; node app.js"
```

Connection string: `mongodb://adapt-db2:27017/adapt-tenant-master`

# utils

```
aptitude install htop molly-guard rsync
```
