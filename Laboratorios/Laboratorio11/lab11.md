# Laboratorio 11.- Pila ELK

## Preparar el entorno

### Levantar el ELK

```bash
docker compose up -d
```

## Analisis de logs conectando con Syslog

### Configurar logstash

```bash
sudo nano logstash.conf
    input{
        tcp{
            port => 10500
        }
    }
    filter{
        grok{
            match => { "message" => "%{MONTH:mes} %{MONTHDAY:dia} %{TIME:hora} %{DATA:maquina} %{DATA:programa} %{GREEDYDATA:servicio} %{GREEDYDATA:mensaje}" }
        }
    }
    output{
        elasticsearch{
            hosts => ["http://elasticsearch:9200"]
            index => "logs-sistema"
        }
    }
```

### Configurar el Syslog

```bash
sudo nano /etc/rsyslog.d/50-default.conf        #Editamos el fichero de logs
        *.*                             @localhost:10500
sudo systemctl restart rsyslog.service          #Aplicamos los cambios
```

```bash
docker compose up -d                            #Levantamos el contenedor de logstash

logger "Hola mundo"                             #Generamos un log

curl -X GET "localhost:9200/logs-sistema/_search?pretty"
```

## Analisis de logs usando Beats

### Filebeat

```bash
# Descargar Filebeat
curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-8.11.1-amd64.deb

# Instalar Filebeat
sudo dpkg -i filebeat-8.11.1-amd64.deb

# Configurar Filebeat
sudo nano /etc/filebeat/filebeat.yml

sudo filebeat modules list

sudo filebeat modules enable system

# Configurar system.yml
sudo nano /etc/filebeat/modules.d/system.yml

# Iniciar Filebeat
sudo service filebeat start
```

### Logstash

```bash
# Editar el fichero de configuracion
sudo nano logstash.conf
    input{
        beats{
            port => 5044
        }
    }
    output{
        elasticsearch{
            hosts => ["http://elasticsearch:9200"]
            index => "logs-filebeat"
        }
    }

# Editar docker-compose.yml
sudo nano docker-compose.yml
    version: '3'
    services:
        logstash:
            image: docker.elastic.co/logstash/logstash:8.11.1
            container_name: logstash
            volumes:
            - ./pipeline:/usr/share/logstash/pipeline
            depends_on:
            - elasticsearch
            ports:
            - 5044:5044

        elasticsearch:
            image: docker.elastic.co/elasticsearch/elasticsearch:8.11.1
            container_name: elasticsearch
            environment:
            - discovery.type=single-node
            - xpack.security.enabled=false
            volumes:
            - data01:/usr/share/elasticsearch/data
            ports:
            - 9200:9200
            - 9300:9300

        kibana:
            image: docker.elastic.co/kibana/kibana:8.11.1
            container_name: kibana
            ports:
            - 80:5601
            depends_on:
            - elasticsearch
    volumes:
        data01:
```
