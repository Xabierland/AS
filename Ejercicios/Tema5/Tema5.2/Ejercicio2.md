# Realizar este ejercicio en parejas, sereis A y B

## A crea un aplicacion Kubernetes con:

- Un deployment que gestione Pods con la imagen "nginx"
- Un LoadBalancer que expone el puerto 80 del Pod al exterior
- Un VerticalPodAutoscaler aplicado al Deployment en modo Auto

## B crea un script que realiza peticiones a la web de Nginx cada 0.05 segundos

## B ejecuta el script y A monitoriza las recomendaciones del VPA

```bash
kubectl apply -f 
```