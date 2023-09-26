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

```

#### b. Borrar el directorio /tmp los primeros 5 dias de cada mes a las 17:00

```bash

```

### 8- Comprobar que las tareas de cron funcionan correctamente (ver el fichero /tmp/date.log)

```bash
cat /tmp/date.log
```

### 9- Usando netcat, A abre una conexión a la escucha en el puerto 3000. Si fuese necesario abrir puertos de Google Cloud, se recomienda este tutorial 1. B se conecta a ese puerto y escribe el mensaje “Hola A”. Tras recibirlo, en la misma conexión, B escribe “Hola B” y cierra la conexión

### 10-

### 11-

## 2. Gestion de los registros del sistema

## 3. Monitorizacion en google cloud platform

## 4. Evaluacion del rendimiento
