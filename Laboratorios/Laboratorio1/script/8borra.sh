#! /bin/bash

lista=$(echo $*)

for i in $lista;
do
    sum=$(($sum+$i))
done
rm ./cosas/fich$sum.txt