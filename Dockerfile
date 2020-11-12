FROM node:12-alpine

ARG TERRAGRUNT
ARG TERRAFORM
RUN echo "Terraform: ${TERRAFORM}, Terragrunt: ${TERRAGRUNT}"

RUN apk add --no-cache \
  ca-certificates openssl openssh \
  groff less bash curl sudo \
  jq git zip tar 

RUN apk add --no-cache \
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

WORKDIR /apps

ENTRYPOINT []