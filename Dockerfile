############################################################
# Dockerfile
############################################################

# Set the base image
FROM alpine:latest

############################################################
# Configuration
############################################################
ENV VERSION "3.0.0"
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
    curl -L https://get.helm.sh/${FILENAME}> ${FILENAME} &&\
    tar zxv -C /tmp -f ${FILENAME} &&\
    rm -f ${FILENAME} &&\
    mv /tmp/linux-amd64/helm /bin/helm &&\
	cp /bin/helm /bin/helm3 &&\
	chmod +x /bin/helm /bin/helm3

############################################################
# Execution
############################################################
ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD ["helm", "--help"]
