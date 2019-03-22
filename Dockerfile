############################################################
# Dockerfile
############################################################

# Set the base image
FROM alpine:3.8

############################################################
# Configuration
############################################################
ENV VERSION "2.13.1"
ENV FILENAME=helm-v${VERSION}-linux-amd64.tar.gz

############################################################
# Entrypoint
############################################################
COPY rootfs /

############################################################
# Installation
############################################################

RUN apk add --no-cache ca-certificates bash git curl tar gzip coreutils &&\
    # Install Helm
    curl -L http://storage.googleapis.com/kubernetes-helm/${FILENAME}> ${FILENAME} &&\
    tar zxv -C /tmp -f ${FILENAME} &&\
    rm -f ${FILENAME} &&\
    mv /tmp/linux-amd64/helm /bin/helm &&\
    # Plugins
    helm init --client-only

############################################################
# Execution
############################################################
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD ["helm", "--help"]
