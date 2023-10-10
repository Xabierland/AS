# Ejercicio 2

## B prepara las MV1 y MV2 con Zookeeper y 2 Brokers

### MV1

```bash
# Iniciamos Zookeeper
bin/zookeeper-server-start.sh config/zookeeper.properties

# Configuramos el broker
nano config/server.properties

# Iniciamos el broker
bin/kafka-server-start.sh config/server.properties
```

### MV2

```bash
# Configuramos el broker
nano config/server.properties

# Iniciamos el broker
bin/kafka-server-start.sh config/server.properties
```

## B crea un topic “ciudades” con factor de replicación 2

```bash
# Creamos el topic
bin/kafka-topics.sh --create --zookeeper $MV1IP:2181 --replication-factor 2 --partitions 1 --topic ciudades
```

## A envía varios mensajes al topic “ciudades”

```bash
# Enviamos mensajes
bin/kafka-console-producer.sh --broker-list $MV2IP:9092 --topic ciudades
```

## B apaga MV2

```bash
# Apagamos MV2
```

## A lee los mensajes de “ciudades” usando MV1

```bash
# Leemos los mensajes
bin/kafka-console-consumer.sh --bootstrap-server $MV1IP:9092 --topic ciudades --from-beginning
```
