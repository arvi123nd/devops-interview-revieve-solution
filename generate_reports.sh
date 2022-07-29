#!/bin/bash
# Python Scripts used to create the following three reports:
# - order_prices.csv
# - product_customers.csv
# - customer_ranking.csv

# Removing carriage return from the files
cd reports_in
echo "Preparing input files"
dos2unix customers.csv 2>/dev/null
dos2unix orders.csv 2>/dev/null
dos2unix products.csv 2>/dev/null
echo "Done preparing files"

#Create output folder "reports_out" if it doesn't exists
cd ..
[ -d reports_out ] || mkdir reports_out

#Executing the python scripts to produce the reports
echo "##################"
echo "Start Task 1 report"
python ./01_orderPrices.py
echo "Task 1 report done"
echo "##################"
echo "Start Task 2 report"
python ./02_productCustomers.py
echo "Task 2 report done"
echo "##################"
echo "Start Task 3 report"
python ./03_customerRanking.py
echo "Task 3 report done"
echo "##################"
echo "All reports are done"