#!/bin/bash

OLDIFS=$IFS

touch ../reports_out/product_customers.csv
echo "id,customer_ids" > ../reports_out/product_customers.csv

while IFS="," read -r idp name cost; do
    echo "$idp $name $cost"
    #declare -A arrcost
    #arrcost[$idp]="$cost"
    #echo "The price of $name is ${arrcost[$idp]}"
    clients=""

    while IFS="," read -r idc customer products; do
        #echo "Lista de productos $products"
        if [[ $products == *"$idp"* ]];then
            echo "$idc,$customer,$products"
            clients=( "$clients$customer " )
        fi
        #declare -A arrcost
        #arrcost[$id]="$cost"
        #echo "The price of $name is ${arrcost[$id]}"
    #done < <(tail -n +2 ../reports_in/orders.csv | head -n 5)
    done < <(tail -n +2 ../reports_in/orders.csv )

    echo "Cliente intersado en $idp"
    echo "Cliente totales $clients"
    echo "$idp,$clients" >> ../reports_out/product_customers.csv
#done < <(tail -n +2 ../reports_in/products.csv | head -n 3)
done < <(tail -n +2 ../reports_in/products.csv )
IFS=$OLDIFS

echo "Cuantos productos son ${#arrcost[@]}"
