#!/bin/bash

set -xe
cat << EOF > /home/serviceuser/backend.env
REPORT_PATH=/var/reports/
SPRING_DATASOURCE_URL=jdbc:postgresql://${PSQL_HOST}:${PSQL_PORT}/${PSQL_DBNAME}
SPRING_DATASOURCE_USERNAME=${PSQL_USER}
SPRING_DATASOURCE_PASSWORD=${PSQL_PASSWORD}
SPRING_DATA_MONGODB_URI=mongodb://${MONGO_USER}:${MONGO_PASSWORD}@${MONGO_HOST}:${MONGO_PORT}/${MONGO_DATABASE}?tls=true&replicaSet=${MONGO_REPLICA}
EOF
sudo usermod -aG docker $USER
docker network create -d bridge sausage_network || true
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker pull ${CI_REGISTRY_IMAGE}/sausage-backend:latest
docker stop sausage-backend || true
docker rm sausage-backend || true
docker run -d --name sausage-backend \
    --network=sausage_network \
    --restart always \
    --pull always \
    --env-file backend.env \
    ${CI_REGISTRY_IMAGE}/sausage-backend:latest 
