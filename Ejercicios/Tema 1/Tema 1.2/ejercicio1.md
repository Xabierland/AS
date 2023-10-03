# EJERCICIO 1

## Añadir un disco duro pd-balanced de 12GB a la maquina virtual

## Crear 2 particiones de 6GB

```bash
sudo cfdisk /dev/sdc
```

## Formatear una como ext4 y la otra como btrfs

```bash
sudo mkfs.ext4 /dev/sdc1
sudo mkfs.btrfs /dev/sdc2
```

## Montar la particion btrfs en /miBtrfs

```bash
mkdir /tmp/miBtrfs
sudo mount -t btrfs /dev/sdc2 /tmp/miBtrfs/
```

## Copiar el contenido de /var/log/apt

```bash
sudo cp /var/log/apt/* /tmp/miBtrfs/
```

### Verificar que el contenido se ha copiado correctamente

```bash
ls /tmp/miBtrfs/
```

## Desmontar la particion btrfs

```bash
sudo umount /dev/sdc2
```
