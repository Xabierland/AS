# Ejercicio 1

## Definir un grupo de instanias con las siguientes caracteristicas:

* Plantilla de MVs:
  * MVs tipo n1-standard-1, SSOO Ubuntu 22.04 LTS.
  * Se debe instalar el servidor web Apache automáticamente al Inicio.
* Cantidad de MV: Minimo 1, Maximo 4.
* Umbral de auto-escalado: 80%

```bash
sudo apt update
sudo apt install -y apache2
```

* Acceder por ssh a la 1ª MV del grupo y utilizar stress-ng para provocar un 90% de uso de CPU durante 2 minutos
  * Verificar que se crean nuevas MVs
  * Verificar que cada MV tiene un servidor Web en marcha

```bash
stress-ng -c 3 -t 2m &> /dev/null &
```