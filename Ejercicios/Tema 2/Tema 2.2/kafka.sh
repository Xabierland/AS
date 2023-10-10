#! /bin/bash

function iniciar_zookeeper
{
    sh bin/zookeeper-server-start.sh config/zookeeper.properties &> logs/zookeeper.log &
}

function configurar_kafka
{
    sudo nano config/server.properties
}

function iniciar_broker
{
    sh bin/kafka-server-start.sh config/server.properties &> logs/kafka.log &
}

function crear_topic
{
    read -p "Introduce el nombre del topic: " topic
    sh bin/kafka-topics.sh --create --topic $topic --bootstrap-server localhost:9092
}

function listar_topics
{
    sh bin/kafka-topics.sh --list --bootstrap-server localhost:9092
}

function ver_topic
{
    read -p "Introduce el nombre del topic: " topic
    sh bin/kafka-console-consumer.sh --topic $topic --from-beginning --bootstrap-server localhost:9092
}

function enviar_mensaje
{
    read -p "Introduce el nombre del topic: " topic
    sh bin/kafka-console-producer.sh --topic $topic --bootstrap-server localhost:9092
}


function salir
{
    killall java
    exit 0
}

###* Main *###
opcion=0
while test $opcion -ne 8
do
        #Menu
        echo -e "\n==== MENU DE KAFKA===="
        echo -e "01) Iniciar Zookeeper"
        echo -e "02) Configurar Kafka"
        echo -e "03) Iniciar Broker"
        echo -e "04) Crear Topic"
        echo -e "05) Listar Topics"
        echo -e "06) Ver Topic"
        echo -e "07) Enviar Mensaje"
        echo -e "00) Salir\n"
        read -p "Elige una opcion: " opcion
        echo ""
                case $opcion in
                1) iniciar_zookeeper;;
                2) configurar_kafka;;
                3) iniciar_broker;;
                4) crear_topic;;
                5) listar_topics;;
                6) ver_topic;;
                7) enviar_mensaje;;
                *) salir;;
                esac
done