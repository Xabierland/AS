#!/bin/bash

#Pedir tiempo de ejecucion por argumento
if [ $# -lt 1 ];
then
        echo "Introduce el tiempo de cada iteracion."
        exit 1
fi

#Numero de opciones
NUM=($(./FIRESTARTER --avail | tail -n 1 | awk '{print $1}'))
# Obtenemos las intrucciones validas de nuestro sistema
declare -a OPTIONS
OPTIONS=($(./FIRESTARTER --avail | awk '$5 == "yes" {print $1}' | tail -n $NUM))

for option in "${OPTIONS[@]}";
do
        echo "Corriendo opcion $option"
        ./FIRESTARTER -i $option -t $1 -r | grep "GFLOPS" | awk '{print $(NF-1), $NF}'
        echo
done