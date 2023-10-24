# Laboratorio 5.- Docker

## Docker Engine

### Ejecutar ‘docker --help' en el terminal y revisar las opciones disponibles para manipular contenedores

```bash
docker --help

Usage:  docker [OPTIONS] COMMAND

A self-sufficient runtime for containers

Common Commands:
  run         Create and run a new container from an image
  exec        Execute a command in a running container
  ps          List containers
  build       Build an image from a Dockerfile
  pull        Download an image from a registry
  push        Upload an image to a registry
  images      List images
  login       Log in to a registry
  logout      Log out from a registry
  search      Search Docker Hub for images
  version     Show the Docker version information
  info        Display system-wide information

Management Commands:
  builder     Manage builds
  buildx*     Docker Buildx (Docker Inc., v0.11.2)
  compose*    Docker Compose (Docker Inc., v2.21.0)
  container   Manage containers
  context     Manage contexts
  image       Manage images
  manifest    Manage Docker image manifests and manifest lists
  network     Manage networks
  plugin      Manage plugins
  system      Manage Docker
  trust       Manage trust on Docker images
  volume      Manage volumes

Swarm Commands:
  swarm       Manage Swarm

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  import      Import the contents from a tarball to create a filesystem image
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  wait        Block until one or more containers stop, then print their exit codes

Global Options:
      --config string      Location of client config files (default
                           "/home/xabier/.docker")
  -c, --context string     Name of the context to use to connect to
                           the daemon (overrides DOCKER_HOST env var
                           and default context set with "docker
                           context use")
  -D, --debug              Enable debug mode
  -H, --host list          Daemon socket to connect to
  -l, --log-level string   Set the logging level ("debug", "info",
                           "warn", "error", "fatal") (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA
                           (default "/home/xabier/.docker/ca.pem")
      --tlscert string     Path to TLS certificate file (default
                           "/home/xabier/.docker/cert.pem")
      --tlskey string      Path to TLS key file (default
                           "/home/xabier/.docker/key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

Run 'docker COMMAND --help' for more information on a command.

For more help on how to use Docker, head to https://docs.docker.com/go/guides/
```

### Utilizando la imagen de busybox, obtener la siguiente información. Para ello, sobre-escribe el comando de arranque en cada ocasión

#### Mostrar los sistemas de ficheros que están montados

```bash
docker run busybox df -h
```

#### Mostrar el contenido de la carpeta /etc. ¿Hay más o menos elementos que en la carpeta /etc de un Ubuntu Server?

```bash
docker run busybox ls /etc
group
hostname
hosts
localtime
mtab
network
nsswitch.conf
passwd
resolv.conf
shadow

Muchas menos cosas que en un ubuntu server
```

#### Mostrar el cuántos binarios ejecutables hay en la carpeta /bin. ¿Hay más o menos elementos que en la carpeta /bin de un Ubuntu Server?

```bash
docker run busybox ls /bin | wc -l
405

ls /bin | wc -l
1163

Hay bastante menos archivos en la carpeta /bin de busybox que en la de ubuntu server
```

#### Mostrar cuantas interfaces de red tiene y qué IPs tienen asignadas

```bash
docker run busybox ifconfig
eth0      Link encap:Ethernet  HWaddr 02:42:AC:11:00:02
          inet addr:172.17.0.2  Bcast:172.17.255.255  Mask:255.255.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:200 (200.0 B)  TX bytes:0 (0.0 B)

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)
```

### Lanzar un contenedor de busybox con el comando “ping www.ehu.eus”. Sin interrumpir su ejecución, parar el contenedor desde otro terminal con el comando “docker stop”. ¿Se realiza al instante?

```bash
docker run busybox ping www.ehu.eus
```

```bash
docker stop 1a6ebf301f28
```

```text
El contenedor tarda en pararse un rato
```

### Repetir la tarea anterior, pero utilizando “docker kill”. ¿Qué diferencia hay con utilizar “docker stop”?

```bash
docker run busybox ping www.ehu.eus
```

```bash
docker kill c6a5e6ab2726
```

```text
El contenedor para automaticamente.
La diferencia es que ambos parar el contendor pero stop permite a los procesos en ejecucion detenerse y borra lo que fuera necesario mientras que kill para el contenedor de golpe
```

### Abrir una Shell dentro de un contenedor busybox utilizando “docker run” y realizar lo siguiente

```bash
docker run -it --rm busybox
```

#### Mostrar el número de procesos en ejecución

```bash
ps | wc -l
4
```

#### Crear un fichero llamado miFichero dentro de /home

```bash
touch /home/miFichero
```

#### Cerrar la sesión

```bash
exit
```

### Abrir una Shell de nuevo en un contenedor busybox. ¿El fichero en /home sigue estando? ¿Por qué?

```bash
No esta ya que al cerrar la sesion el contenedor se ha parado tambien y todo el contenido que no sea propio de la imagen no se guardan
```

### Lanzar un contenedor con el servidor redis. Para ello, buscar en DockerHub el nombre de la imagen oficial de Redis. Si se ha lanzado correctamente, debería mostrarse “Ready to accept connections” en la salida

```bash
docker run redis
```

### Con el contenedor en ejecución, abrir una Shell y obtener la siguiente información

```bash
docker exec -it 7fd368291d55 /bin/bash
```

#### Mostrar el contenido de la carpeta /etc. ¿Hay más o menos elementos que en la carpeta /etc de la imagen busybox?

```bash
ls
adduser.conf            gshadow        motd           rc6.d
alternatives            gshadow-       mtab           rcS.d
apt                     gss            netconfig      resolv.conf
bash.bashrc             host.conf      nsswitch.conf  rmt
bindresvport.blacklist  hostname       opt            security
cron.d                  hosts          os-release     selinux
cron.daily              init.d         pam.conf       shadow
debconf.conf            issue          pam.d          shadow-
debian_version          issue.net      passwd         shells
default                 kernel         passwd-        skel
deluser.conf            ld.so.cache    profile        subgid
dpkg                    ld.so.conf     profile.d      subuid
e2scrub.conf            ld.so.conf.d   rc0.d          systemd
environment             libaudit.conf  rc1.d          terminfo
fstab                   localtime      rc2.d          timezone
gai.conf                login.defs     rc3.d          update-motd.d
group                   logrotate.d    rc4.d          xattr.conf
group-                  mke2fs.conf    rc5.d
```

#### Mostrar el cuántos binarios ejecutables hay en la carpeta /bin. ¿Hay más o menos elementos que en la carpeta /bin de busybox?

```bash
ls /bin | wc -l
277

Si, hay menos elementos que en /bin de busybox
```

### Con el contenedor en ejecución, ejecutar el comando “redis-cli” dentro de él para acceder a una consola de Redis. Añadir una variable llamada miVar con valor 7. Salir de la consola Redis

```bash
redis-cli
set miVar 7
exit
```

### Sin parar el contenedor, volver a entrar en la consola Redis. Leer el contenido de la variable miVar

```bash
redis-cli
get miVar
"7"
```

### Reiniciar el contenedor Redis y entrar a la consola. ¿Es posible leer el contenido de la variable miVar?

```bash
docker run redis
docker exec -it be481ad22f71 /bin/bash
get miVar
(nil)
```

### Para acceder al contenedor mientras estaba en marcha habrás utilizado el comando “docker exec”. ¿Qué diferencia hay al utilizar los siguientes parámetros?: -i, -t, -it, ninguno de ellos

```bash
-i (Interactivo)
    Permite interactuar con la terminal
-t (Terminal)
    Muestra la terminal de forma legible
-it (Interactivo y Terminal)
    Permite interactuar con la terminal y la muestra de forma legible
```

## Imagenes Docker Propia

### Crear un directorio nuevo en nuestro sistema y crear un fichero Dockerfile dentro. El Dockerfile deberá tener las siguientes instrucciones

```bash
mkdir DOCKER/lab
cd DOCKER/lab
nano Dockerfile
```

```Dockerfile
FROM ubuntu:latest
RUN apt -qq update && apt -qq -y install redis
CMD redis-server
```

### Utilizar los comandos de Docker para crear una imagen a partir del Dockerfile con el nombre <usuario>/<redis-ubuntu> donde <usuario> es un nombre que vosotros elijáis, p.e. ulopez para Unai Lopez

```bash
docker build -t="xabier/redis-ubuntu" .
```

### En el proceso de creación de la imagen, ¿cuántos contenedores intermedios se han creado? ¿Por qué?

```bash
docker history xabier/redis-ubuntu
```

### Lanzar un contenedor con la imagen recién creada y abrir una Shell mientras esté en ejecución. Utilizar los comandos vistos en la sección anterior para crear una variable “miOtraVar” con valor 8. Salir de la consola y de la Shell

```bash
docker run xabier/redis-ubuntu
docker exec -it 75217c2a9930 /bin/bash
redis-cli
set miOtraVar 8
exit
exit
```

### Abrir una Shell de nuevo en el contenedor y verificar que la variable “miOtraVar” mantiene su valor

```bash
docker exec -it 75217c2a9930 /bin/bash
redis-cli
get miOtraVar
"8"
```

### Crear un directorio nuevo en el sistema y crear un fichero Dockerfile dentro. El Dockerfile deberá tener las siguientes instrucciones

```bash
mkdir DOCKER/lab2
nano DOCKER/lab2/Dockerfile
```

```Dockerfile
FROM alpine:latest
RUN apk add --update redis
CMD redis-server
```

### Utilizar los comandos de Docker para crear una imagen a partir del Dockerfile con el nombre <usuario>/<redis-alpine> donde <usuario> es el nombre elegido en la tarea anterior

```bash
docker build -t="xabier/redis-alpine" .
```

### Lanzar un contenedor con la imagen y verificar que funciona correctamente: abrir una Shell al contenedor y utilizar la consola de Redis para añadir una variable “miVar” con valor 9.

```bash
docker run xabier/redis-alpine
docker exec -it 75217c2a9930 /bin/sh
redis-cli
set miVar 9
```

### Parar el contenedor y comparar los tamaños de las imágenes <redis-ubuntu> y <redis-alpine>. Teniendo en cuenta que ambas cumplen el mismo propósito, ¿cuál ocupa menos?

```bash
docker images
REPOSITORY            TAG       IMAGE ID       CREATED          SIZE
xabier/redis-alpine   latest    fb41bbec945c   3 minutes ago    11.8MB
xabier/redis-ubuntu   latest    5e4f363b8656   16 minutes ago   129MB

Alpine ocuba bastante menos
```

### Crear un directorio nuevo en nuestro sistema

```bash
mkdir DOCKER/lab3
```

### Dentro del nuevo directorio, crear un fichero index.html que contenga el código HTML que tenéis disponible al final de este enunciado

```bash
nano index.html
```

```html
<!DOCTYPE html>
<html>
<head><title>Web de prueba de Docker</title></head>
<body><h1>Hola!</h1><p>Esta es una web muy simple.</p></body>
</html>
```

### Dentro del nuevo directorio, crear un fichero Dockerfile con las siguientes instrucciones

```bash
nano Dockerfile
```

```Dockerfile
FROM ubuntu:latest
RUN apt -qq update && apt -qq -y install python3
COPY index.html /var/www/html/index.html
WORKDIR /var/www/html
CMD python3 -m http.server 1080
```

### Crear la imagen utilizando Docker con el nombre <usuario>/simple-web, donde <usuario> es un nombre que vosotros elijáis

```bash
docker build -t="xabier/simple-web" .
```

### Lanzar un contenedor con la imagen recién creada. Ya que el contenedor va a servir una web, es necesario redirigir uno de los puertos del contenedor al exterior para que sea usable. Para ello, es necesario utilizar el parámetro ‘-p’ de “docker run” o de “docker start”. Utilizar ‘-p’ para redirigir el puerto 1080 del contenedor al puerto 80 del anfitrión

```bash
docker run -p 80:1080 xabier/simple-web
```

### Abrir un navegador en el sistema en la dirección http://<IP-DE-VUESTRA-MAQUINA> y comprobar que semuestra la web. Al usar Google Cloud, para que la web se muestre, el Firewall debe permitir tráfico al puerto 80 de vuestra instancia

```bash
firefox 34.147.172.10
```
