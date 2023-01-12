FROM node:16.3.0-alpine as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build


FROM nginxproxy/nginx-proxy
COPY --from=builder /usr/src/app/dist/frontend/ /usr/share/nginx/html
COPY template.nginx /app/nginx.tmpl
