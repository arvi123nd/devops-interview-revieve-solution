#!/bin/bash

OLDIFS=$IFS


while IFS="," read -r id name cost; do
    #echo "$id $name $cost"
    declare -A prodc
    prodc[$id]="$cost"
    echo "The price of $name is ${prodc[$id]}"
#done < <(tail -n +2 ../reports_in/products.csv | head -n 3)
done < <(tail -n +2 ../reports_in/products.csv )
IFS=$OLDIFS


touch ../reports_out/order_prices.csv
echo "id,euros" > ../reports_out/order_prices.csv





while IFS="," read -r id customer products; do
    products=$products
    #echo "$id,$products"
    prod=$( echo "$products")
    IFS=' ' read -a array <<< "$prod"
    #IFS=","    
    #declare -i sum
    sum=0
    addm=0
    #echo "El conjunto ${array[@]}"
    #echo "Numero de elmentos ${#array[@]}"    
    #for i in $(seq 0 "${#array[@]}"); do 
    for i in "${array[@]}"; do     
        #echo "antes error"     
        #sum=$(echo $(( sum + i )))
        #sum=$( echo "$sum + ${array[$i]}" | bc )
        #echo "Precio a agregar $i precio ${prodc[$i]}" 
        sum=$(echo "$sum + ${prodc[$i]}" | bc)
        #echo "Valor a agregar ${prodc[${array[$i]}]} y mas $sum" 
        #echo "La suma $sum" 
        #echo "despues error"   
    done
    #echo "llega"
    echo "$id,$sum" >> ../reports_out/order_prices.csv
    #suma= $( echo "$sum" | bc )
    #printf "La suma $suma \n"

#done < <(tail -n +2 ../reports_in/orders.csv | head -n 10)
done < <(tail -n +2 ../reports_in/orders.csv )
IFS=$OLDIFS