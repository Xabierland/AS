# Ejercicio 3

## Crear y ejecutar la siguiente imagen Docker

### Dockerfile

```Dockerfile
FROM ubuntu
RUN apt -qq update && apt -qq -y install stress-ng
CMD stress-ng -c 1 -t 5s
```

### Bash

```bash
docker build -t="xabier/benchmark5s" .
docker run xabier/benchmark5s
```

## Modificar la imagen para que stress-ng se ejecute durante 90 segundos

```Dockerfile
FROM ubuntu
RUN apt -qq update && apt -qq -y install stress-ng
CMD stress-ng -c 1 -t 90s
```

### Bash

```bash
docker build -t="xabier/benchmark90s"
docker run xabier/benchmark90s
```
