FROM node:12

WORKDIR /app

COPY resources/node_service .

RUN npm i

EXPOSE 8022

CMD npm run start
