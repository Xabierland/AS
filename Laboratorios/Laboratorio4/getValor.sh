#!/bin/bash

# Realiza la solicitud curl en segundo plano y guarda la respuesta en un archivo temporal
curl -s "https://api.currencyapi.com/v3/latest?base_currency=EUR&currencies=GBP&apikey=cur_live_sEsZ8lBNVxfK9E2dr3LbVlGmdk57s0qgy70n3rGk" > respuesta.json &
# Espera a que la solicitud curl se complete
wait

# Verifica si la solicitud fue exitosa (código de estado HTTP 200)
if [ $? -eq 0 ]; then
    # Analiza el archivo JSON usando jq y guarda el resultado en la variable mensaje
    mensaje=$(jq -r '.data.GBP.value' respuesta.json)

    # Imprime el valor deseado
    mosquitto_pub -h $IPmv2 -t "divisa" -m "$mensaje"
else
    echo "La solicitud curl no se completó correctamente."
fi

# Limpia el archivo temporal
rm respuesta.json