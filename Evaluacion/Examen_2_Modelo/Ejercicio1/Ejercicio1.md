<!-- markdownlint-disable MD024 -->
# Ejercicio 1

## Crear un repositorio privado en vuestra cuenta de GitHub que contenga el codigo de [este repositorio](https://github.com/ulopeznovoa/AS-CI-CD-ej1)

## Crear un Dockerfile para empaquetar el codigo, sus pasos deben ser

* Utilizar como basea la imagen "python:slim"
* Utilizar como directorio de trabajo "/code"
* Copiar los ficheros de codigo Python en la carpeta /code

### Solución

```dockerfile
FROM python:slim
WORKDIR /code
```

## Crear un workflow de Github Actions con las siguientes caracteristicas

* Nombre: examen-workflow
* Se debe disparar al hacer Push en una rama llamada "nueva-caracteristica"
* Se debe ejecutar en un entorno "ubuntu-latest"
* El workflow debe hacer lo siguiente
  * Descargar el codigo
  * Utilizar la accion "actions/setup-python@v4" para configurar un entronor Python de version 3.10
  * Ejecutar los siguientes comendos
    * pip install pytest
    * pytest test.py
  * Utilizar la accion "docker/build-push-action@v5" para construir la imagen usando el Dockerfile. No se necesario subir la imagen a ningun registro.

### Solución

```yaml
name: examen-workflow
on:
  push:
    branches:
      - nueva-caracteristica
jobs:
    build:
        runs-on: ubuntu-latest
        steps:
            - name: Checkout
              uses: actions/checkout@v2
            - name: Setup Python
              uses: actions/setup-python@v4
              with:
                  python-version: 3.10
            - name: Install dependencies
              run: pip install pytest
            - name: Run tests
              run: pytest test.py
            - name: Build Docker image
              uses: docker/build-push-action@v5
              with:
                  context: .
                  file: Dockerfile
                  push: false
```
