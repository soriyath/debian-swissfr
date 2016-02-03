# debian-swissfr

> debian:jessie with swiss french localization

## Run debian-swissfr
```
docker pull soriyath/debian-swissfr
docker run -it debian-swissfr /bin/bash
```

## Use it as a base image in a Dockerfile
```
FROM soriyath:debian-swissfr
MAINTAINER Miles Bennett Dyson (google it !)

RUN apt-get update \
	&& apt-get install -y <your_dependencies

VOLUME <your_shared_volume
CMD[<your_startup_commands>]
```