#!/bin/bash

docker network create -d overlay traefik-net

docker stack deploy -c docker-compose.yml pic
