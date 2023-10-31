# Ejercicio 3

## Crear un volumen persistente de tipo “hostPath”

```yml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mi-vp
spec:
  storageClassName: manual
  capacity:
    storage: 10Gi
  hostPath:
    path: ./Ejercicio3/volumen-persistente
  accessModes:
    - ReadWriteOnce
```

## Crear una Reclamación de VP para un volumen de 1 GB

### Nombre: “mi-rvp”

### Modo de acceso: ReadWriteOnce

```yml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mi-rvp
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 2Gi
```

## Crear un Deployment con

### Imagen: ulopeznovoa/hola-k8s

### Número de replicas: 1

### Montar el volumen de ”mi-rvp” en /datos1

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
      volumes:
      - name: mi-vp
        persistentVolumeClaim:
          claimName: mi-rvp
      containers:
      - name: mi-pod
        image: ulopeznovoa/hola-k8s
        ports:
        - containerPort: 80
        volumeMounts:
        - mountPath: /datos1
          name: mi-vp
```

## Acceder al Pod del Deployment en modo interactivo y crear un fichero “mi-texto.txt” con texto aleatorio en /datos1

### Utilizar kubectl exec

```bash
kubectl get pod # Ver id
kubectl exec -it $ID sh
```

## Eliminar el Deployment recién creado

```yml
kubectl delete deployment mi-deployment
```

## Crear un 2º Deployment con

### Imagen: httpd:alpine

### Número de replicas: 1

### Montar el volumen de ”mi-rvp” en /datos2

```yml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mi-deployment2
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
      volumes:
      - name: mi-vp
        persistentVolumeClaim:
          claimName: mi-rvp
      containers:
      - name: mi-pod
        image: httpd:alpine
        ports:
        - containerPort: 80
        volumeMounts:
        - mountPath: /datos1
          name: mi-vp
```

## Acceder al Pod del 2º Deployment en modo interactivo y verificar que el fichero con texto aleatorio es accesible

```bash
kubectl get pod # Ver id
kubectl exec -it $ID sh
```