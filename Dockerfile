FROM node:12-alpine

ARG TERRAGRUNT
ARG TERRAFORM
RUN echo "Terraform: ${TERRAFORM}, Terragrunt: ${TERRAGRUNT}"

RUN apk add --no-cache \
  ca-certificates openssl openssh \
  groff less bash curl sudo \
  jq git zip tar libxml2 libxslt \
  && apk --no-cache --update add --virtual build-dependencies \
		python3-dev libffi-dev openssl-dev build-base libxml2-dev libxslt-dev

RUN apk add --no-cache tzdata \
        python3 \
        py3-pip \
    && pip3 --no-cache-dir install --upgrade pip \
    && pip3 --no-cache-dir install --ignore-installed \
        awscli virtualenv \
    && rm -rf /var/cache/apk/* \
    && python3 --version

RUN cd /usr/bin \
	&& ln -s pydoc3 pydoc \
	&& ln -s python3 python \
	&& python --version && cd

# Added for gifsicle postinstall script, which expects c compiler and make system
RUN apk add --no-cache autoconf automake gcc make g++ zlib-dev

RUN echo "Installing TerraEnv Utility to manage multiple versions of terraform and terragrunt" \
    && pip install --ignore-installed terraenv

RUN echo "Terraform: ${TERRAFORM}, Terragrunt: ${TERRAGRUNT}, using terraenv"
RUN terraenv terraform install ${TERRAFORM} && terraenv terraform install 1.3.3 && terraenv terraform use ${TERRAFORM} && terraform --version
RUN terraenv terragrunt install ${TERRAGRUNT} && terraenv terragrunt install 0.39.2 && terraenv terragrunt use ${TERRAGRUNT} && terragrunt --version

RUN apk del build-dependencies \
  && rm -rf /var/cache/apk/*

#wget $(curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4) -O /usr/bin/yq
RUN wget https://github.com/mikefarah/yq/releases/download/v4.2.0/yq_linux_amd64 -O /usr/bin/yq \
  && chmod +x /usr/bin/yq

WORKDIR /apps

ENTRYPOINT []
