# Ejercicio 3

## Modificar el ejercicio 2 para utilizar un objeto Deployment en lugar de un Pod

### Verificar que la aplicación funciona después del cambio

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
          image: ulopeznovoa/simple-web-80
          ports:
          - containerPort: 80
```

## Modicar el Deployment para que sirva la imagen “httpd:alpine” en lugar de “simple-web-80”

### Verificar que la aplicación funciona después del nuevo cambio

### Se debería mostrar el mensaje “It Works!” en el navegador

### Si se muestra la web anterior, probar a vaciar la caché del navegador

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
          image: httpd:alpine
          ports:
          - containerPort: 80
```
