#!/bin/bash
# Create the report `product_customers.csv` file that, for each product, gives the list of customers who have purchased this product:
# * `id` numeric product id
# * `customer_ids` a space-separated list of customer ids of the customers who have purchased this product

OLDIFS=$IFS

#Create the top of the report
touch ../reports_out/product_customers.csv
echo "id,customer_ids" > ../reports_out/product_customers.csv

#Get all the ids of the products
while IFS="," read -r idprod name cost; do
    clients=""
    #Check the order of all the customers, if the customer have that product in his order is included in the list
    while IFS="," read -r idc customer products; do
        if [[ $products == *"$idprod"* ]];then
            clients=( "$clients$customer " )
        fi
    #done < <(tail -n +2 ../reports_in/orders.csv | head -n 5)
    done < <(tail -n +2 ../reports_in/orders.csv )
    
    #Send the product id and the customers list that have it to the report
    echo "$idprod,$clients" >> ../reports_out/product_customers.csv

#done < <(tail -n +2 ../reports_in/products.csv | head -n 3)
done < <(tail -n +2 ../reports_in/products.csv )

IFS=$OLDIFS
