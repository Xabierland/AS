# Laboratorio 11.- Pila ELK

## Preparar el entorno

### Levantar el ELK

```bash
docker compose up -d
```

## Analisis de logs conectando con Syslog

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
