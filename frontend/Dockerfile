FROM node:16.3.0-alpine as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build


FROM node:16.3.0-alpine
WORKDIR /dist/frontend
RUN npm install -g http-server \
    && addgroup --system front-user \
    && adduser -S -s /bin/false -G front-user front-user -D -H
COPY --chown=front-user:front-user \
     --from=builder /usr/src/app/dist/frontend/ .
EXPOSE 80
USER front-user
ENTRYPOINT ["http-server", "/dist/frontend/", "-p", "80", "--proxy", "http://sausage-backend:8080"] 
