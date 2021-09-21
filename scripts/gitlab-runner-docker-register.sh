#!/bin/bash
# This script registers a gitlab runner to the given gitlab host. 

# Load env variables
. ../.env;

#get gitlab-runner container id
RUNNER_CONTAINER_ID=$(docker ps | grep "$GITLAB_RUNNER_IMAGE" | awk '{ print $1 }')

#register
docker exec -it $RUNNER_CONTAINER_ID gitlab-runner register \
    --non-interactive \
    --tls-ca-file=/certs/$GITLAB_HOST.crt \
    --registration-token $GITLAB_RUNNER_REGISTRATION_TOKEN \
    --locked=false \
    --description docker-gitlab-runner \
    --url https://$GITLAB_HOST \
    --executor docker \
    --docker-privileged=true \
    --docker-image docker:19.03.12 \
    --docker-network-mode host \
    --tag-list "docker,ci" \
    --docker-volumes "/var/run/docker.sock:/var/run/docker.sock" \
    --docker-volumes "/certs:/certs" \

