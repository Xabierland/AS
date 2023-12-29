<!-- markdownlint-disable MD024 -->
# Ejercicio 2

## Crear un indice "usuarios" con las siguientes caracteristicas

* Campo "nombre", tipo text
* Campo "apellido", tipo text
* Campo "edad", tipo integer

### Solución

```bash
curl -X PUT "localhost:9200/usuarios?pretty" -H 'Content-Type: application/json' -d
'
{
  "mappings": {
    "properties": {
      "nombre": {
        "type": "text"
      },
      "apellido": {
        "type": "text"
      },
      "edad": {
        "type": "integer"
      }
    }
  }
}
'
```

## Añadir los siguientes elementos al indice

| ID | Nombre | Apellido | Edad (años) |
|----|--------|----------|-------------|
| 10 | Jon    | Blanco   | 27          |
| 11 | Amaia  | Lopez    | 28          |
| 12 | Hodei  | Bilbao   | 33          |

### Solución

```bash
curl -X POST "localhost:9200/usuarios/_doc/10?pretty" -H 'Content-Type: application/json' -d
'
{
  "nombre": "Jon",
  "apellido": "Blanco",
  "edad": 27
}
'

curl -X POST "localhost:9200/usuarios/_doc/11?pretty" -H 'Content-Type: application/json' -d
'
{
  "nombre": "Amaia",
  "apellido": "Lopez",
  "edad": 28
}
'

curl -X POST "localhost:9200/usuarios/_doc/12?pretty" -H 'Content-Type: application/json' -d
'
{
  "nombre": "Hodei",
  "apellido": "Bilbao",
  "edad": 33
}
'
```

## Realizar las siguientes búsquedas

* Obtener los datos de los usuarios cuyo apellido empiece por la letra B
* Recuperar los datos de "Amaia Lopez", pero utilizando "Loepz" como termino de busqueda

### Solución

```bash
curl -X GET "localhost:9200/usuarios/_search?pretty" -H 'Content-Type: application/json' -d
'
{
  "query": {
    "prefix": {
      "apellido": "B"
    }
  }
}
'

curl -X GET "localhost:9200/usuarios/_search?pretty" -H 'Content-Type: application/json' -d
'
{
  "query": {
    "match": {
      "apellido": "Loepz"
    }
  }
}
'
```
