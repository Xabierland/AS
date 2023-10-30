# Ejercicio 3

## Crear una Reclamación de VP para un volumen de 1 GB

### Nombre: “mi-rvp”

### Modo de acceso: ReadWriteOnce

## Crear un Deployment con

### Imagen: ulopeznovoa/hola-k8s

### Número de replicas: 1

### Montar el volumen de ”mi-rvp” en /datos1

## Acceder al Pod del Deployment en modo interactivo y crear un fichero “mi-texto.txt” con texto aleatorio en /datos1

### Utilizar kubectl exec

## Eliminar el Deployment recién creado

## Crear un 2º Deployment con

### Imagen: httpd:alpine

### Número de replicas: 1

### Montar el volumen de ”mi-rvp” en /datos2

## Acceder al Pod del 2º Deployment en modo interactivo y verificar que el fichero con texto aleatorio es accesible