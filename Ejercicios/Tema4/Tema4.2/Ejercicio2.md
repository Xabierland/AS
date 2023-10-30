# Ejercicio 2

## Configurar un despliegue que sirva las 2 siguientes páginas web

![Figura 2](./img/figura2.png)

## La estructura del despliegue es la siguiente

### Se deben respetar los nombres y números de puerto escritos en el diagrama

![Figura 3](./img/figura3.png)

## Crear los objetos necesarios

### 3 objetos Deployment

#### Replicas: 1 (en cada Deployment)

#### Ver las imágenes en el diagrama anterior

```yml

```

```yml

```

```yml

```

```bash

```

### 3 objetos ClusterIP

```yml

```

```yml

```

```yml

```

```bash

```

### 1 objeto Ingress

#### Definir reglas de Ingress para redirigir

##### La ruta “/” al Deployment con “ulopeznovoa/k8s-red-cliente”

##### La ruta ”/ayuda” al Deployment con “ulopeznovoa/k8s-red-help”

#### La creación en GKE puede llevar varios minutos

```yml

```

```bash

```

## Verificar con un navegador que el despliegue funciona

```bash

```