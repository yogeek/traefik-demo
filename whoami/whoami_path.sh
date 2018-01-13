#!/bin/bash

docker service create \
    --name whoami1 \
    --label traefik.port=80 \
    --network traefik-net \
    --label "traefik.backend=whoami1" \
    --label "traefik.frontend.rule=PathPrefixStrip: /whoami1" \ 
    emilevauge/whoami

docker service create \
    --name whoami2 \
    --label traefik.port=80 \
    --network traefik-net \
    --label "traefik.backend=whoami2" \
    --label "traefik.frontend.rule=PathPrefixStrip: /whoami2" \
    emilevauge/whoami
