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
Solo se puede montar un sistema ext3 como un ext4 haciendo que el ext4 tenga las limitaciones de ext3. Para montar un sistema ext3 a ext4 debemos hacer ciertas conversiones más.
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

```bash
fio --name=testSSD --size=1G --filename=/tmp/discoSSD/test

testSSD: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=psync, iodepth=1
fio-3.28
Starting 1 process
Jobs: 1 (f=1): [R(1)][100.0%][r=240MiB/s][r=61.5k IOPS][eta 00m:00s]
testSSD: (groupid=0, jobs=1): err= 0: pid=1080: Wed Sep 20 18:31:48 2023
  read: IOPS=62.4k, BW=244MiB/s (256MB/s)(1024MiB/4201msec)
    clat (nsec): min=1100, max=10032k, avg=15677.92, stdev=145473.03
     lat (nsec): min=1132, max=10032k, avg=15717.05, stdev=145472.98
    clat percentiles (nsec):
     |  1.00th=[   1256],  5.00th=[   1320], 10.00th=[   1352],
     | 20.00th=[   1432], 30.00th=[   1512], 40.00th=[   1576],
     | 50.00th=[   1624], 60.00th=[   1672], 70.00th=[   1736],
     | 80.00th=[   1816], 90.00th=[   1976], 95.00th=[   2224],
     | 99.00th=[ 569344], 99.50th=[1036288], 99.90th=[1974272],
     | 99.95th=[2834432], 99.99th=[4014080]
   bw (  KiB/s): min=237640, max=279008, per=100.00%, avg=250300.00, stdev=12230.86, samples=8
   iops        : min=59410, max=69752, avg=62575.00, stdev=3057.72, samples=8
  lat (usec)   : 2=90.78%, 4=6.42%, 10=0.93%, 20=0.12%, 50=0.09%
  lat (usec)   : 100=0.08%, 250=0.36%, 500=0.16%, 750=0.23%, 1000=0.27%
  lat (msec)   : 2=0.45%, 4=0.09%, 10=0.01%, 20=0.01%
  cpu          : usr=5.93%, sys=25.02%, ctx=3351, majf=0, minf=15
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=244MiB/s (256MB/s), 244MiB/s-244MiB/s (256MB/s-256MB/s), io=1024MiB (1074MB), run=4201-4201msec

Disk stats (read/write):
  sdc: ios=4048/0, merge=0/0, ticks=6573/0, in_queue=6573, util=97.88%
```

#### b Mezcla de 75% y 25 % entre operaciones de lectura y escritura

```bash
fio --name=testBalance --rwmixread=75 --size=1G --filename=/tmp/discoBalanceado/test

testBalance: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=psync, iodepth=1
fio-3.28
Starting 1 process
Jobs: 1 (f=1): [R(1)][100.0%][r=149MiB/s][r=38.1k IOPS][eta 00m:00s]
testBalance: (groupid=0, jobs=1): err= 0: pid=1278: Wed Sep 20 19:05:06 2023
  read: IOPS=38.6k, BW=151MiB/s (158MB/s)(1024MiB/6792msec)
    clat (nsec): min=1116, max=7985.3k, avg=25470.94, stdev=197243.51
     lat (nsec): min=1148, max=7985.3k, avg=25510.39, stdev=197243.39
    clat percentiles (nsec):
     |  1.00th=[   1256],  5.00th=[   1304], 10.00th=[   1336],
     | 20.00th=[   1384], 30.00th=[   1480], 40.00th=[   1560],
     | 50.00th=[   1624], 60.00th=[   1704], 70.00th=[   1784],
     | 80.00th=[   1896], 90.00th=[   2064], 95.00th=[   2288],
     | 99.00th=[1449984], 99.50th=[1613824], 99.90th=[2007040],
     | 99.95th=[2473984], 99.99th=[3457024]
   bw (  KiB/s): min=151648, max=185312, per=100.00%, avg=154700.31, stdev=9200.72, samples=13
   iops        : min=37912, max=46328, avg=38675.08, stdev=2300.18, samples=13
  lat (usec)   : 2=87.01%, 4=10.06%, 10=1.08%, 20=0.13%, 50=0.08%
  lat (usec)   : 100=0.08%, 250=0.01%, 500=0.06%, 750=0.04%, 1000=0.05%
  lat (msec)   : 2=1.31%, 4=0.10%, 10=0.01%
  cpu          : usr=3.62%, sys=29.26%, ctx=4279, majf=0, minf=14
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=151MiB/s (158MB/s), 151MiB/s-151MiB/s (158MB/s-158MB/s), io=1024MiB (1074MB), run=6792-6792msec

Disk stats (read/write):
  sdb: ios=4018/0, merge=0/0, ticks=11107/0, in_queue=11107, util=98.35%
```

```bash
fio --name=testSSD --rwmixread=75 --size=1G --filename=/tmp/discoSSD/test

testSSD: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=psync, iodepth=1
fio-3.28
Starting 1 process
Jobs: 1 (f=1): [R(1)][100.0%][r=240MiB/s][r=61.5k IOPS][eta 00m:00s]
testSSD: (groupid=0, jobs=1): err= 0: pid=1293: Wed Sep 20 19:12:17 2023
  read: IOPS=62.1k, BW=242MiB/s (254MB/s)(1024MiB/4223msec)
    clat (nsec): min=1116, max=6629.8k, avg=15622.36, stdev=125046.12
     lat (nsec): min=1149, max=6629.8k, avg=15662.20, stdev=125046.20
    clat percentiles (nsec):
     |  1.00th=[   1224],  5.00th=[   1272], 10.00th=[   1304],
     | 20.00th=[   1352], 30.00th=[   1432], 40.00th=[   1528],
     | 50.00th=[   1624], 60.00th=[   1704], 70.00th=[   1800],
     | 80.00th=[   1912], 90.00th=[   2096], 95.00th=[   2352],
     | 99.00th=[ 708608], 99.50th=[1105920], 99.90th=[1515520],
     | 99.95th=[1662976], 99.99th=[2408448]
   bw (  KiB/s): min=245760, max=261632, per=100.00%, avg=248700.00, stdev=5617.76, samples=8
   iops        : min=61440, max=65408, avg=62175.00, stdev=1404.44, samples=8
  lat (usec)   : 2=85.69%, 4=11.71%, 10=0.78%, 20=0.10%, 50=0.08%
  lat (usec)   : 100=0.06%, 250=0.14%, 500=0.27%, 750=0.19%, 1000=0.32%
  lat (msec)   : 2=0.63%, 4=0.02%, 10=0.01%
  cpu          : usr=6.02%, sys=35.53%, ctx=3338, majf=0, minf=14
  IO depths    : 1=100.0%, 2=0.0%, 4=0.0%, 8=0.0%, 16=0.0%, 32=0.0%, >=64=0.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=1

Run status group 0 (all jobs):
   READ: bw=242MiB/s (254MB/s), 242MiB/s-242MiB/s (254MB/s-254MB/s), io=1024MiB (1074MB), run=4223-4223msec

Disk stats (read/write):
  sdc: ios=4026/0, merge=0/0, ticks=6341/0, in_queue=6342, util=96.98%
```

#### c Resto de parámetro por defecto (cómo indicados en el ejemplo del artículo). Esta prueba se debe realizar con ambos discos. El nombre del fichero que se utilice es indiferente, pero debe estar dentro de cada carpeta /disco correspondiente en cada prueba. Los valores más representativos de las pruebas son las métricas de velocidad de lectura (READ) y escritura (WRITE), que se encuentran entre las últimas líneas que genera fio. Estos valores se indican en kB/s o MB/s, ¿qué diferencia hay entre ambos discos?

```bash
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=testBalance --bs=4k --iodepth=64 --readwrite=randrw --rwmixread=75 --size=1G --filename=/tmp/discoBalanceado/test

testBalance: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.28
Starting 1 process
Jobs: 1 (f=1): [m(1)][100.0%][r=9540KiB/s,w=3184KiB/s][r=2385,w=796 IOPS][eta 00m:00s]
testBalance: (groupid=0, jobs=1): err= 0: pid=1311: Wed Sep 20 19:20:52 2023
  read: IOPS=2433, BW=9736KiB/s (9969kB/s)(768MiB/80732msec)
   bw (  KiB/s): min= 9224, max=41928, per=100.00%, avg=9747.28, stdev=2556.11, samples=161
   iops        : min= 2306, max=10482, avg=2436.82, stdev=639.03, samples=161
  write: IOPS=813, BW=3253KiB/s (3331kB/s)(256MiB/80732msec); 0 zone resets
   bw (  KiB/s): min= 2784, max=14432, per=100.00%, avg=3255.60, stdev=897.02, samples=161
   iops        : min=  696, max= 3608, avg=813.90, stdev=224.26, samples=161
  cpu          : usr=2.49%, sys=7.92%, ctx=197741, majf=0, minf=7
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=196498,65646,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=9736KiB/s (9969kB/s), 9736KiB/s-9736KiB/s (9969kB/s-9969kB/s), io=768MiB (805MB), run=80732-80732msec
  WRITE: bw=3253KiB/s (3331kB/s), 3253KiB/s-3253KiB/s (3331kB/s-3331kB/s), io=256MiB (269MB), run=80732-80732msec

Disk stats (read/write):
  sdb: ios=196291/65608, merge=0/16, ticks=3848685/1291697, in_queue=5140385, util=99.95%
```

```bash
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=testSSD --bs=4k --iodepth=64 --readwrite=randrw --rwmixread=75 --size=1G --filename=/tmp/discoSSD/test

testSSD: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.28
Starting 1 process
Jobs: 1 (f=1): [m(1)][100.0%][r=18.5MiB/s,w=6280KiB/s][r=4734,w=1570 IOPS][eta 00m:00s]
testSSD: (groupid=0, jobs=1): err= 0: pid=1317: Wed Sep 20 19:22:15 2023
  read: IOPS=4919, BW=19.2MiB/s (20.1MB/s)(768MiB/39945msec)
   bw (  KiB/s): min=18448, max=81944, per=100.00%, avg=19707.06, stdev=7094.49, samples=79
   iops        : min= 4612, max=20486, avg=4926.76, stdev=1773.62, samples=79
  write: IOPS=1643, BW=6574KiB/s (6731kB/s)(256MiB/39945msec); 0 zone resets
   bw (  KiB/s): min= 5856, max=27360, per=100.00%, avg=6584.54, stdev=2374.70, samples=79
   iops        : min= 1464, max= 6840, avg=1646.13, stdev=593.68, samples=79
  cpu          : usr=3.44%, sys=12.31%, ctx=154389, majf=0, minf=6
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=196498,65646,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=19.2MiB/s (20.1MB/s), 19.2MiB/s-19.2MiB/s (20.1MB/s-20.1MB/s), io=768MiB (805MB), run=39945-39945msec
  WRITE: bw=6574KiB/s (6731kB/s), 6574KiB/s-6574KiB/s (6731kB/s-6731kB/s), io=256MiB (269MB), run=39945-39945msec

Disk stats (read/write):
  sdc: ios=196261/65573, merge=0/7, ticks=1891183/645043, in_queue=2536226, util=99.67%
```

### 7 Repetir la prueba anterior, esta vez utilizando una mezcla de 50% de operaciones de lectura y 50% de operaciones de escritura. ¿Varían los resultados respecto a la 1ª prueba?

```bash
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=testBalance --bs=4k --iodepth=64 --readwrite=randrw --rwmixread=50 --size=1G --filename=/tmp/discoBalanceado/test

testBalance: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.28
Starting 1 process
Jobs: 1 (f=1): [m(1)][100.0%][r=6454KiB/s,w=6270KiB/s][r=1613,w=1567 IOPS][eta 00m:00s]
testBalance: (groupid=0, jobs=1): err= 0: pid=1324: Wed Sep 20 19:26:02 2023
  read: IOPS=1623, BW=6495KiB/s (6651kB/s)(512MiB/80697msec)
   bw (  KiB/s): min= 5968, max=28120, per=100.00%, avg=6503.35, stdev=1721.73, samples=161
   iops        : min= 1492, max= 7030, avg=1625.84, stdev=430.43, samples=161
  write: IOPS=1624, BW=6499KiB/s (6655kB/s)(512MiB/80697msec); 0 zone resets
   bw (  KiB/s): min= 5896, max=29096, per=100.00%, avg=6505.44, stdev=1798.55, samples=161
   iops        : min= 1474, max= 7274, avg=1626.36, stdev=449.64, samples=161
  cpu          : usr=2.31%, sys=7.37%, ctx=191815, majf=0, minf=7
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=131040,131104,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=6495KiB/s (6651kB/s), 6495KiB/s-6495KiB/s (6651kB/s-6651kB/s), io=512MiB (537MB), run=80697-80697msec
  WRITE: bw=6499KiB/s (6655kB/s), 6499KiB/s-6499KiB/s (6655kB/s-6655kB/s), io=512MiB (537MB), run=80697-80697msec

Disk stats (read/write):
  sdb: ios=130980/131050, merge=0/16, ticks=2559994/2581589, in_queue=5141586, util=99.99%
```

```bash
fio --randrepeat=1 --ioengine=libaio --direct=1 --gtod_reduce=1 --name=testSSD --bs=4k --iodepth=64 --readwrite=randrw --rwmixread=50 --size=1G --filename=/tmp/discoSSD/test

testSSD: (g=0): rw=randrw, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
fio-3.28
Starting 1 process
Jobs: 1 (f=0): [f(1)][100.0%][r=11.9MiB/s,w=12.0MiB/s][r=3043,w=3077 IOPS][eta 00m:00s]
testSSD: (groupid=0, jobs=1): err= 0: pid=1330: Wed Sep 20 19:28:06 2023
  read: IOPS=3287, BW=12.8MiB/s (13.5MB/s)(512MiB/39864msec)
   bw (  KiB/s): min=12056, max=35008, per=100.00%, avg=13169.35, stdev=3494.64, samples=79
   iops        : min= 3014, max= 8752, avg=3292.32, stdev=873.66, samples=79
  write: IOPS=3288, BW=12.8MiB/s (13.5MB/s)(512MiB/39864msec); 0 zone resets
   bw (  KiB/s): min=12120, max=35312, per=100.00%, avg=13172.81, stdev=3489.31, samples=79
   iops        : min= 3030, max= 8828, avg=3293.18, stdev=872.33, samples=79
  cpu          : usr=3.61%, sys=12.10%, ctx=145965, majf=0, minf=7
  IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
     submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
     complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
     issued rwts: total=131040,131104,0,0 short=0,0,0,0 dropped=0,0,0,0
     latency   : target=0, window=0, percentile=100.00%, depth=64

Run status group 0 (all jobs):
   READ: bw=12.8MiB/s (13.5MB/s), 12.8MiB/s-12.8MiB/s (13.5MB/s-13.5MB/s), io=512MiB (537MB), run=39864-39864msec
  WRITE: bw=12.8MiB/s (13.5MB/s), 12.8MiB/s-12.8MiB/s (13.5MB/s-13.5MB/s), io=512MiB (537MB), run=39864-39864msec

Disk stats (read/write):
  sdc: ios=130354/130419, merge=0/7, ticks=1243083/1280925, in_queue=2524009, util=99.87%
```

### 8 Revisar el precio de los discos de tipo balanceado y SSD en Google Cloud. ¿La diferencia de precio es proporcional con la diferencia de rendimiento?

```bash
La mejora es de alrededor de veinte veces mayor lectura y escritura para el SSD mientras que el precio es 3-4 veces mayor por lo que dependiendo el caso podria salir rentable
```

### 9 Desmontar y eliminar el disco de tipo SSD

```bash
sudo umount /dev/sdc1
```

## 4 Gestion avanzada

### 1 Borrar las particiones creadas en las secciones anteriores en el disco

```bash
sudo umount /dev/sdb1
sudo cfdisk /dev/sdb
```

### 2 Añadir un nuevo disco de 10 GB de tipo balanceado a la máquina virtual

### 3 Crear 2 particiones de 3 GB en cada disco. Crear un volumen lógico LVM con 3 de las 4 particiones. Crear una partición ext4 en el volumen usando el 100% de espacio

```bash
sudo cfdisk /dev/sdb
sudo cfdisk /dev/sdc
sudo vgcreate grupoVol /dev/sdb1 /dev/sdb2 /dev/sdc1
sudo lvcreate grupoVol -l 100%FREE -n miVolumen
sudo mkfs.ext4 /dev/grupoVol/miVolumen
```

### 4 Montar el sistema de ficheros en un directorio y comprobar su estado. Para ello, copiar alguno de los directorios del sistema operativo a él

```bash
mkdir /tmp/lvmFolder
sudo mount -t ext4 /dev/grupoVol/miVolumen /tmp/lvmFolder
sudo cp -r /var/* /tmp/lvmFolder
```

### 5 Añadir la 4ª partición al volumen lógico y extender el tamaño del sistema de ficheros para que ocupe el total del volumen. Comprobar que los datos copiados en el paso anterior siguen estando

```bash
sudo vgextend grupoVol /dev/sdc2
sudo lvextend /dev/grupoVol/miVolumen /dev/sdc2
sudo resize2fs /dev/grupoVol/miVolumen
ls /tmp/lvmFolder/
```

### 6 Borrar el volumen lógico recién creado (utilizar los comandos LVM apropiados)

```bash
sudo umount /dev/grupoVol/miVolumen
sudo lvremove /dev/grupoVol/miVolumen
```

### 7 Crear un sistema RAID 5 con 3 de las particiones. Crear un sistema de ficheros ext4 para el sistema RAID 5 y hacerlo accesible. Copiar el contenido de la carpeta /var a la carpeta del sistema RAID

```bash
sudo mdadm --create /dev/md0 --verbose --level=5 --raid-devices=3 /dev/sdb1 /dev/sdb2 /dev/sdc1
sudo mkfs.ext4 /dev/md0
mkdir /tmp/raidFolder
sudo mount -t ext4 /dev/md0 /tmp/raidFolder
sudo cp -r /var/* /tmp/raidFolder
```

### 8 Simular un fallo en el tercer disco (parámetro -f). Recuperar la información perdida usando la partición que quedó libre.

```bash
sudo mdadm /dev/md0 -f /dev/sdc1
sudo mdadm /dev/md0 -r /dev/sdc1
sudo mdadm /dev/md0 -a /dev/sdc2
cat /proc/mdstat
```

### 9 Desmontar y eliminar el dispositivo RAID. Eliminar el disco creado en el paso 2

```bash
sudo umount /dev/md0
sudo mdadm --stop /dev/md0
sudo mdadm --zero-superblock /dev/sdb
```

## 5 Copias de seguridad

### 1 Borrar las particiones creadas en la sección anterior en el disco

```bash
sudo cfdisk /dev/sdb
```

### 2 Crear 1 partición de 4 GB en el disco y formatearla como ext4. Montarla en un directorio llamado /backups.

```bash
sudo cfdisk /dev/sdb
sudo mkfs.ext4 /dev/sdb1
sudo mount -t ext4 /dev/sdb1 /mnt/backups
sudo mkdir /mnt/backups
sudo chown $USER:$USER /mnt/backups
```

### 3 Instalar rsnapshot en el sistema y revisar este documento donde se detalla su configuración

```bash
sudo apt install rsnapshot
```

### 4 Configurar rsnapshot de la siguiente forma:

#### a Directorio para almacenar las copias de seguridad: /backups

```bash
sudo cp /etc/rsnapshot.conf /etc/rsnapshot.conf.default
sudo nano /etc/rsnapshot.conf

###########################
# SNAPSHOT ROOT DIRECTORY #
###########################

# All snapshots will be stored under this root directory.
#
snapshot_root   /mnt/backups/
```

#### b Niveles de copia e intervalos

```bash
#########################################
#     BACKUP LEVELS / INTERVALS         #
# Must be unique and in ascending order #
# e.g. alpha, beta, gamma, etc.         #
#########################################

retain  hourly  24
retain  daily   7
retain  weekly  4
```

#### c Directorios a guardar (todos se almacenan en el directorio /backups): /home, /etc y /var/log

```bash
###############################
### BACKUP POINTS / SCRIPTS ###
###############################

# LOCALHOST
backup  /home/          localhost/
backup  /etc/           localhost/
#backup /usr/local/     localhost/
backup  /var/log        localhost/
```

### 5 Verificar que la configuración es correcta con el comando rsnapshot configtest.

```bash
rsnapshot configtest
```

### 6 Realizar una copia de tipo “horaria” y revisar que los contenidos se han copiado correctamente.

```bash
sudo rsnapshot hourly
ls /mnt/backups/hourly.0/
```

### 7 Crear una carpeta y un fichero nuevo en el directorio /home de tu usuario (incluye algo de texto en el fichero). Después, realizar una nueva copia de tipo “horaria”

```bash
mkdir prueba
echo "Hola Mundo" > prueba/prueba.txt
sudo rsnapshot hourly
```

### 8 Verificar que la nueva copia se ha hecho correctamente y revisar los cambios entre ambas copias con el comando rsnapshot-diff.

```bash
ls /mnt/backups/hourly.1/
sudo rsnapshot-diff -vH /mnt/backups/hourly.0/ /mnt/backups/hourly.1/
```
