# Ejercicio 1

## Crear servidor

```bash
sudo mkdir -p /compartir

sudo touch texto.txt

sudo nano texto.txt

sudo chmod 666 texto.txt

sudo nano /etc/export
    +/compartir *(ro)

sudo exportfs -v

sudo exportfs -ra

sudo service nfs-kernel-server restart
```

## Conectarse al servidor

```bash
mkdir -p /tmp/compartir
sudo mount -t nfs $IP:/compartir /tmp/compartir
```
