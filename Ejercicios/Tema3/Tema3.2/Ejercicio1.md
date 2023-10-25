# Ejercicio 1

## Crear un volumen Docker llamado “datos-ej-1”

```bash
docker volume create datos-ej-1
```

## Lanzar un contenedor de “alpine” con el comando “sh”. Montar el volumen “datos-ej-1” en /datos dentro del contenedor

```bash
docker run -v datos-ej-1:/datos -it alpine sh
```

## Desde la Shell del contenedor “alpine”. Crear 2 ficheros con texto aleatorio en /datos. Cerrar sesión y asegurarse de que el contenedor se ha parado

```bash
echo "hola" > /datos/fichero1.txt
echo "adios" > /datos/fichero2.txt
```

## Lanzar un contenedor de “busybox” con el comando “sh”. Montar el volumen “datos-ej-1” en /datos dentro del contenedor

```bash
docker run -v datos-ej-1:/datos -it busybox sh
```

## Desde la Shell del contenedor “busybox”. Verificar que los 2 ficheros con texto están dentro de /datos

```bash
cat /datos/fichero1.txt
cat /datos/fichero2.txt
```

## Desde la Shell del anfitrión. Encontrar el directorio donde se almacenan los 2 ficheros

```bash
docker inspect datos-ej-1

/var/lib/docker/volumes/datos-ej-1/_data
```