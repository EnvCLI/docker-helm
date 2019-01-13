#!/bin/bash
set -e

# initialize plugins from container
chown -R root:root /root/.helm/cache/plugins
mkdir -p ~/.helm/plugins ~/.helm/cache/plugins || true
cp -r /helm-plguins/* ~/.helm/plugins || true
cp -r /helm-plguins-cache/* ~/.helm/cache/plugins || true

# kubeconfig
if [ -n "$KUBECONFIG_CONTENT" ]; then
    # overwrite kubectl config file (useful for ci/cd)
    mkdir -p /root/.kube
    echo $KUBECONFIG_CONTENT | base64 --decode > /root/.kube/config
fi

exec "$@"
