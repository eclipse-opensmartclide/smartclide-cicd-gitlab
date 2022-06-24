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

# Install gitlab helm chart
helm upgrade --install -f gitlab-values.yaml gitlab gitlab/gitlab --timeout 600s \
    --set certmanager-issuer.email=me@example.com

# Install gitlab-runner helm chart
helm install -f gitlab-runner-values.yaml deployment gitlab/gitlab-runner
