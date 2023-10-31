# Laboratorio 7.- Kubernetes

## PREPARAR EL ENTORNO


> Intalar minikube


## DESPLEGAR LA APLICACIÓN “LIBRO DE VISITAS”

> Descargar el codigo de la aplicacion.

```bash
kubectl apply -f frontend-deployment.yaml
kubectl apply -f frontend-service.yaml
kubectl apply -f redis-follower-deployment.yaml
kubectl apply -f redis-follower-service.yaml
kubectl apply -f redis-leader-deployment.yaml
kubectl apply -f redis-leader-service.yaml
```

## MODIFICAR LA APLICACIÓN

### Cambiar el numero de replicas de 3 a 5 en el frontend-deployment

```bash
kubectl scale --replicas=5 deployment/frontend
kubectl describe deployment/frontend
```

### Acceder a la BBDD y alterar los mensajes

```bash
kubectl get pod # Obtener el ID del pod de redis-leader

kubectl exec -it $ID redis-cli

KEYS * # Mostrar todas las claves

get guestbook # Mostrara los mensaje

set guestbook "Hola Mundo" # Modificar el mensaje
```

### Cambiar la interfaz Web

> frontend-deployment.yaml

```yml

# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# [START gke_guestbook_frontend_deployment_deployment_frontend]
apiVersion: apps/v1
kind: Deployment
metadata:
  name: frontend
spec:
  replicas: 1
  selector:
    matchLabels:
        app: guestbook
        tier: frontend
  template:
    metadata:
      labels:
        app: guestbook
        tier: frontend
    spec:
      containers:
      - name: php-redis
        image: redislabs/redisinsight:latest
        ports:
        - containerPort: 8001
# [END gke_guestbook_frontend_deployment_deployment_frontend]
---
```


> frontend-service.yaml

```yml
# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# [START gke_guestbook_frontend_service_service_frontend]
apiVersion: v1
kind: Service
metadata:
  name: frontend
  labels:
    app: guestbook
    tier: frontend
spec:
  type: LoadBalancer
  ports:
    # the port that this service should serve on
  - port: 80
    targetPort: 8001
  selector:
    app: guestbook
    tier: frontend
# [END gke_guestbook_frontend_service_service_frontend]
---
```

## ATRIBUCIÓN