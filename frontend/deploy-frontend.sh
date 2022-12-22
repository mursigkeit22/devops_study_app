#! /bin/bash
set -xe
sudo usermod -aG docker $USER
sudo setcap cap_net_bind_service=+ep /usr/bin/node
docker network create -d bridge sausage_network || true
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker pull ${CI_REGISTRY_IMAGE}/sausage-frontend:latest
docker stop sausage-frontend || true
docker rm sausage-frontend || true
docker run -d --name sausage-frontend \
    --network=sausage_network \
    --restart always \
    --pull always \
    -p 80:80 \
    ${CI_REGISTRY_IMAGE}/sausage-frontend:latest 
