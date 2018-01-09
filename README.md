# traefik-demo
Code de test et de démonstration de Traefik

## Launch traefik demo

COMPOSE_PROJECT_NAME=traefik docker stack deploy -c docker-compose.yml traefik

## ATTENTION

La définition du docker-compose pour utilisation "simple" (i.e sans swarm) et pour utilisation avec "stack deploy" est différente !

No stack :
```
whoami1:
  image: emilevauge/whoami
  labels:
    - "traefik.port=80"
  networks:
    - traefik-net  
```

Stack :
```
whoami1:
  image: emilevauge/whoami
    networks:
      - traefik-net
    deploy:
      labels:
        - "traefik.port=80"
        - "traefik.docker.network=traefik-net"
        - "traefik.frontend.rule=Host:whoamistack.traefik.local"
```

cf . https://github.com/containous/traefik/issues/994#issuecomment-269095109



## Rules

* Pour accéder au service via le host "whoami1.traefik"
```
labels:
  - "traefik.frontend.rule=Host:whoami1.traefik"
```

ATTENTION : configurer /etc/hosts pour utiliser un navigateur: 
```
# /etc/hosts
10.1.2.21     whoami1.traefik         whoami2.traefik
```

Sinon par curl : 
```
curl -H whoami1.traefik <SERVER_IP>
```

* Pour accéder au service via le path "http://<SERVER_IP>/whoami1"
```
labels:
  - "traefik.frontend.rule=Path: /whoami1"
```
