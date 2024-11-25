# Adapt Authoring dockerized

This project provides a Docker image for the [Adapt Authoring tool](https://github.com/adaptlearning/adapt_authoring).
It was forked from [garyritchie/docker-adaptauthoring](https://github.com/garyritchie/docker-adaptauthoring) to support newer versions.
        
### Setup & Run

The Docker image is available as [rechnerherz/adapt-authoring/](https://hub.docker.com/r/rechnerherz/adapt-authoring/).

Set it up with the following commands:

```
docker run -d --name adapt-db -v adapt-db:/data/db -v adapt-configdb:/data/configdb mongo
docker run -d --name adapt-authoring -p 5000:5000 --link adapt-db -v adapt-data:/adapt_authoring rechnerherz/adapt-authoring:0.11.4
docker exec -it adapt-authoring node install --dbHost adapt-db
docker restart adapt-authoring
```

The Adapt Authoring tool should now be available at [localhost:5000](http://localhost:5000/).

For a full stack, see the `docker-compose.yml`.

### Run

After the setup, run it with:

`docker-compose up -d`

### Build

```
docker build . -t "adapt-authoring:0.11.4" -t "adapt-authoring:latest"
```

### Push

To push it to Docker Hub:

```
docker tag "adapt-authoring:0.11.4" "rechnerherz/adapt-authoring:0.11.4"
docker tag "adapt-authoring:latest" "rechnerherz/adapt-authoring:latest"
docker push "rechnerherz/adapt-authoring:0.11.4"
docker push "rechnerherz/adapt-authoring:latest"
```
