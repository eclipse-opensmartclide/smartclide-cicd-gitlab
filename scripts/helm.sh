#!/bin/bash
# This script installs gitlab in k8s by using gitlab helm charts.
# https://docs.gitlab.com/charts/
#
# !Note: info taken from https://docs.gitlab.com/charts/quickstart/
#
# <<No folks, you can not use example.com.
#   You’ll need to have access to a internet accessible domain to which you can add a DNS record. 
#   This can be a sub-domain such as poc.domain.com, 
#   but the Let’s Encrypt servers have to be able to resolve the addresses to be able to issue certificates.>>
#
# For global configs in values.yaml
# https://docs.gitlab.com/charts/charts/globals.html
#

helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install -f values.yaml gitlab gitlab/gitlab --timeout 600s \
    --set certmanager-issuer.email=me@example.com
