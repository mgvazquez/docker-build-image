ARG DOCKER_IMAGE_TAG=19.03.12
FROM docker:${DOCKER_IMAGE_TAG}

RUN apk add --no-cache curl tar bash procps git python2 openssh

COPY extras/root/ /root/

ENV DOCKER_CREDENTIAL_HELPER_VERSION=2.0.2 \
    DOCKER_CREDENTIAL_HELPER_DISTRO=linux \
    DOCKER_CREDENTIAL_HELPER_ARCH=amd64

# Docker credential Helpér para Google Private Cloud
# https://github.com/GoogleCloudPlatform/docker-credential-gcr
# Se debe setear la variable GOOGLE_APPLICATION_CREDENTIALS con el path al json de credenciales validas para el proyecto
ADD https://github.com/GoogleCloudPlatform/docker-credential-gcr/releases/download/v${DOCKER_CREDENTIAL_HELPER_VERSION}/docker-credential-gcr_${DOCKER_CREDENTIAL_HELPER_DISTRO}_${DOCKER_CREDENTIAL_HELPER_ARCH}-${DOCKER_CREDENTIAL_HELPER_VERSION}.tar.gz /tmp/docker-credential-gcr.tar.gz
RUN cd /tmp \
 && tar -zxvf /tmp/docker-credential-gcr.tar.gz \
 && chmod a+x docker-credential-gcr \
 && mv docker-credential-gcr /usr/bin/ \
 && rm -rf /tmp/* \
 && cd -

ENTRYPOINT ["/bin/sh"]

################### Don't move ###################
ARG BUILD_DATE
ARG BUILD_VCS_REF
ARG BUILD_VERSION
ARG BUILD_PROJECT_URL
ARG BUILD_COMMITER_NAME
ARG BUILD_COMMITER_MAIL
LABEL ar.com.scabb-island.docker.license=MIT \
      ar.com.scabb-island.docker.maintainer="Manuel Andres Garcia Vazquez <mvazquez@scabb-island.com.ar>" \
      ar.com.scabb-island.docker-credential-gcr.version=${DOCKER_CREDENTIAL_HELPER_VERSION} \
      ar.com.scabb-island.docker.version=${DOCKER_IMAGE_TAG} \
      ar.com.scabb-island.docker.build-date=${BUILD_DATE} \
      ar.com.scabb-island.docker.vcs.url="${BUILD_PROJECT_URL}" \
      ar.com.scabb-island.docker.vcs.ref.sha=${BUILD_VCS_REF} \
      ar.com.scabb-island.docker.vcs.ref.name=${BUILD_VERSION} \
      ar.com.scabb-island.docker.vcs.commiter="${BUILD_COMMITER_NAME} <${BUILD_COMMITER_MAIL}>"
##################################################
