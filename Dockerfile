FROM node:12

WORKDIR /app

COPY resources/04_database/package.json .

COPY resources/04_database/package-lock.json .

RUN npm i

COPY resources/04_database .

RUN apt-get update && apt-get install -y postgresql

COPY wait-for-postgres.sh .

RUN chmod +x wait-for-postgres.sh

EXPOSE $PORT

CMD npm run start
