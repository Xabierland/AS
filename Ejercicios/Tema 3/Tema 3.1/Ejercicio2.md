# Ejercicio 2

## Encuentra

### Cuántos usuarios hay creados dentro de la imagen de busybox

```bash
docker run busybox cat /etc/passwd | wc -l
9
```

### Cuántos de esos usuarios tienen /bin/false como Shell de inicio

```bash
docker run busybox cat /etc/passwd | grep "/bin/false" | wc -l
7
```

### Con qué usuario se ejecutan los comandos en busybox

```bash
docker run busybox id
uid=0(root) gid=0(root) groups=0(root),10(wheel)
```

## Crear un contenedor de busybox con el comando de arranque “echo Hola Bilbao” y cronometra en tiempo

```bash
time docker run busybox echo "Hola Bilbao"
Hola Bilbao

real    0m0.544s
user    0m0.026s
sys     0m0.010s
```

## Eliminar todos los contenedores creados

```bash
docker system prune
```
