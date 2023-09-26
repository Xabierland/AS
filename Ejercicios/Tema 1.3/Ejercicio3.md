# Ejercicio 3

## Enviar un mensaje al log del sistema desde el terminal y comprobar que se ha añadido correctamente

```bash
logger "Hola Mundo"
cat /var/log/syslog | grep "xabier:"
Sep 26 10:37:29 as xabier: Hola Mundo
```

## Añadir una regla a syslog para que los mensajes de usuario de tipo "debug" se escriban en /var/log/user_debug.log

```bash
sudo nano /etc/rsyslog.d/50-default.conf
    +    debug.*                         -/var/log/user_debug.log
sudo systemctl restart rsyslog.service
```

## Enviar un mensaje de tipo debug y comprobar que se escribe en un /var/log/user_debug.log

```bash
logger -p debug "Hola debug!"
```

## Devolver syslog a su situacion anterior

```bash
sudo nano /etc/rsyslog.d/50-default.conf
    -    debug.*                         -/var/log/user_debug.log
```
