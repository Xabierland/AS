# Lista de comandos

## Ver si se ha agregado el disco

```bash
lsblk -e7
```

## Crear 6 particiones de 1 GB en el disco

```bash
cfdisk /dev/sdb
```

## Formatear 1 de las particiones como ext4 y otra de las particiones como Btrfs

```bash
sudo mkfs.ext4 /dev/sdb1
sudo mkfs.btrfs /dev/sdb2
```

## Montar la partición ext4 en /discoExt4

```bash
sudo mkdir /discoExt4
sudo mount -t ext4 /dev/sdb1 /discoExt4
```

## Montar la partición Btrfs en /discoBtrfs y configurar su montaje automático con el inicio del sistema

```bash
sudo mkdir /discoBtrfs
sudo mount -t btrfs /dev/sdb2 /discoBtrfs
```

## Utilizar 3 de las 4 particiones sin formatear para crear un volumen lógico LVM. Crear un sistema ext4 en el volumen utilizando el 100% del espacio

```bash
sudo 
```

## Montar el volumen en /miVolumen. Crear un fichero de 50 MB dentro de /miVolumen con datos aleatorios

```bash

```

## Añadir la última partición sin formatear al volumen lógico y extender el sistema de ficheros para que ocupe el total del volumen. Verificar que el fichero de 50 MB sigue estando

```bash

```
