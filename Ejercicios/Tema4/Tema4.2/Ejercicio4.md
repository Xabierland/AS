# Ejercicio 4

## Parte 1

### Obtener la imagen del servidor web Apache (“httpd”) y renombrarla como <vuestro-Docker-ID>/mi-apache

```bash
docker pull httpd
docker tag httpd:latest xabierland/mi-apache
```

### Crear un repositorio “mi-apache” en Docker Hub y subir la imagen

```bash
docker push xabierland/mi-apache
```

### Crear un despliegue con

#### Un Deployment que sirva la imagen

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mi-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      modulo: servidor-web
  template:
    metadata:
      labels:
        modulo: servidor-web
    spec: 
      containers:
      - name: mi-pod
        image: xabierland/mi-apache
        ports:
        - containerPort: 80
```

#### Un LoadBalancer que permita acceder al Pod desde un navegador

```yml
apiVersion: v1
kind: Service
metadata:
  name: mi-servicio
  labels:
    modulo: servidor-web
spec:
  type: LoadBalancer
  ports:
    - port: 80
      targetPort: 80
  selector:
    modulo: servidor-web
```

## Parte 2

### Convertir el repositorio DockerHub de la imagen en privado

### Eliminar el Deployment en uso

```bash
kubectl delete deployment mi-deployment
```

### Configurar un secreto para que Kubernetes pueda recuperar la imagen

```bash
kubectl create secret docker-registry mi-secreto --docker-server=https://index.docker.io/v1/ --docker-username=xabierland --docker-password= --docker-email=xabierland@gmail.com
```

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mi-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      modulo: servidor-web
  template:
    metadata:
      labels:
        modulo: servidor-web
    spec: 
      containers:
      - name: mi-pod
        image: xabierland/mi-apache
        ports:
        - containerPort: 80
      imagePullSecrets:
      - name: mi-secreto
```

### Activar el Deployment de nuevo

```bash
kubectl apply -f deployment.yml
```