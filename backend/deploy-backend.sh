#! /bin/bash
set -xe
sudo cat << EOF > /etc/default/sausagestore
PSQL_USER=${PSQL_USER}
PSQL_PASSWORD=${PSQL_PASSWORD}
PSQL_HOST=${PSQL_HOST}
PSQL_PORT=${PSQL_PORT}
PSQL_DBNAME=${PSQL_DBNAME}
EOF
sudo cp -rf sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service
sudo rm -f /home/jarservice/sausage-store-backend.jar||true
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store-backend.jar ${NEXUS_REPO_URL}/sausage-store-Valerie-Shelgunova-backend/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar
sudo cp ./sausage-store-backend.jar /home/jarservice/sausage-store-backend.jar||true 
sudo systemctl daemon-reload
sudo systemctl restart sausage-store-backend.service
