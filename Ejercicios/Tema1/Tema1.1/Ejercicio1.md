# Ejercicio 1

## Mostrar los nombres de los usuarios del sistema

```bash
cut -d ":" -f 1 /etc/passwd
```

## Mostrar la informacion de los usuarios que tengan bash como Shell de inicio

```bash
grep "bash" /etc/passwd
```

## Crear un enlace simbolico a /bin/bash en /tmp llamado "miBash"

```bash
ln -s /bin/bash -t /tmp
```

## Contrar el numero de lineas del fichero .bashrc en vuestro directorio raiz de usuario

```bash
wc -l .bashrc
```
