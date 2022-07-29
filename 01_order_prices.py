"""Task 1 - Order Prices
Right now the `orders.csv` doesn't have total order cost information.

We need to use the data in these files to emit a `order_prices.csv` file with the following columns:
* `id` the numeric id of the order
* `euros` the total cost of the order
"""
import csv
# pylint: disable=W0312
# pylint: disable=C0103

PRODUCTS_IN = 'reports_in/products.csv'
CUSTOMERS_IN = 'reports_in/customers.csv'
ORDERS_IN = 'reports_in/orders.csv'
ORDER_PRICES_OUT = 'reports_out/orders_prices.csv'

products = {}
# Read the products from CSV and make it a dictionary
with open(PRODUCTS_IN, newline='') as csvfile:
	productsData = csv.reader(csvfile, delimiter=',')
	next(productsData)
	i = 0
	for row in productsData:
		products[row[0]] = row

#Read the orders from CSV
with open(ORDERS_IN, newline='') as csvfile:
	#Open the CSV file to write the results
	with open(ORDER_PRICES_OUT, 'w') as f:
	    writer = csv.writer(f)
	    #Write the header
	    writer.writerow(['id', 'euros'])
	    orders = csv.reader(csvfile, delimiter=',')

	    #Skip the header while reading
	    next(orders)

	    for row in orders:
	    	#Get the product IDs
	    	productIds = row[2].split(" ")
	    	totalPrice = 0.0

	    	#Loop through products and add the price
	    	for productId in productIds:
	    		totalPrice = totalPrice + float(products[productId][2])

	    	writer.writerow([row[0], str(totalPrice)])
