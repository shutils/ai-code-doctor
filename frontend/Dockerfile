FROM node:20-slim

WORKDIR /opt/app/src

COPY src/package*.json ./
RUN npm ci

COPY src/* ./

ENTRYPOINT ["npm", "run", "dev", "--", "--force"]
