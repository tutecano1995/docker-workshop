# Paso 2: Primer Dockerfile

## Nuestro primer Dockerfile

Lo que vimos hasta ahora nos sirve para poder levantar un container usando una imagen determinada imagen, pero si quisieramos hacer nuestra propia imagen deberíamos hacer un `Dockerfile`.

Algunos comandos de `Dockerfile`:

- `FROM` -- set base image
- `RUN` -- execute command in container

Por ejemplo, el siguiente podría ser el formato de un `Dockerfile` muy simple:

```
FROM <IMAGEN_BASE>

RUN <COMANDO>
```

### Ejercicio 1

1. Crear un Dockerfile que tenga como imagen base `ubuntu` y que instale `Python 3`.

2. Buildear la imagen con:

```
docker build . -t python-image
```

Y luego verificar que se pudo buildear correctamente con:

```
docker image ls
```

3. Levantar un container que corra `python3.6` usando la imagen buildeada y lo aprendido en el [Hello World].

#### Notas

- Cómo instalar Python: https://docs.python-guide.org/starting/install3/linux/

- El comando necesario para instalar Python lo deberán correr con el flag `-y`.

[< Primer Dockerfile](02_first_dockerfile.md) | [Servicio Node >](03_node_service.md)