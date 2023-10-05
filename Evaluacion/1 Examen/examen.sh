#! /bin/bash

# Definimos el nombre del zip
zip=79046036_Xabier_Gabina.tar.gz

# Soy consciente de que deberia usar el $HOME en muchos casos pero para evitar el uso sin cabeza de este script he preferio el direccionamiento absoluto :)

function iniciar_examen
{
        # Realizamos una copia de seguridad del bash por si las moscas
        cp /home/xabier/.bash_history /home/xabier/.bash_history_cp
        sudo cp /root/.bash_history /root/.bash_history_cp

        # Borramos la basura antigua del .bash_history
        echo "====Iniciando Examen====" > /home/xabier/.bash_history
        sudo echo "====Iniciando Examen====" > /root/.bash_history
}

function entregar_examen
{
        # Copiamos el historial de bash
        cp /home/xabier/.bash_history /home/xabier/examen/xabier_history
        sudo cp /root/.bash_history /home/xabier/examen/root_history
        sudo chown xabier:xabier /home/xabier/examen/root_history       #Si no, el tar no lo incluira al no poder leerlo

        # Creamos el tar.gz
        tar -czvf /home/xabier/$zip -C /home/xabier/ examen/

        # Movemos el tar.gz al servidor apache
        sudo mv /home/xabier/$zip /var/www/html
}

function comprobar_entrega
{
        # Comprobamos que el archivo existe
        ls -l /var/www/html/$zip
        echo ""

        # Comprobamos que el contenido es el correcto
        tar -ztvf /var/www/html/$zip
}

function salir
{
        exit 0
}

###* Main *###
opcion=0
while test $opcion -ne 4
do
        #Menu
        echo -e "\n==== MENU DE EXAMEN===="
        echo -e "01) Iniciar examen"
        echo -e "02) Entregar examen"
        echo -e "03) Comprobar entrega"
        echo -e "00) Salir\n"
        read -p "Elige una opcion: " opcion
        echo ""
                case $opcion in
                1) iniciar_examen;;
                2) entregar_examen;;
                3) comprobar_entrega;;
                *) salir;;
                esac
done