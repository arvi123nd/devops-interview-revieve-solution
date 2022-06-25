#!/bin/bash
# Script used to create the following three reports:
# - order_prices.csv
# - product_customers.csv
# - customer_ranking.csv

#Removing carriage return from the files
cd reports_in
echo "Preparing files"
dos2unix customers.csv 2>/dev/null
dos2unix orders.csv 2>/dev/null
dos2unix products.csv 2>/dev/null
echo "Done preparing files"

#Create folder "reports_out" in case is necessary
cd ..
[ -d reports_out ] || mkdir reports_out 

#Executing the scripts to produce the reports
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