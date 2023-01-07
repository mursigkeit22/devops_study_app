#! /bin/bash

set -xe
cat << EOF > /home/serviceuser/backend.env
REPORT_PATH=/var/reports/
SPRING_DATASOURCE_URL=jdbc:postgresql://${PSQL_HOST}:${PSQL_PORT}/${PSQL_DBNAME}
SPRING_DATASOURCE_USERNAME=${PSQL_USER}
SPRING_DATASOURCE_PASSWORD=${PSQL_PASSWORD}
EOF
sudo usermod -aG docker $USER
docker login -u ${CI_REGISTRY_USER} -p ${CI_REGISTRY_PASSWORD} ${CI_REGISTRY}
docker-compose stop backend
docker-compose rm -f backend
docker-compose pull backend
docker-compose up -d backend

