# Laboratorio 6.- Ecosistema Docker

## Preparar el entorno

## Docker Compose

### Un fichero llamado “app.py” con el codigo Python incluido al final de esta sección. Este código crea un servidor web utilizando Flask que se conecta a Redis para leer y almacenar el número de visitas

```python
import time
import redis
from flask import Flask

app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)

def get_hit_count():
    retries = 5
    while True:
        try:
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)

@app.route('/')
def hello():
    count = get_hit_count()
    return 'Hola! Este sitio se ha visitado {} veces.\n'.format(count)
```

### Un fichero llamado “requirements.txt” dentro del directorio con 2 líneas: “flask” y “redis”

```txt
flask
redis
```

### Un fichero Dockerfile con las siguientes características

#### Imagen base: python:3.11-alpine

#### Establece como directorio de trabajo /code

#### Establece dos variables de entorno con los siguientes valores: FLASK_APP=app.py y FLASK_RUN_HOST=0.0.0.0

#### Ejecuta el siguiente comando para instalar dependencias: apk add --no-cache gcc musl-dev linux-headers

#### Copia el fichero requirements.txt dentro de /code

#### Ejecuta el siguiente comando para instalar dependencias: pip install -r requirements.txt

#### Copia el fichero app.py dentro de /code

#### Estable como comando de arranque “flask run”

```Dockerfile
FROM python:3.11-alpine
WORKDIR /code
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
RUN apk add --no-cache gcc musl-dev linux-headers
COPY requirements.txt /code
RUN pip install -r requirements.txt
COPY app.py /code
CMD flask run
```

### Un fichero YAML para Docker Compose con las siguientes características

#### Un servicio llamado “web”. Deberá crearse una imagen Docker usando el Dockerfile recién descrito. Redirigir el puerto 5000 del contenedor al puerto 80 del anfitrión

#### Un servicio llamado “redis”. Deberá obtener la imagen “redis:alpine” de Docker Hub

```yaml
version: "3"
services:
  web:
    build: .
    ports:
      - "80:5000"
  redis:
    image: redis:alpine
```

## Docker Hub

### Dirigir al portal de Docker Hub y crear una cuenta

### Crear un repositorio con nombre "as-laboratorio-6-web"

### En vuestra maquina virtual

#### Ejecutar “docker login --username <vuestro-Docker-ID>” para enlazar el cliente Docker con vuestro usuario en Docker Hub

#### Etiquetar la imagen utilizada como servidor web en la parte anterior del laboratorio como “vuestro-Docker-ID/as-laboratorio-6-web”

#### Utilizando “docker push”, subir la imagen a Docker Hub

```bash
docker login --username xabierland
docker image tag dockercompose-web xabierland/as-laboratorio-6-web
docker push xabierland/as-laboratorio-6-web
```

### Verificar en vuestro perfil de Docker Hub que la imagen se ha subido correctamente

### Buscar en DockerHub el tamaño que ocupa la imagen. ¿Coincide con lo que ocupa en vuestra máquina?

```txt
No, el tamaño en DockerHub es menor que en local porque parece que esta comprimida.
```

### Construcción automática de imágenes a partir de cambios en un repositorio de código. Esta funcionalidad sólo está disponible para usuarios de pago de Docker Hub

### Disparar eventos cuando se sube una nueva versión de una imagen utilizando WebHooks, llamadas HTTP que Docker Hub envía por nosotros a servicios Web de terceros

#### Entrar en https://script.google.com/

#### Crear el script

```javascript
function doPost(request)
{
  var postJSON = request.postData.getDataAsString();
  var payload = JSON.parse(postJSON);
  var tag = payload.push_data.tag;
  var reponame = payload.repository.repo_name;
  var dockerimagename = payload.repository.name;
  if(typeof request !== 'undefined')

  MailApp.sendEmail({
    to: "xabierland@gmail.com",
    subject: "Nueva imagen subida al repositorio "+reponame,
    htmlBody: "Hola,<br>"+
      "Se ha actualizado el repositorio Docker Hub: "+reponame+"<br>"+
      "<strong>Imagen: " + dockerimagename+"<br>"+
      "Version:" +tag+"<br></strong>"
    });
}
```

#### Implementar el Webhook

#### Añadirlo a Docker Hub

#### Hacer push de una nueva versión de la imagen
