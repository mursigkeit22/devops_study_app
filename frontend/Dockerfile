FROM node:16 as builder
WORKDIR /usr/src/app
COPY . .
RUN npm install
RUN npm run build


FROM nginx:latest
COPY --from=builder /usr/src/app/dist/frontend/ /usr/share/nginx/html

EXPOSE 8080 
