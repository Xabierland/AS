#! /bin/bash

a=$1
b=$2

function sumar
{
    res=$(($a+$b))
    echo $res
}

function restar
{
    res=$(($a-$b))
    echo $res
}

function multiplicar
{
    res=$(($a*$b))
    echo $res
}

function dividir
{
    res=$(($a/$b))
    echo $res
}

echo -e "\n==Lista de Operaciones=="
echo -e "1) Sumar"
echo -e "2) Restar"
echo -e "3) Multiplicar"
echo -e "4) Dividir"
read -p "Elige una opcion: " opcion

case $opcion in
1) sumar;;
2) restar;;
3) multiplicar;;
4) dividir;;
*) exit 0
esac


