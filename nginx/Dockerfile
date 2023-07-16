FROM node:20-buster-slim as builder

WORKDIR /opt/app

COPY frontend/ ./
RUN npm ci
RUN npm run build

FROM nginx:1.25.1

COPY nginx/conf/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /opt/app/dist/index.html /usr/share/nginx/html/index.html
COPY --from=builder /opt/app/dist/assets /usr/share/nginx/html/assets
