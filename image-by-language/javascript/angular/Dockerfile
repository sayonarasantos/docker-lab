# STAGE 1: Build app

FROM node:14-alpine AS builder

RUN mkdir /project
WORKDIR /project

COPY . .

RUN npm ci \
    && ng build --configuration=production --aot


# STAGE 2: Deploy app

FROM nginx:alpine

RUN rm -rf /usr/share/nginx/html/*

COPY nginx/default.conf /etc/nginx/conf.d/

COPY nginx/nginx.conf /etc/nginx/

COPY --from=builder /project/dist/app/ /usr/share/nginx/html/

