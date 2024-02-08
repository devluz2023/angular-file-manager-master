FROM node:14 AS build-step

RUN mkdir -p /app

WORKDIR /app

COPY package.json /app

RUN npm install -g @angular/cli && \
    npm install 

COPY . /app

RUN npm run build 

# stage 2

FROM nginx:1.17.1-alpine

COPY --from=build-step /app/dist/automatizador /usr/share/nginx/html
