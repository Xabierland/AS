# Ejercicio 3

## B crea dos cuentas de usuario para A y B en el Broker

```bash
sudo mosquitto_passwd -c /etc/mosquitto/passwd xabier

sudo mosquitto_passwd /etc/mosquitto/passwd fran

sudo nano /etc/mosquitto/acl
    #User A
    user xabier
    topic read colores

    #User B
    user fran
    topic readwrite colores

sudo nano /etc/mosquitto/mosquitto.conf
    #allow_anonymous true
    password_file /etc/mosquitto/passwd
    acl_file /etc/mosquitto/acl

sudo service mosquitto restart
```

## B se suscribe al topic ”colores” y A publica un mensaje

```bash
sudo mosquitto_sub -h localhost -t colores -v -u xabier -P 1234

sudo mosquitto_pub -h localhost -t colores -m "Rojo" -u fran -P 1234
```

## A se suscribe al topic “colores” y B publica un mensaje

```bash
sudo mosquitto_sub -h localhost -t colores -u fran -P 1234

sudo mosquitto_pub -h localhost -t colores -m "Rojo" -u xabier -P 1234
```
