# EJ2

## Crear un indice "servidores" con la siguientes caracteristicas

* Campo "fabricante", tipo text
* Campo "nombre", tipo text
* Campo "precio", tipo float

```bash
curl -XPUT "localhost:9200/servidores?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "fabricante": {
        "type": "text"
      },
      "nombre": {
        "type": "text"
      },
      "precio": {
        "type": "float"
      }
    }
  }
}
'
```

## Crear un indice "logs" con las siguientes caracteristicas

* Campo "emisor", tipo text
* Campo "fecha", tipo data
* Campo "mensaje", tipo text

```bash
curl -XPUT "localhost:9200/logs?pretty" -H 'Content-Type: application/json' -d'
{
  "mappings": {
    "properties": {
      "emisor": {
        "type": "text"
      },
      "fecha": {
        "type": "date"
      },
      "mensaje": {
        "type": "text"
      }
    }
  }
}
'
```

## Añadir los siguientes documentos al indice "servidores"

| ID | Fabricante | Nombre | Precio |
| -- | ---------- | ------ | ------ |
| 1 | Dell | PowerEdge R6 | 4200.4 |
| 2 | Dell | PowerEdge R7 | 7200.7 |
| 3 | HP | ProLiant RL | 8110.2 |

```bash
curl -XPOST "localhost:9200/servidores/_doc/1?pretty" -H 'Content-Type: application/json' -d'
{
  "fabricante": "Dell",
  "nombre": "PowerEdge R6",
  "precio": 4200.4
}
'

curl -XPOST "localhost:9200/servidores/_doc/2?pretty" -H 'Content-Type: application/json' -d'
{
  "fabricante": "Dell",
  "nombre": "PowerEdge R7",
  "precio": 7200.7
}
'

curl -XPOST "localhost:9200/servidores/_doc/3?pretty" -H 'Content-Type: application/json' -d'
{
  "fabricante": "HP",
  "nombre": "ProLiant RL",
  "precio": 8110.2
}
'
```

## Añadir el documento "ej2_logs.json" al indice "logs"

```bash
curl -XPUT "localhost:9200/logs/_bulk" -H 'Content-Type: application/json' --data-binary "@ej2_logs.json"
```

## Realizar las siguientes busquedas en el indice "servidores"

* Obtener los datos de los servidores cuyo precio sea inferior a 8000

```bash
curl -XGET "localhost:9200/servidores/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "range": {
      "precio": {
        "lt": 8000
      }
    }
  }
}
'
```

* Obtener los datos de los servidores fabricados por Dell, pero usando "edll" como termino de busqueda

```bash
curl -XGET "localhost:9200/servidores/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "fuzzy": {
      "fabricante": "edll"
    }
  }
}
'
```

## Realizar las siguientes busquedas en el indice "logs"

* Obtener los atos de los mensajes de logs cuyo nombre de emisor acabe por "d".

```bash
curl -XGET "localhost:9200/logs/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "wildcard": {
      "emisor": "*d"
    }
  }
}
'
```

* Obtener todos los documentos ordenados por fecha de forma ascendente.

```bash
curl -XGET "localhost:9200/logs/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "sort": [
    {
      "fecha": {
        "order": "asc"
      }
    }
  ]
}
'
```

## En el indice "servidores" borrar los datos del documento cuyo fabricante es HP

```bash
curl -XDELETE "localhost:9200/servidores/_search?pretty" -H 'Content-Type: application/json' -d'
{
  "query": {
    "match": {
      "fabricante": "HP"
    }
  }
}
'
```
