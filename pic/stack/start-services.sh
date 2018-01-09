#!/bin/bash

docker network create -d overlay traefik-net

docker service create                                                                   \
        --name traefik                                                                  \
        --constraint=node.role==manager                                                 \
        --publish 80:80                                                                 \
        --publish 8080:8080                                                             \
        --mount type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock       \
        --network traefik-net                                                           \
        traefik                                                                         \
        --docker                                                                        \
        --docker.swarmmode                                                              \
        --docker.domain=192.168.0.14                                                       \
        --docker.watch                                                                  \
        --web                                                                           \
        --logLevel=DEBUG



docker service create 									\
	--name=jenkins 									\
	--mount type=volume,source=jenkins-data,destination=/var/jenkins_home 		\
	--mount type=bind,source=/var/run/docker.sock,destination=/var/run/docker.sock 	\
	--label 'traefik.port=8080' 							\
	--label traefik.frontend.rule="PathPrefixStrip: /jenkins" 			\
	--network traefik-net 								\
        --env JENKINS_OPTS="--prefix=/jenkins"                                          \
	jenkins/jenkins:lts

        # --env JENKINS_OPTS="--prefix=/jenkins"                                          \
        #--label traefik.enable=true                                                    \
        #--label traefik.docker.network=traefik-net                                     \


# docker service create									\
# 	--name=nexus									\
# 	--env NEXUS_CONTEXT_PATH="/nexus"						\
# 	--mount type=volume,source=nexus-data,destination=/nexus-data			\
# 	--label traefik.enable=true                                                     \
#         --label traefik.docker.network=traefik-net                                      \
#         --label traefik.enable=true                                                     \
#         --label traefik.port=8081                                                       \
#         --label traefik.frontend.rule="PathPrefixStrip: /nexus"                       	\
#         --network traefik-net                                                           \
# 	sonatype/nexus3
