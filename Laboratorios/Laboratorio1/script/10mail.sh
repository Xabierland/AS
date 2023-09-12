#! /bin/bash

lista=($(cat ./mail/nombres.txt))
echo $lista
num=1

for nombre in "${lista[@]}"
do
    cp ./mail/cuerpo.txt ./mail/mail$num.txt
    sed -i "s/NOMBRE/${nombre}/g" ./mail/mail$num.txt
    num=$(($num+1))
done