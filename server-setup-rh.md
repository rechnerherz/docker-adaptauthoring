
# adapt

```
git clone https://github.com/rechnerherz/docker-adaptauthoring.git

cd docker-adaptauthoring/

docker-compose --project-name=adapt --file docker-compose-rh.yml up -d

docker cp install-without-github-api.js adapt-authoring:/adapt_authoring/install-without-github-api.js
docker exec -it adapt-authoring node install-without-github-api \
--useJSON n \
--install y \
--serverPort 80 \
--serverName localhost \
--dataRoot data \
--authoringToolRepository "https://github.com/adaptlearning/adapt_authoring.git" \
--frameworkRepository "https://github.com/adaptlearning/adapt_framework.git" \
--frameworkRevision v5.8.0 \
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
```

# recreate after config change

```
docker-compose --project-name=adapt --file docker-compose-rh.yml up --build --force-recreate --no-deps -d adapt-authoring
```
