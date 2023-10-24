# Ejercicio 2

## B prepara las MV1 y MV2 con Zookeeper y 2 Brokers

### MV1

```bash
# Iniciamos Zookeeper
bin/zookeeper-server-start.sh config/zookeeper.properties &

# Configuramos el broker
nano config/server.properties
    broker.id=0
    listeners=PLAINTEXT://:9092
    advertised.listeners=PLAINTEXT://35.240.103.2:9092
    zookeeper.connect=35.240.103.2:2181

# Iniciamos el broker
bin/kafka-server-start.sh config/server.properties &
```

### MV2

```bash
# Configuramos el broker
nano config/server.properties
    broker.id=1
    listeners=PLAINTEXT://:9092
    advertised.listeners=PLAINTEXT://8.34.221.34:9092
    zookeeper.connect=35.240.103.2:2181

# Iniciamos el broker
bin/kafka-server-start.sh config/server.properties &
```

## B crea un topic “ciudades” con factor de replicación 2

```bash
# Creamos el topic
bin/kafka-topics.sh --create --topic ciudades --bootstrap-server localhost:9092
```

## A envía varios mensajes al topic “ciudades”

```bash
# Enviamos mensajes
bin/kafka-console-producer.sh --broker-list 8.34.221.34:9092 --topic ciudades
```

## B apaga MV2

```bash
# Apagamos MV2
```

## A lee los mensajes de “ciudades” usando MV1

```bash
# Leemos los mensajes
bin/kafka-console-consumer.sh --bootstrap-server 35.240.103.2:9092 --topic ciudades --from-beginning
```
