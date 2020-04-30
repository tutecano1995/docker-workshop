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

- Agregar la dependencia `pg@^8.0.3` a nuestro `package.json`.
- Agregar el siguiente código a nuestro servicio:

```js
const { Client } = require('pg');

const client = new Client({
  connectionString: process.env.DATABASE_URL,
  query_timeout: 1000,
  statement_timeout: 1000
});

client.connect();
```

Nota: Esto lo podemos encontrar en `/resources/04_database`, donde además agregamos un endpoint que muestra el status de la DB.

### Ejercicio 3

1. Crear una red de containers usando el comando:

```
docker network create -d bridge my-network
```

2. Levantar simultaneamente un container con la db postgres y nuestro servicio Node que se encuentra en `resources/04_database`. Ambos usando el flag:

```
--network network                Connect a container to a network
```

Nota: La URL de la DB debería ser `postgres://<USER>:<PASSWORD>@<HOST>:<PORT>/<DATABASE>`, donde en este caso:

- `USER`: `postgres`
- `PASSWORD`: `postgres`
- `HOST`: `psql-container`
- `PORT`: `5432`
- `DATABASE`: `POSTGRES`

3. Verificar que luego que la conexión fue satisfactoria pegándole al endpoint `/status`.

## Docker Compose

> Para instalar Docker Compose se pueden seguir los pasos descriptos en la siguiente página: https://docs.docker.com/compose/install/

Si bien lo que aprendimos hasta ahora nos permite levantar nuestro servicio junto con su db, existe una forma de hacerlo mucho más simple. Para eso, podemos usar Docker Compose.

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

3. Levantar la db con:

```
docker-compose up -d database
```

Y luego el servicio con:

```
docker-compose up -d app
```

4. Verificar que luego que la conexión fue satisfactoria pegándole al endpoint `/status`.

5. Probar levantar todo con:

```
docker-compose up
```

6. Si no funciono el paso 5, arreglarlo usando el script `wait-for-postgres.sh`.

[< Node Service](03_node_service.md) | [ Deployamos nuestra app a Heroku>](05_heroku.md)