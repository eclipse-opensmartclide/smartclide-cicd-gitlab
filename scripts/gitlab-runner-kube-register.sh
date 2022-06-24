#!/bin/bash
#*******************************************************************************
# Copyright (c) 2021 AIR Institute
#
# This program and the accompanying materials
# are made available under the terms of the Eclipse Public License 2.0
# which accompanies this distribution, and is available at
# https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
#
# Contributors:
#     Adrian Diarte Prieto - initial API and implementation
#*******************************************************************************
# This k8s script registers a gitlab runner to the given gitlab host. 

# Load env variables
. ../.env;

#Check if required var are set
if [ -z $KUBERNETES_GITLAB_RUNNER_DEPLOYMENT_NAME ]
then
    printf '%s\n' "var KUBERNETES_GITLAB_RUNNER_DEPLOYMENT_NAME is empty" 1>&2
    exit 1;
fi

#register
kubectl exec -it $KUBERNETES_GITLAB_RUNNER_DEPLOYMENT_NAME -- gitlab-runner register \
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

