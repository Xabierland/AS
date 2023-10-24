# Ejercicio 2

## Configurar servidor

```bash
sudo nano /etc/mosquitto/mosquitto.conf
    + listener 1883 0.0.0.0
    + allow_anonymous true
```

## Empezar a escuchar

```bash
mosquitto_sub -h localhost -t ciudades/bizkaia -v
mosquitto_pub -h $IP -t "ciudades/bizkaia" -m "Bilbao"

mosquitto_sub -h localhost -t ciudades/# -v
mosquitto_pub -h $IP -t "ciudades/gipuzkoa" -m "Donostia"

mosquitto_pub -h $IP -t "ciudades/araba" -m "Gasteiz" -r
mosquitto_sub -h localhost -t ciudades/# -v
```
