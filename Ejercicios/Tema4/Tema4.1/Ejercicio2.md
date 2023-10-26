# Ejercicio 2

## Configurar el cluster Kubernetes con:

### Un Pod que:

#### Ejecute la imagen "ulopeznovoa/simple-web-80"

##### Contiene un servidor Web que muestra un HTML estatico

##### Escucha peticiones en el puerto 80

```yml
apiVersion: v1
kind: Pod
metadata:
  name: mi-pod
  labels:
    component: web
spec:
    containers:
    - name: mi-contenedor
        image: ulopeznovoa/simple-web-80
        ports:
        - containerPort: 80
```

#### Un LoadBalancer que exponga el puerto 80 del Pod al exterior

```yml
apiVersion: v1
kind: Service
metadata:
  name: mi-servicio
  labels:
    component: web
spec:
    type: LoadBalancer
    ports:
    - port: 80
        targetPort: 80
    selector:
        component: web
```

## Verificar que el en contenedor esta en ejecucion y es accesible

### Abir en un navegador

## Eliminar los objetos Pod y LoadBalancer recien creados