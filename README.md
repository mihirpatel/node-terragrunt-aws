This image is based on node:12-alpine and has Terraform 0.13.4, Terragrunt 0.25.2, the AWS CLI and Yarn installed (see Dockerfile for all other installed utilities).

Combination of https://github.com/jch254/docker-node-terraform-aws and https://github.com/alpine-docker/terragrunt, in order to support lambda build with nodejs runtime, and terraform extension for unsupported resources using aws cli.
