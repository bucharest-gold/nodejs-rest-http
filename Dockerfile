FROM registry.redhat.io/ubi8/nodejs-12:latest

WORKDIR "/app"

COPY package*.json ./

RUN npm install

COPY . /app

ENV PORT 8080

EXPOSE 8080

USER root

CMD ["npm", "start"]
