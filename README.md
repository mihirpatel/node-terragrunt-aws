This image is based on node:12-alpine and has Terraform 0.13.4, Terragrunt 0.25.2, the AWS CLI, and Azure CLI and Yarn installed (see Dockerfile for all other installed utilities).

Combination of https://github.com/jch254/docker-node-terraform-aws and https://github.com/alpine-docker/terragrunt, in order to support lambda build with nodejs runtime, and terraform extension for unsupported resources using aws cli.

```
# Set Arguments
TERRAGRUNT=0.25.2
TERRAFORM=0.13.4
image="mihirpatel/node-terragrunt-aws-gifsicle"
tag="12-alpine-${TERRAFORM}-${TERRAGRUNT}"

# Build (no cache)
docker build --build-arg TERRAGRUNT=${TERRAGRUNT} --build-arg TERRAFORM=${TERRAFORM} \
  --no-cache -t ${image}:${tag} .

# Build (use cache)
docker build --build-arg TERRAGRUNT=${TERRAGRUNT} --build-arg TERRAFORM=${TERRAFORM} \
  -t ${image}:${tag} .

# Push to registry
docker push ${image}:${tag}
```


