# Ejercicios 2

## Mostrar el usuario del sistema que cambio la contraseña hace mas tiempo

```bash

```

## Crear una variable de entorno CIUDAD persistente con el nombre de una ciudad

```bash
echo CIUDAD=Bilbao >> .bashrc
```

## Guardar en un fichero las 4 ultimas columnas resultantes de llamar al comando ping www.ehu.eus

```bash
ping -c 3 www.ehu.eus | tail -n 4 > ping.txt
```
