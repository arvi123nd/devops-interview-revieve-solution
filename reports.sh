#!/bin/bash



#id,customer,products

cd scritps
echo "##################"
echo "Start First report"
bash ./01_order_prices.sh
echo "Finish First report"
echo "##################"
echo "Start Second report"
bash ./02_product_customers.sh
echo "Finish Second report"
echo "##################"
echo "Start Third report"
bash ./03_customer_ranking.sh
echo "Finish Third report"
echo "##################"
echo "All reports are done"