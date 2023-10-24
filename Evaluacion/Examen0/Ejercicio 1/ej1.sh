#! /bin/bash

# Escriba el mensaje “Introduce un número entre 1 y 10”
# Recoja un número escrito por el usuario a través del teclado. No hace falta comprobar que sea un valor válido.
read -p "Introduce un número entre 1 y 10: " num

# Cree una carpeta llamada “ficheros” dentro la carpeta $HOME de vuestro usuario.
mkdir -p $HOME/ficheros

# Dentro de la carpeta “ficheros”, cree tantos ficheros como el número introducido por el usuario. El nombre de cada fichero será “fich_N”, donde N será un número de 1 al número introducido por el usuario, p.e. fich_1, fich_2, …
#Si el número introducido por el usuario está entre 1 y 5, cada fichero nuevo contendrá la palabra “coche”. Si el número está entre 6 y 10, escribe la palabra “casa”.
for i in $(seq 1 $num)
do
    touch $HOME/ficheros/fich_$i
    if [ $i -le 5 ]
    then
        echo "coche" > $HOME/ficheros/fich_$i
    else
        echo "casa" > $HOME/ficheros/fich_$i
    fi
done



