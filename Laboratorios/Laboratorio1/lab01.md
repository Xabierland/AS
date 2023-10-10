# Laboratorio 1.- Administracion Linux y Shell Scripting

## 1 Linea de comandos

### 1.1 Utilizando el manual del sistema

### 1.2 Gestion y manipulacion de archivos

1) Crear una carpeta llamada AS en vuestro directorio raiz de usuario.

``` bash
cd ~
mkdir AS
```

2) Entrar dentro de la carpeta y comprobar que el directorio coincide con el contenido de la variable de entorno PWD.

``` bash
cd AS
echo $PWD
```

3) Instalar cal con el comando apt install ncal. Utilizar cal para mostrar un calendario y redirigir la salida a un fichero de texto. Comprobar que ese fichero se crea correctamente y que su contenido es el esperado.

``` bash
sudo apt install ncal
cal > cal.txt
cat cal.txt
```

4) Copiar el fichero recién creado al directorio raíz del usuario.

``` bash
cp cal.txt ~
```

5) Moverse al directorio raíz del usuario y listar en formato extendido (parámetro -l) los directorios y archivos presentes. Redirigir esa información a un fichero.

``` bash
cd ~
ls -l
ls -l > files.txt
```

6) Listar los 5 ficheros más nuevos de la carpeta /etc (que no sean carpetas).

``` bash
ls -tp /etc | grep -v /$ | head -5
```

7) Cambiar los permisos del fichero creado con información del calendario para que sólo el usuario propietario tenga capacidad de leer y escribir.

``` bash
chmod 600 cal.txt
ls -l
total 4
-rw------- 1 xabierland xabierland 188 Sep 12 11:08 cal.txt
```

8) Cambiar permisos para evitar que ningún otro usuario pueda acceder nuestro directorio raíz.

``` bash
chmod -R o-rwx $HOME
chmod -R g-rwx $HOME
```

9) Comprobar cuántos usuarios hay en el sistema y cual es el nuestro Shell de inicio.

``` bash
wc -l /etc/passwd #Numero de usuarios del sistema
grep "$USER" /etc/passwd | cut -d ":" -f 7
```

10) Comprobar cuándo y desde donde accediste la última vez al sistema.

``` bash
last
```

11) Comprimir en un archivo .tar.gz los contenidos del directorio $HOME. Descomprimirlos /tmp y comprobar que se ha hecho correctamente.

``` bash
tar -czvf home.tar.gz $HOME
tar -xzvf home.tar.gz /tmp
```

12) Como usuario “root”, buscar todos los archivos que sean propiedad de tu usuario en el sistema (desde el directorio raíz /) y listarlos en forma extendida (con toda la información).

``` bash
sudo find / -type f -user xabierland
```

13) Como usuario “root”, mostrar las últimas 30 líneas de /var/log/syslog.

``` bash
sudo tail -n 30 /var/log/syslog
```

## 2 Shell Scripting

1) Crear un script llamado lsdirs.sh que muestre los directorios contenidos en el directorio actual.
2) Crear un script llamado see.sh que reciba un nombre de fichero/directorio como parámetro. Si el nombre
corresponde a un fichero, el script muestra el contenido del fichero con more, sino muestra el contenido del
directorio con ls.
3) Crear un script que pida al usuario que teclee una palabra y escriba por pantalla el número de caracteres de
esa palabra.
4) Crear un script que pida al usuario que teclee una palabra y compruebe si es un comando del sistema o no.
5) Crear un script que cree una carpeta llamada cosas y después cree 100 ficheros vacíos llamados
fich<numero>.txt dentro de ella, donde <numero> es un número entre 0 y 99.
6) Extender el script anterior para que cada fichero contenga la N-sima línea delmanual de ls (man ls). El fichero
fich0.txt tendrá la línea 0 del manual, fich1.txt tendrá la línea 1 del manual, …
7) Crear un script que modifique la extensión de todos los ficheros .txt de un directorio a .t.
8) Crear un script borra.sh que reciba un número indefinido de parámetros (de 0 a 9) y borre el fichero
correspondiente a la suma del valor de los parámetros que reciba. Por ejemplo, borra.sh 1 4 5 9, borraría el
fichero fich19.txt (1 + 4 + 5 + 9 = 19).
9) Crear un script orden.sh que muestre el contenido del fichero /etc/passwd ordenado por nombre de usuario, UID o GID. El script recibirá un parámetro que indique cuál de los 3 utilizar como clave de ordenación.
10) Imagina que quieres mandar un e-mail con el mismo cuerpo a varios destinatarios, pero personalizando la
primera línea con el nombre de cada uno. Crear un fichero cuerpo.txt con el texto del cuerpo del e-mail y la palabra NOMBRE en cada lugar donde querrías poner el nombre, y un fichero nombres.txt con varios nombres personales. Crear un script que genere varios ficheros con el cuerpo del e-mail personalizado para cada destinatario.
