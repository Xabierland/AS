#! /bin/bash

if [ ! -d cosas ]; then
    mkdir -p cosas
fi

numero=1

while [ $numero -le 100 ]
do
    man ls | sed -n "${numero}p" > cosas/fich$numero.txt
    numero=$((numero + 1))
done