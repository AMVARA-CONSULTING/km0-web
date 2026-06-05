# syntax=docker/dockerfile:1

FROM node:22-alpine AS build
WORKDIR /app
ARG CLOUD_ADMIN_USER
ARG CLOUD_APP_TOKEN
ENV CLOUD_ADMIN_USER=$CLOUD_ADMIN_USER
ENV CLOUD_APP_TOKEN=$CLOUD_APP_TOKEN
COPY package.json package-lock.json .npmrc ./
RUN npm ci
COPY . .
RUN npm run build

FROM nginx:alpine AS runtime
COPY nginx/container.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1/ || exit 1
