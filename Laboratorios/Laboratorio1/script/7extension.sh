#! /bin/bash

lista=$(ls *.txt)

for file in $lista;
do
    nombre=$(basename "$file" .txt)
    cp $file $nombre.t
    rm $file
done