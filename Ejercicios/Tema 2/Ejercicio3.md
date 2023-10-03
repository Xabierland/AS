# Ejercicio 3

## Configurar servidor

```bash
sudo mosquitto_passwd -c /etc/mosquitto/passwd xabier

sudo mosquitto_passwd /etc/mosquitto/passwd fran

sudo nano /etc/mosquitto/acl
    topic readwrite colores

sudo nano /etc/mosquitto/mosquitto.conf
    #allow_anonymous true
    password_file /etc/mosquitto/passwd
    acl_file /etc/mosquitto/acl

sudo service mosquitto restart
```

## Enviar y recibir mensajes
