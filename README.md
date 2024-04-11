# Adapt Authoring dockerized

This project provides a Docker image for the [Adapt Authoring tool](https://github.com/adaptlearning/adapt_authoring).
It was forked from [garyritchie/docker-adaptauthoring](https://github.com/garyritchie/docker-adaptauthoring) to support newer versions.
        
### Setup & Run

The Docker image is available as [darioseidl/adapt-authoring/](https://hub.docker.com/r/darioseidl/adapt-authoring/).

Set it up with the following commands:

```
docker run -d --name adapt-db -v adapt-db:/data/db -v adapt-configdb:/data/configdb mongo
docker run -d --name adapt-authoring -p 5000:5000 --link adapt-db -v adapt-data:/adapt_authoring darioseidl/adapt-authoring:0.11.3
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
version=0.11.3
docker build . -t "adapt-authoring:$version" -t "adapt-authoring:latest"
```

### Push

To push it to Docker Hub:

```
version=0.11.3
docker tag "adapt-authoring:$version" "$DOCKER_ID_USER/adapt-authoring:$version"
docker tag "adapt-authoring:latest" "$DOCKER_ID_USER/adapt-authoring:latest"
docker push "$DOCKER_ID_USER/adapt-authoring:$version"
docker push "$DOCKER_ID_USER/adapt-authoring:latest"
```
