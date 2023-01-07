#! /bin/bash
set -xe
sudo usermod -aG docker $USER
sudo setcap cap_net_bind_service=+ep /usr/bin/node
sudo usermod -aG docker $USER
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker-compose stop frontend
docker-compose rm -f frontend
docker-compose pull frontend
docker-compose up -d frontend

