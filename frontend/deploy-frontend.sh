set -xe
sudo cp -rf sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store-frontend.tar.gz ${NEXUS_REPO_URL}/sausage-store-Valerie-Shelgunova-frontend/sausage-store/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo tar -xf sausage-store-frontend.tar.gz
