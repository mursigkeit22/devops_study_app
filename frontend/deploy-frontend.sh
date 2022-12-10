#! /bin/bash
set -xe
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
sudo rm -rf /var/www-data/dist/frontend/||true
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store-frontend.tar.gz ${NEXUS_REPO_URL}/sausage-store-Valerie-Shelgunova-frontend/sausage-store/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo tar -xf sausage-store-frontend.tar.gz -C /var/www-data/dist
sudo setcap cap_net_bind_service=+ep /usr/bin/node
sudo systemctl daemon-reload
sudo systemctl restart sausage-store-frontend.service
