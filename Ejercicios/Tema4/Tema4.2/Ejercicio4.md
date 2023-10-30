# Ejercicio 4

## Parte 1

### Obtener la imagen del servidor web Apache (“httpd”) y renombrarla como <vuestro-Docker-ID>/mi-apache

```bash
docker push httpd
docker tag httpd:latest xabierland/mi-apache
```

### Crear un repositorio “mi-apache” en Docker Hub y subir la imagen

```bash
docker push xabierland/mi-apache
```

### Crear un despliegue con

#### Un Deployment que sirva la imagen

```yml

```

#### Un LoadBalancer que permita acceder al Pod desde un navegador

```yml

```

## Parte 2

### Convertir el repositorio DockerHub de la imagen en privado

### Eliminar el Deployment en uso

### Configurar un secreto para que Kubernetes pueda recuperar la imagen

### Activar el Deployment de nuevo
