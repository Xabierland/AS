# Ejercicio 1

## B crea un topic llamado “colores” y se conecta a él.

```bash
# Iniciamos el zookeeper
bin/zookeeper-server-start.sh config/zookeeper.properties &

# Configuramos el server.properties
nano config/server.properties


# Iniciamos el broker
bin/kafka-server-start.sh config/server.properties

# Creamos el topic
bin/kafka-topics.sh --create --topic colores --bootstrap-server localhost:9092

# Nos conectamos al topic
bin/kafka-console-consumer.sh --topic colores --from-beginning --bootstrap-server localhost:9092
```

## A envía mensajes “verde” y “azul” al topic

```bash
bin/kafka-console-producer.sh --topic colores --bootstrap-server localhost:9092
> verde
> azul
```

## B se desconecta del topic.

```bash
# Presionamos Ctrl + C
```

## A envía mensajes “amarillo” y ”naranja” al topic

```bash
bin/kafka-console-producer.sh --topic colores --bootstrap-server localhost:9092
> amarillo
> naranja
```

## B se conecta al topic. Debe recibir todos los mensajes

```bash
bin/kafka-console-consumer.sh --topic colores --from-beginning --bootstrap-server localhost:9092
```