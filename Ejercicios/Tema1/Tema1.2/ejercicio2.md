# EJERCICIO 2

## Utilizar el disco virtual creado en el ejercicio 1

## Borrar las particiones existentes y crear 3 particiones de 2GB

```bash
sudo cfdisk /dev/sdc
```

## Juntar las 3 particiones como un unico volumen LVM llamado volumenEj2

```bash
sudo vgcreate volumenEj2 /dev/sdc1 /dev/sdc2 /dev/sdc3
sudo lvcreate volumenEj2 -l 100%FREE -n miVolumen
```

## Formatear volumenEj2 como ext4 y montarlo en /mivol

```bash
sudo mkfs.ext4 /dev/volumenEj2/miVolumen
mkdir /tmp/mivol
sudo mount -t ext4 /dev/volumenEj2/miVolumen /tmp/mivol/
```

### Verificar el tamaño del volumen resultante

```bash
sudo lvdisplay volumenEj2
```