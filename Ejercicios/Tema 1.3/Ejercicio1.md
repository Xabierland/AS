# Ejercicio 1

## Instalar el paquete stress-ng

```bash
sudo apt install stress-ng
```

## Ejectuar stess-ng durante 2 minutos con 2 hilos CPU. Mientras esta en ejecucion cambiar la prioridad de uno de sus procesos a la minima posible

```bash
nohup stress-ng --cpu 2 -t 2m &         #Creamos los procesos

ps -u xabier -o pid,user,pri,nice,args  #Vemos los PID
    PID USER     PRI  NI COMMAND
    773 xabier    19   0 /lib/systemd/systemd --user
    774 xabier    19   0 (sd-pam)
    854 xabier    19   0 sshd: xabier@pts/0
    855 xabier    19   0 -bash
    948 xabier    19   0 stress-ng --cpu 2 -t 2m
    949 xabier    19   0 stress-ng-cpu [run]
    950 xabier    19   0 stress-ng-cpu [run]
    955 xabier    19   0 ps -u xabier -o pid,user,pri,nice,args

renice -n 19 -p 949                     #Cambiamos la prioridad
    PID USER     PRI  NI COMMAND
    773 xabier    19   0 /lib/systemd/systemd --user
    774 xabier    19   0 (sd-pam)
    854 xabier    19   0 sshd: xabier@pts/0
    855 xabier    19   0 -bash
    948 xabier    19   0 stress-ng --cpu 2 -t 2m
    949 xabier     0  19 stress-ng-cpu [run]
    950 xabier    19   0 stress-ng-cpu [run]
    957 xabier    19   0 ps -u xabier -o pid,user,pri,nice,args
```

## Ejecutar stress-ng durante 3 minutos con 1 hilo CPU. Minetras esta en ejecucion, limitar su uso de CPU al 50%

```bash
nohup stress-ng --cpu 1 -t 3m &         #Creamos el proceso

ps -u xabier -o pid,user,pri,nice,args  #Vemos los PID
    PID USER     PRI  NI COMMAND
    773 xabier    19   0 /lib/systemd/systemd --user
    774 xabier    19   0 (sd-pam)
    854 xabier    19   0 sshd: xabier@pts/0
    855 xabier    19   0 -bash
   1150 xabier    19   0 stress-ng --cpu 1 -t 3m
   1151 xabier    19   0 stress-ng-cpu [run]
   1154 xabier    19   0 ps -u xabier -o pid,user,pri,nice,args

cpulimit --pid 1151 --limit 50
    1151 xabier    20   0   95956   5852   3456 T  55.0   0.3   1:51.13 stress-ng
```
