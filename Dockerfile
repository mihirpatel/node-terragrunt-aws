FROM node:12-alpine

ARG TERRAGRUNT
ARG TERRAFORM
RUN echo "Terraform: ${TERRAFORM}, Terragrunt: ${TERRAGRUNT}"

RUN apk add --no-cache \
  ca-certificates openssl openssh \
  groff less bash curl sudo \
  jq git zip tar \
  && apk --no-cache --update add --virtual build-dependencies \
		python3-dev libffi-dev openssl-dev build-base

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

RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM}/terraform_${TERRAFORM}_linux_amd64.zip && \
  unzip terraform.zip -d /usr/local/bin && \
  rm -f terraform.zip

RUN wget -O /usr/local/bin/terragrunt https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT}/terragrunt_linux_amd64 \
  && chmod +x /usr/local/bin/terragrunt

RUN apk add --no-cache autoconf

RUN apk del build-dependencies \
  && rm -rf /var/cache/apk/*

#wget $(curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4) -O /usr/bin/yq
RUN wget https://github.com/mikefarah/yq/releases/download/v4.2.0/yq_linux_amd64 -O /usr/bin/yq \
  && chmod +x /usr/bin/yq

WORKDIR /apps

ENTRYPOINT []
