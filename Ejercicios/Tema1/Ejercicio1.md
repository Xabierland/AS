# Ejercicio 1

## Mostrar los nombres de los usuarios del sistema

```bash
>cut -d ":" -f 1 /etc/passwd
root
daemon
bin
sys
sync
games
man
lp
mail
news
uucp
proxy
www-data
backup
list
irc
gnats
nobody
systemd-network
systemd-resolve
messagebus
systemd-timesync
syslog
_apt
uuidd
tcpdump
xabier
```

## Mostrar la informacion de los usuarios que tengan bash como Shell de inicio

```bash
>grep "bash" /etc/passwd
root:x:0:0:root:/root:/bin/bash
xabier:x:1000:1000:,,,:/home/xabier:/bin/bash
```

## Crear un enlace simbolico a /bin/bash en /tmp llamado "miBash"

```bash
ln -s /bin/bash -t /tmp
```

## Contrar el numero de lineas del fichero .bashrc en vuestro directorio raiz de usuario

```bash
wc -l .bashrc
```