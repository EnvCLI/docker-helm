#!/bin/bash
set -e

# kubeconfig
if [ -n "$KUBECONFIG_CONTENT" ]; then
    # overwrite kubectl config file (useful for ci/cd)
    mkdir -p /root/.kube
    echo $KUBECONFIG_CONTENT | base64 --decode > /root/.kube/config
fi

exec "$@"
