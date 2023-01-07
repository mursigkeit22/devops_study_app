#! /bin/bash

set -xe
cat << EOF > /home/serviceuser/backend-report.env
DB=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_HOST}:${MONGO_PORT}/${MONGO_DATABASE}?tls=true&replicaSet=${MONGO_REPLICA}
PORT=8080
EOF
sudo usermod -aG docker $USER
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker-compose stop backend-report
docker-compose rm -f backend-report
docker-compose pull backend-report
docker-compose up -d backend-report
