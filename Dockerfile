FROM adrianriobo/k8s-poc@sha256:ba8854818aa0054cde2acd75f05ceec9f2d32b0cf280fec4c07de5b6628dcc73

LABEL maintainer="adrian.riobo.lorenzo@gmail.com"

ENV TEMPORARY_CHARTMUSEUM_IMAGE="temporary-chartmuseum:1.0" \
    GITOPS_HOME=/opt/gitops

ADD gitops_home $GITOPS_HOME 

ADD docker-entrypoint.sh /usr/local/bin

ENTRYPOINT docker-entrypoint.sh
