This image is based on node:14-bullseye-slim and has Terraform 0.13.7, Terragrunt 0.34.1, the AWS CLI, and Azure CLI and Yarn installed (see Dockerfile for all other installed utilities).

Combination of following docker images, in order to support lambda build with nodejs runtime, and terraform extension for unsupported resources using aws cli.
* [Python](https://github.com/docker-library/python/blob/8d48af512dc58e9c29c9d4ee59477c195a29cbdc/3.10/bullseye/slim/Dockerfile)
* [Terraform](https://github.com/jch254/docker-node-terraform-aws)
* [Terragrunt](https://github.com/alpine-docker/terragrunt)


```
# Set Arguments
TERRAGRUNT=0.34.1
TERRAFORM=0.13.7
image="mihirpatel/node-terragrunt-aws"
tag="14-bullseye-${TERRAFORM}-${TERRAGRUNT}"

# Build (no cache)
docker build --build-arg TERRAGRUNT=${TERRAGRUNT} --build-arg TERRAFORM=${TERRAFORM} \
  --no-cach*e -t ${image}:${tag} .

# Build (use cache)
docker build --build-arg TERRAGRUNT=${TERRAGRUNT} --build-arg TERRAFORM=${TERRAFORM} \
  -t ${image}:${tag} .

# Push to registry
docker push ${image}:${tag}
```