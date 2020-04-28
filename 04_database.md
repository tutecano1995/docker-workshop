# Paso 4: Agregamos una Base de Dato

## Levantar una DB Postgres

Con lo aprendido hasta ahora, podríamos levantar la siguiente imagen de Postgres (https://hub.docker.com/_/postgres) haciendo:

```
docker run -d --name psql-container -e POSTGRES_PASSWORD=postgres postgres
```

El flag `-d` permite que el container quede corriendo en background y el `-e` definir una variable de entorno, en este caso necesaria para postgres.

```
  -d, --detach                     Run container in background and print container ID
  --name string                    Assign a name to the container
```

Luego si queremos acceder a la DB, podemos hacer:

```
docker exec -it psql-container psql -U postgres
```

## Conectar nuestro Servicio Node con la DB Postgres

Antes que nada para poder conectarnos desde nuestro servicio Node a la db postgres, deberemos:

- Agregar la dependencia `pg@^8.0.3` a nuestro `package.json` (es recomendado regenerar nuestro `package-lock.json`).
- Agregar el siguiente código a nuestro servicio:

```js
const { Client } = require('pg');

const client = new Client({
  user: 'postgres',
  host: 'psql-container',
  database: 'postgres',
  password: 'postgres'
});

client.connect();
```

### Ejercicio 3

1. Crear una red de containers usando el comando:

```
docker network create -d bridge my-network
```

2. Levantar simultaneamente un container con la db postgres y nuestro servicio Node que se enceuntra en `resources/04_database`. Ambos usando el flag:

```
--network network                Connect a container to a network
```

3. Verificar que luego que la conexión fue satisfactoria pegándole al endpoint `/status`.

## Docker Compose

> Para instalar Docker Compose se pueden seguir los pasos descriptos en la siguiente página: https://docs.docker.com/compose/install/

Si bien lo que aprendimos hasta ahora nos permite levantar nuestro servicio junto con su db, existe una forma de hacerlo de una forma mucho más simple. Para eso, podemos usar Docker Compose.

Docker Compose es una herramienta que permite definir y correr servicios que requiren múltiples containers, en nuestro caso el servicio node junto con la db postgres. Para definir la configuración de nuestros containers, se usa el `docker-compose.yml`, un archivo con sintaxis YAML.

Por ejemplo:

```yaml
version: '3'
services: 
  <SERVICE_1>:
    image: <IMAGE>
    container_name: <CONTAINER_NAME>
    environments:
      - <ENV_VAR>=<ENV_VALUE>
    networks:
      - <NETWORK>

  <SERVICE_2>:
    build: <DOCKERFILE_DIR>
    container_name: <CONTAINER_NAME>
    ports:
      - <HOST_PORT>:<CONTAINER_PORT>
    dependes_on:
      - <SERVICE_1>
    networks:
      - <NETWORK>

networks:
  <NETWORK>:
    driver: <TYPE>
```

### Ejercicio 4

1. Crear un `docker-compose.yml` que permita levantar la base de datos y luego el servicio.

2. Buildear nuestro servicio con:

```
docker-compose build
```

3. Levantar nuestro servicio con:

```
docker-compose up
```

4. Verificar que luego que la conexión fue satisfactoria pegándole al endpoint `/status`.
