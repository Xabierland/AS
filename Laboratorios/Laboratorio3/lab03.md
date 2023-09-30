# Laboratorio 3.- Monitorización

## 1. Gestion de recursos del sistema

### 1- Obtener el numero de procesos en ejecucion en el sistema

```bash
ps ax | wc -l
106
```

### 2- Obtener el numero de procesos en ejecucion que pertenezcan a usuario root

```bash
ps -u root | wc -l
92
```

### 3- Instalar el paquete “stress-ng”. Ejecutar el benchmark para 1 núcleo de CPU y 20 segundos

```bash
sudo apt install stress-ng
nohup stress-ng --cpu 1 -t 20s &
```

### 4- Ejecutar de nuevo “stress-ng”, esta vez sin límite de tiempo. Mientras esté en ejecución

```bash
nohup stress-ng --cpu 1 &
```

#### a. Usar una señal para pausar su ejecucion

```bash
kill -STOP $PID
```

#### b. Usar una señal para reanudar su ejecucion

```bash
kill -CONT $PID
```

#### c. Reducir la prioridad del proceso al minimo. ¿Cambia algo?

```bash
renice -n 19 -p $PID
```

### 5- Detectar que proceso tiene la mayor prioridad en el sistema. Buscar cual es el proposito de ese proceso

```bash
htop
# El proceso que mas prioridad tiene es el systemd, el cual es el proceso que se ocupa de que el resto de procesos del sistema funcionen correctamente
```

### 6- Limitar al maximo tiempo de uso de CPU a 5 minutos para todos los usuarios

```bash
ulimit -t 300
```

### 7- Crear un fichero crontab para elusuario root con las siguientes tares

```bash
sudo crontab -e
```

#### a. Ejecutar el comando date cada minuto y escribir su salida estandar al fichero /tmp/date.log (se debe escribir al final del fichero cada vez)

```bash
        *       *       *       *       *       date >> /tmp/date.log
```

#### b. Borrar el directorio /tmp los primeros 5 dias de cada mes a las 17:00

```bash
        0       17      5       *       *       rm -rf /tmp*
```

### 8- Comprobar que las tareas de cron funcionan correctamente (ver el fichero /tmp/date.log)

```bash
cat /tmp/date.log
```

### 9- Usando netcat, A abre una conexión a la escucha en el puerto 3000. Si fuese necesario abrir puertos de Google Cloud. B se conecta a ese puerto y escribe el mensaje “Hola A”. Tras recibirlo, en la misma conexión, B escribe “Hola B” y cierra la conexión

```bash
nc -l -p 3000
nc 34.147.172.10 3000
```

### 10- El comando "dd if=/dev/urandom" sirve para generar numeros aleatorios. A abre una conexion a la escucha en el puerto 3000 y B envia numeros aleatorios a esa conexion de A. Sin cerrar la conexion A y B utilizan nethogs para comprobar la tasa de bytes enviados y recibidos en cada parte. ¿Los valores coinciden? Despues, A cierra la conexion

```bash
dd if=/dev/urandom | nc $IP 3000
```

### 11- A crea localmente un fichero con texto aleatroio. Utilizar netcat para que A envie este fichero a B ¿Que diferencia hay entre utilizar netcat y scp para enviar ficheros entre diferentes maquinas?

```bash
B> dd if=/dev/urando > file.txt
A> nc -l -p 3000 > file.txt
B> nc $IP 3000 < file.txt
```

## 2. Gestion de los registros del sistema

### 1- Leer la página de manual de logger. ¿Con qué parámetro se indica la prioridad de los mensajes?

```bash
man logger | grep "priority" # Con el -p
```

### 2- Utilizando la línea de comandos, enviar el mensaje “Hola Mundo de Logs” al fichero /var/log/syslog. Comprobar que se ha hecho correctamente

```bash
logger "Hola Mundo de Logs"
cat /var/log/syslog
```

### 3- Enviar todos los mensajes de nivel “debug” generados por el servicio sshd al fichero /var/log/ssh.log. Este fichero debe haber sido creado anteriormente y estar vacío. Configurar el servicio sshd para que funcione en modo “debug” y comprobar el efecto que tiene en el fichero ssh.log

```bash
sudo nano /etc/ssh/sshd_config                  #Editamos el fichero de sshd para activar el debug
        # Logging
        SyslogFacility AUTH
        LogLevel DEBUG

sudo nano /etc/rsyslog.d/50-default.conf        #Editamos el fichero de logs
        auth.debug                      -/var/log/ssh.log

sudo systemctl restart rsyslog.service          #Aplicamos los cambios
sudo systemctl restart sshd.service

cat /var/log/ssh.log
```

### 4- Configurar la rotación de logs (fichero /var/log/syslog) para que se guarden de manera mensual y comprimida, y para que todos los logs generados en un año se guarden en un directorio llamado /var/log/syslog.old

```bash
sudo nano /etc/logrotate.d/rsyslog
        /var/log/syslog 
        {
        rotate 12
        olddir /var/log/syslog.old
        monthly
        compress
        missingok
        }
        ...

sudo logrotate -f /etc/logrotate.conf
```

## 3. Monitorizacion en Google Cloud Platform

## 4. Evaluacion del rendimiento

### 1- Descarga el benchmark desde la web oficial

```bash
wget https://github.com/tud-zih-energy/FIRESTARTER/releases/download/v2.0/FIRESTARTER_2.0.tar.gz

tar -xf FIRESTARTER_2.0.tar.gz
```

### 2- Ejecutarlo durante 30 segundos, haciendo que muestre información adicional (un “report” de rendimiento). Buscar los parámetros necesarios para ello. ¿Qué valor de GFLOP/s obtienes? Este valor es una métrica de la capacidad de cómputo de tu CPU

```bash
./FIRESTARTER -r -t 30
        estimated floating point performance: 28.87 GFLOPS
```

### 3- La mayoría de CPUs modernas tienen varios conjuntos de instrucciones que permiten obtener diferentes niveles de rendimiento. Firestarter es capaz de detectar los conjuntos de instrucciones disponibles en la CPU y usarlos para evaluar su capacidad. Encuentra el parámetro que muestra los tipos disponibles en tu CPU

```bash
./FIRESTARTER --avail
```

### 4- Crea un script que ejecute Firestarter con cada tipo de instrucción disponible en tu CPU durante 30 segundos y reporte el mayor valor de GFLOP/s obtenido. Esté será el mayor rendimiento que el benchmark es capaz de obtener en tu CPU

```bash
./firestoper.sh
```

### 5- Crea un script similar al anterior, pero que devuelva el máximo valor obtenido para el ancho de banda de memoria (cuántos GB/s)

```bash
#Solo encuentro el source y al compilar me hace un .exe que no puedo ejecutar en linux
#Esperemos que no entre en el examen :D
```
