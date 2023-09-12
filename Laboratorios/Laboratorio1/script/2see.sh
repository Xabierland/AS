#! /bin/bash

nombre=$1

if [ -a $nombre ] 
then
    more $nombre
else
    ls
fi