FROM node:12-alpine

RUN apk add --no-cache \
#  python \
#  py-pip \
#  py-setuptools \
  ca-certificates \
  openssl \
  groff \
  less \
  bash \
  curl \
  jq \
  git \
  openssh \
  zip
#  pip install --no-cache-dir --upgrade pip awscli && \
#  aws configure set preview.cloudfront true

RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install \
        awscli \
    && rm -rf /var/cache/apk/* \
    && python3 --version

RUN cd /usr/bin \
	&& ln -s pydoc3 pydoc \
	&& ln -s python3 python \
	&& python --version

ENV TERRAFORM_VERSION 0.13.4
RUN wget -O terraform.zip https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && \
  unzip terraform.zip -d /usr/local/bin && \
  rm -f terraform.zip

ENV TERRAGRUNT_VERSION v0.25.2
ADD https://github.com/gruntwork-io/terragrunt/releases/download/${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 /usr/local/bin/terragrunt

RUN chmod +x /usr/local/bin/terragrunt

WORKDIR /apps

ENTRYPOINT []

