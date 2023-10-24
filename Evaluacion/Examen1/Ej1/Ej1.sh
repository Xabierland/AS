read -p "Introduce el nombre de un fichero: " fichero

if [ -f $fichero ]; then
    for linea in $(cat $fichero); do
        if [ $(grep $linea /etc/passwd | wc -l) -eq 1 ]; then
            echo "El usuario $linea existe"
        else
            echo "El usuario $linea no existe"
        fi
    done
else
    echo "Fichero inexistente"
    ln -s /tmp -t $HOME
fi
