# Ejercicio 2

## Crear 1 imagen Docker

### Imagen base: Ubuntu

### Dependencia: python3

### Copiar fichero desde anfitrion: index.html

### Comando de arranque: python3 -m http.server 1080

```Dockerfile
FROM ubuntu
RUN apt -qq update && apt -qq -y install -y python3
COPY index.html /index.html
CMD python3 -m http.server 1080
```

## Crear un entorno Docker Compose con

### La imagen recien definida, nombre "servidor-web

#### Mapear puerto 1080 del contenedor a 80 del anfitrion

### La imagen "redis", nombre "servidor-bbdd"

```yaml
version: "3"
services:
  servidor-web:
    build: .
    ports:
      - "80:1080"
  servidor-bbdd:
    image: redis
```

## Verificar que ambos contenedores se ejecutan correctamente

### Acceder al contenedor "redis" y abrir "redis-cli"

```bash
docker ps
docker exec -it 612cd2758776 bash
redis-cli
```

### Abrir la URL en un navegador

```bash
firefox http://34.147.172.10/
```
