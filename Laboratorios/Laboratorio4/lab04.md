# Laboratorio 4 - NFS y MQTT

## MV1

```bash
sudo apt install mosquitto mosquitto-clients    # Instalamos mosquitto para enviar los datos

nano getValor.sh                # Creamos el sh

sudo chmod +x getValor.sh       # Damos los permisos de ejecucion

sudo crontab -e                 # Creamos la rutina para que se ejecute cada minuto
    *       *       *       *       *       $HOME/getValor.sh
```

## MV2

```bash
sudo apt install mosquitto mosquitto-clients    # Instalamos mosquitto para recibir los datos

sudo apt install nfs-common      # Instalamos el cliente de NFS

sudo mkdir -p /mnt/datos                    # Creamos la carpeta donde montaremos el disco

sudo mount -t nfs $IPmv3:/datos /mnt/datos  # Montamos el disco desde el servidor remoto

sudo mosquitto_sub -h localhost -t divisa  > /mnt/datos/index.html # Nos ponemos a la escucha del mensaje con el valor que nos envia el script getValor.sh
```

## MV3

```bash
sudo apt install nfs-kernel-server nfs-common   # Instalamos tanto el servidor como el cliente de NFS

sudo mkdir /datos                   # Creamos la carpeta en la que guardar los datos a recibir por mqtt

sudo touch /datos/index.html        # Creamos el archivo en el que se escribira el dato

sudo chmod 666 /datos/index.html    # Damos permisos a todos los usuarios que monten el disco para escribir

sudo nano /etc/exports              # Permitimos montar el disco a las IPs de la MV2 y MV4
```

## MV4

```bash
sudo apt install nfs-common                     # Instalamos el cliente de NFS

sudo mkdir -p /mnt/datos                        # Creamos el punto de montaje para los datos

sudo mount -t nfs $IPmv3:/datos /mnt/datos      # Montamos los datos desde el servidor en el punto de montaje

sudo python3 -m http.server 80                  # Cargamos los datos que vamos recibiendo mediante un servidor python
```