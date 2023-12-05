# Laboratorio 11.- Pila ELK

## Preparar el entorno

### Levantar el ELK

```bash
docker compose up -d
```

## Analisis de logs conectando con Syslog

> En este laboratorio se dice de usar una maquina virtual con Ubuntu, en mi caso, voy a usar WSL2 por lo que si tu, estas usando una instancia de GCP o una VM Local esto puede variar

### Configurar logstash

```bash
input{
    syslog{
        port => 10500
    }
}
filter{
    grok{
    filter{
        grok{
            match => { "message" => "%{MONTH:mes} %{MONTHDAY:dia} %{TIME:hora} %{DATA:maquina} %{DATA:programa} %{GREEDYDATA:servicio} %{GREEDYDATA:mensaje}" }
        }
    }
    }
}
output{
    elasticsearch{
        hosts => ["http://localhost:5601"]
    }
    stdout{}
}
```

### Configurar el Syslog

```bash

```

## Analisis de logs usando Beats
