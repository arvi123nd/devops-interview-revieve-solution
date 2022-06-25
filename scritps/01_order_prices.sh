#!/bin/bash
# Create the report `order_prices.csv` with the following columns:
# * `id` the numeric id of the order
# * `euros` the total cost of the order

OLDIFS=$IFS
#Put the id and cost of a product in a associate array "prodcost"
while IFS="," read -r prod_id name cost; do
    declare -A prodcost
    prodcost[$prod_id]="$cost"
#done < <(tail -n +2 ../reports_in/products.csv | head -n 3)
done < <(tail -n +2 ../reports_in/products.csv )
IFS=$OLDIFS

#Create the top of the report
touch ../reports_out/order_prices.csv
echo "id,euros" > ../reports_out/order_prices.csv

#Gets the total price of the order
while IFS="," read -r id customer products; do
    # The products ids are added in an array,helps to separate each product requested
    IFS=' ' read -a prod_arr <<< "$products"
    sum=0
    #Gets the prices of the products from the associate array "prodcost" and sum them
    for i in "${prod_arr[@]}"; do     
        sum=$(echo "$sum + ${prodcost[$i]}" | bc)
    done
    #Add the result top the reports
    echo "$id,$sum" >> ../reports_out/order_prices.csv
#done < <(tail -n +2 ../reports_in/orders.csv | head -n 10)
done < <(tail -n +2 ../reports_in/orders.csv )
IFS=$OLDIFS

#Removing Associative Array
unset prodcost