# Paso 3: Servicio Node

## Levantar un Servicio Node

Ahora vamos a usar algunos comandos nuevos para crear un `Dockerfile` para buildear una imagen que permita levantar el servicio que se encuentra en `/resources/node_service`.

Comandos nuevos de `Dockerfile`:

`COPY` -- copies files or directories from source and adds them to the filesystem of the container at destination
`WORKDIR` -- set working directory
`EXPOSE` -- expose port
`CMD` -- set executable for container

Por ejemplo, el siguiente podría ser el formato de un `Dockerfile` muy simple:

```
FROM <IMAGEN_BASE>

WORKDIR <WORKDIR_FOLDER>

COPY <SRC> <DST>

RUN <COMANDO>

RUN <OTRO_COMANDO>

EXPOSE <PUERTO>

CMD <COMANDO PARA INICIAR PROGRAMA>
```

### Ejercicio 2

1. Crear un Dockerfile que corra el servicio node y cumpla las siguientes condiciones:

- Imagen Base: `node:12` de https://hub.docker.com/_/node
- Working Directory: `/app`
- Exponga el puerto `8022` donde corre la aplicación.

2. Buildear la imagen con:

```
docker build . -t node-service
```

Y luego verificar que se pudo buildear correctamente con:

```
docker image ls
```

3. Levantar un container que `python3.6` usando la imagen buildeada y lo aprendido en el [Hello World].

#### Notas

- Para instalar las dependencias especificadas en el [`pacakge.json`](/resources/node_service/package.json) se debe correr:

```
npm i
```
