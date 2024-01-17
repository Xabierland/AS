while read line; do
    curl -XPOST -H "Content-Type: application/json" -d "$line" http://localhost:7000
    sleep 1
done < ej3_logs.txt