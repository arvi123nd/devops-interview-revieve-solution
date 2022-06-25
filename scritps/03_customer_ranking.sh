#!/bin/bash
# Create the report `customer_ranking.csv` containing the following columns, ranked in descending order by total_euros:
# * `id` numeric id of the customer
# * `firstname` customer first name
# * `lastname` customer last name
# * `total_euros` total euros this customer has spent on products

OLDIFS=$IFS

#Put the customer ids and the order id related in a associate array "orders"
while IFS="," read -r oid cid products; do
    #echo "$id $name $cost"
    declare -A orders
    orders[$cid]="$oid"
#done < <(tail -n +2 ../reports_in/orders.csv | head -n 3)
done < <(tail -n +2 ../reports_in/orders.csv )
IFS=$OLDIFS

#Put the orders ids and total_cost of the order in a associate array "ord_prices"
while IFS="," read -r oid euros; do
    declare -A ord_prices
    ord_prices[$oid]="$euros"
#done < <(tail -n +2 ../reports_out/order_prices.csv | head -n 3)
done < <(tail -n +2 ../reports_out/order_prices.csv )
IFS=$OLDIFS

#Create a temporal file to get the data of the report
touch ../reports_out/customer_ranking_tmp.csv

#Check all the customer in "customers.csv" file
while IFS="," read -r cid firstname lastname; do
    #Get the order id of a customer from the associate array "orders"
    cust_ord="${orders[$cid]}"
    #Some customers don't have orders
    if [ -z "$cust_ord" ]; then
        echo "$cid,$firstname,$lastname," >> ../reports_out/customer_ranking_tmp.csv
    else
        #Get the cost of that specfic order id from the associate array "ord_prices"
        echo "$cid,$firstname,$lastname,${ord_prices[$cust_ord]}"  >> ../reports_out/customer_ranking_tmp.csv
    fi
#done < <(tail -n +2 ../reports_in/customers.csv | head -n 3)
done < <(tail -n +2 ../reports_in/customers.csv )

#Create the top of the final report
touch ../reports_out/customer_ranking.csv
echo "id,firstname,lastname,total_euros" > ../reports_out/customer_ranking.csv
#Sort the temporal report putting the biggest amount of total_cost at the top and sending the result to the final report
sort  -r -t ',' -k4 -g ../reports_out/customer_ranking_tmp.csv >> ../reports_out/customer_ranking.csv
rm -rf ../reports_out/customer_ranking_tmp.csv
IFS=$OLDIFS