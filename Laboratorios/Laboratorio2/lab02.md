# LABORATORIO 2

## 1 Configuracion del entorno

## 2 Gestion basica

### 1 En el disco recién creado, crear 4 particiones de 1GB cada una y formatearlas: una de ellas será ext3, otra btrfs, otra xfs y última ext4

```bash
sudo cfdisk /dev/sdb
sudo mkfs.ext3 /dev/sdb1
sudo mkfs.btrfs /dev/sdb2
sudo mkfs.xfs /dev/sdb3
sudo mkfs.ext4 /dev/sdb4
```

### 2 Configurar un montaje automático de las particiones (al arranque de la máquina virtual) en /disco[X] donde X es 1, 2, 3, 4. Se recomienda seguir estos1 pasos. Verificar que los montajes se mantienen al reiniciar la máquina. En caso de que la MV no arranque o no permita acceso vía SSH por problemas de configuración, se puede iniciar una terminal mínima llamada “consola serie” que provee acceso root para resolver incidencias2.

```bash
mkdir /tmp/disco1
mkdir /tmp/disco2
mkdir /tmp/disco3
mkdir /tmp/disco4
sudo nano /etc/fstab
```

### 3 ¿Cual de los sistemas de ficheros creados ocupa mas espacio?

```bash
df -h
```

### 4 ¿Es psobile acceder a una particion ext3 que ha sido montada como ext4? ¿Y al reves? ¿Por que?

```bash
Se puede montar un ext3 como ext4 pero no un ext4 como un ext3
```

### 5 Desmontar y borrar las 3 ultimas particiones. Crea una unica particion ext4 de 3GB

```bash
sudo umount /dev/sdb[2,3,4]
sudo cfdisk /dev/sdb
```

### 6 Copiar el contenido del directorio /var en la nueva particion ext4 que acabas de crear. Despues redimensionar la particion para que sea lo mas pequeña posible

```bash
sudo cp -r /var/* /tmp/disco1
```

### 7 Eliminar la configuracion de montaje automatico realizada en el 2º paso

```bash
sudo nano /etc/fstab
```

## 3 Comparativa de rendimiento

### 1 Borrar las particiones creadas en el disco en la sección anterior. En este ejercicio nos referiremos a este disco como balanceado

```bash
sudo umount /dev/sdb1
sudo cfdisk /dev/sdb
```

### 2 Añadir un nuevo disco de 10 GB de tipo “SSD” a la máquina virtual. En este ejercicio nos referiremos a este disco como SSD


### 3 En ambos discos, crear 1 partición de 4 GB y formatearla como Ext4. Montar la partición del disco balanceado en el directorio /discoBalanceado y la partición del disco SSD en el directorio /discoSSD. No es necesario configurar los montajes para que se realicen en el arranque del sistema

```bash
sudo cfdisk /dev/sdb
sudo cfdick /dev/sdc
sudo mkfs.ext4 /dev/sdb1
sudo mkfs.ext4 /dev/sdc1
mkdir /tmp/discoBalanceado
mkdir /tmp/discoSSD
sudo mount -t ext4 /dev/sdb1 /tmp/discoBalanceado
sudo mount -t ext4 /dev/sdc1 /tmp/discoSSD
sudo chown $USER:$USER /tmp/disco*
```

### 4 Revisar la 1ª sección de este artículo3 para aprender a realizar una prueba de rendimiento con fio

### 5 Instalar fio en el sistema siguiendo el comando que se indica en el artículo

```bash
apt install fio
```

### 6 Utilizar fio para realizar la siguiente prueba

#### a Creación de un fichero de contenido aleatorio de 1 GB

```bash
fio --name=testBalance --size=1G --filename=/tmp/discoBalanceado/test

testBalance: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=psync, iodepth=1
fio-3.28
Starting 1 process
testBalance: Laying out IO file (1 file / 1024MiB)
Jobs: 1 (f=1): [R(1)][100.0%][r=148MiB/s][r=38.0k IOPS][eta 00m:00s]
testBalance: (groupid=0, jobs=1): err= 0: pid=13318: Tue Sep 19 16:40:06 2023
  read: IOPS=38.7k, BW=151MiB/s (159MB/s)(1024MiB/6769msec)
    clat (nsec): min=1111, max=7886.4k, avg=25476.21, stdev=221921.05
     lat (nsec): min=1145, max=7886.4k, avg=25515.74, stdev=221920.76
    clat percentiles (nsec):
     |  1.00th=[   1256],  5.00th=[   1304], 10.00th=[   1352],
     | 20.00th=[   1496], 30.00th=[   1608], 40.00th=[   1704],
     | 50.00th=[   1784], 60.00th=[   1864], 70.00th=[   1960],
     | 80.00th=[   2064], 90.00th=[   2224], 95.00th=[   2544],
     | 99.00th=[1003520], 99.50th=[1630208], 99.90th=[3031040],
     | 99.95th=[3555328], 99.99th=[5079040]
   bw (  KiB/s): min=151040, max=192504, per=100.00%, avg=155177.23, stdev=11225.05, samples=13
   iops        : min=37760, max=48126, avg=38794.31, stdev=2806.26, samples=13
  lat (usec)   : 2=74.72%, 4=22.17%, 10=1.28%, 20=0.12%, 50=0.08%
  lat (usec)   : 100=0.06%, 250=0.11%, 500=0.04%, 750=0.07%, 1000=0.34%
  lat (msec)   : 2=0.58%, 4=0.39%, 10=0.03%
  cpu          : usr=4.09%, sys=13.50%, ctx=3844, majf=0, minf=16
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=151MiB/s (159MB/s), 151MiB/s-151MiB/s (159MB/s-159MB/s), io=1024MiB (1074MB), run=6769-6769msec

Disk stats (read/write):
  sdb: ios=4009/2, merge=0/1, ticks=11963/1, in_queue=11965, util=98.66%
```

#### b Mezcla de 75% y 25 % entre operaciones de lectura y escritura

```bash

```

#### c Resto de parámetro por defecto (cómo indicados en el ejemplo del artículo). Esta prueba se debe realizar con ambos discos. El nombre del fichero que se utilice es indiferente, pero debe estar dentro de cada carpeta /disco correspondiente en cada prueba. Los valores más representativos de las pruebas son las métricas de velocidad de lectura (READ) y escritura (WRITE), que se encuentran entre las últimas líneas que genera fio. Estos valores se indican en kB/s o MB/s, ¿qué diferencia hay entre ambos discos?

```bash

```

### 7 Repetir la prueba anterior, esta vez utilizando una mezcla de 50% de operaciones de lectura y 50% de operaciones de escritura. ¿Varían los resultados respecto a la 1ª prueba?

```bash

```

### 8 Revisar el precio de los discos de tipo balanceado y SSD en Google Cloud. ¿La diferencia de precio es proporcional con la diferencia de rendimiento?

```bash

```

### 9 Desmontar y eliminar el disco de tipo SSD

```bash

```

## 4 Gestion avanzada

### 1 Borrar las particiones creadas en las secciones anteriores en el disco

```bash

```

### 2 Añadir un nuevo disco de 10 GB de tipo balanceado a la máquina virtual

```bash

```

### 3 Crear 2 particiones de 3 GB en cada disco. Crear un volumen lógico LVM con 3 de las 4 particiones. Crear una partición ext4 en el volumen usando el 100% de espacio

```bash

```

### 4 Montar el sistema de ficheros en un directorio y comprobar su estado. Para ello, copiar alguno de los directorios del sistema operativo a él

```bash

```

### 5 Añadir la 4ª partición al volumen lógico y extender el tamaño del sistema de ficheros para que ocupe el total del volumen. Comprobar que los datos copiados en el paso anterior siguen estando

```bash

```

### 6 Borrar el volumen lógico recién creado (utilizar los comandos LVM apropiados)

```bash

```

### 7 Crear un sistema RAID 5 con 3 de las particiones. Crear un sistema de ficheros ext4 para el sistema RAID 5 y hacerlo accesible. Copiar el contenido de la carpeta /var a la carpeta del sistema RAID

```bash

```

### 8 Simular un fallo en el tercer disco (parámetro -f). Recuperar la información perdida usando la partición que quedó libre.

```bash

```

### 9 Desmontar y eliminar el dispositivo RAID. Eliminar el disco creado en el paso 2

```bash

```

## 5 Copias de seguridad

### 1 Borrar las particiones creadas en la sección anterior en el disco

```bash

```

### 2 Crear 1 partición de 4 GB en el disco y formatearla como ext4. Montarla en un directorio llamado /backups.

```bash

```

### 3 Instalar rsnapshot en el sistema y revisar este4 documento donde se detalla su configuración

```bash

```

### 4 Configurar rsnapshot de la siguiente forma:

```bash

```

#### a Directorio para almacenar las copias de seguridad: /backups

```bash

```

#### b Niveles de copia e intervalos

```bash

```

#### c Directorios a guardar (todos se almacenan en el directorio /backups): /home, /etc y /var/log

```bash

```

### 5 Verificar que la configuración es correcta con el comando rsnapshot configtest.

```bash

```

### 6 Realizar una copia de tipo “horaria” y revisar que los contenidos se han copiado correctamente.

```bash

```

### 7 Crear una carpeta y un fichero nuevo en el directorio /home de tu usuario (incluye algo de texto en el fichero). Después, realizar una nueva copia de tipo “horaria”

```bash

```

### 8 Verificar que la nueva copia se ha hecho correctamente y revisar los cambios entre ambas copias con el comando rsnapshot-diff.

```bash

```
