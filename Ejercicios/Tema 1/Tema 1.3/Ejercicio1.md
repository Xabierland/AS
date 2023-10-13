# Ejercicio 1

## Instalar el paquete stress-ng

```bash
sudo apt install stress-ng
```

## Ejectuar stess-ng durante 2 minutos con 2 hilos CPU. Mientras esta en ejecucion cambiar la prioridad de uno de sus procesos a la minima posible

```bash
stress-ng -c 3 -t 2m &> /dev/null &            #Creamos los procesos

top

sudo renice -n -20 -p 1378              #Cambiamos la prioridad
```

## Ejecutar stress-ng durante 3 minutos con 1 hilo CPU. Minetras esta en ejecucion, limitar su uso de CPU al 50%

```bash
nohup stress-ng -c 1 -t 3m &> /dev/null &         #Creamos el proceso

top

cpulimit --pid 1151 --limit 50
    1151 xabier    20   0   95956   5852   3456 T  55.0   0.3   1:51.13 stress-ng   #55%
```
