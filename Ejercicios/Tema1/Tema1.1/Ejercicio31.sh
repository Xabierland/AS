for file in /tmp/*; do
    echo "$file"
done

if [ -z /tmp/* ]
then
    echo "Creando vacio.txt"
    touch vacio.txt
else
    echo "No vacio"
fi