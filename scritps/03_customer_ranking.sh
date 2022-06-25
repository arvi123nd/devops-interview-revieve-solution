#!/bin/bash

OLDIFS=$IFS

#id,customer,products

while IFS="," read -r id cid products; do
    #echo "$id $name $cost"
    declare -A orders
    orders[$cid]="$id"
    echo "The order of $cid is ${orders[$cid]}"
#done < <(tail -n +2 ../reports_in/orders.csv | head -n 3)
done < <(tail -n +2 ../reports_in/orders.csv )
IFS=$OLDIFS


while IFS="," read -r id euros; do
    #echo "$id $euros"
    declare -A cprices
    cprices[$id]="$euros"
    echo "The total amount of $id is ${cprices[$id]}"
#done < <(tail -n +2 ../reports_out/order_prices.csv | head -n 3)
done < <(tail -n +2 ../reports_out/order_prices.csv )
IFS=$OLDIFS

touch ../reports_out/customer_ranking_tmp.csv
echo "" > ../reports_out/customer_ranking_tmp.csv
#echo "id,customer_ids" > ../reports_out/customer_ranking.csv


while IFS="," read -r cid firstname lastname; do
    co="${orders[$cid]}"
    #echo "Lo orden $co"
    if [ -z "$co" ]; then
        echo "$cid,$firstname,$lastname," >> ../reports_out/customer_ranking_tmp.csv
    else
        echo "$cid,$firstname,$lastname,${cprices[$co]}"  >> ../reports_out/customer_ranking_tmp.csv
    fi


#done < <(tail -n +2 ../reports_in/customers.csv | head -n 3)
done < <(tail -n +2 ../reports_in/customers.csv )

touch ../reports_out/customer_ranking.csv
echo "id,firstname,lastname,total_euros" > ../reports_out/customer_ranking.csv
sort  -r -t ',' -k4 -g ../reports_out/customer_ranking_tmp.csv >> ../reports_out/customer_ranking.csv

IFS=$OLDIFS

rm -rf ../reports_out/customer_ranking_tmp.csv