FROM node:16.3.0-alpine as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build


FROM node:16.3.0-alpine
WORKDIR /frontend
COPY --from=builder /usr/src/app/dist/frontend/ .
RUN npm install -g http-server
EXPOSE 80
ENTRYPOINT ["http-server", "/frontend/", "-p", "80", "--proxy", "http://sausage-backend:8080"] 
