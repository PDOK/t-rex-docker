# t-rex-docker

[![GitHub license](https://img.shields.io/github/license/PDOK/t-rex-docker)](https://github.com/PDOK/t-rex-docker/blob/master/LICENSE)
[![GitHub release](https://img.shields.io/github/release/PDOK/t-rex-docker.svg)](https://github.com/PDOK/t-rex-docker/releases)
[![Docker Pulls](https://img.shields.io/docker/pulls/pdok/t-rex.svg)](https://hub.docker.com/r/pdok/t-rex)

## What will it do

This will create a t-rex docker image based on [t-rex vector tile server](https://github.com/t-rex-tileserver/t-rex) that is publicly available through [docker hub](https://hub.docker.com/r/pdok/t-rex).

## Docker

### build

```docker
docker build -t pdok/t-rex .
```

### check version

```docker
docker run pdok/t-rex t_rex --version
```

### run example

```docker
docker run -p 6767:6767 -v `pwd`/example:/srv/data pdok/t-rex t_rex serve --bind 0.0.0.0 --datasource /srv/data/netherlands.gpkg
```

A list of all detected layers is available at <http://localhost:6767/>

## Documentation

The documentation regarding t-rex vector tile server can be found [here](https://t-rex.tileserver.ch/doc/)
