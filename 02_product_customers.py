"""Task2 - Product Customers
The marketing department wants to know which customers are interested in each product; they've asked for a `product_customers.csv` file that, for each product, gives the list of customers who have purchased this product:
* `id` numeric product id
* `customer_ids` a space-separated list of customer ids of the customers who have purchased this product
"""
import csv
# pylint: disable=W0312
# pylint: disable=C0103

ORDERS_IN = 'reports_in/orders.csv'
PRODUCT_CUSTOMERS_OUT = 'reports_out/product_customers.csv'

product_customers = {}

#Read the orders from CSV
with open(ORDERS_IN, newline='') as csvfile:

	#Open the CSV file to write the results
    orders = csv.reader(csvfile, delimiter=',')

	#Skip the header while reading
    next(orders)

    for row in orders:
    	#Get the product IDs
    	productIds = row[2].split(" ")
    	customerId = row[1]

    	#Loop through product ids
    	for productId in productIds:
    		if product_customers.get(productId) is None:
    			product_customers[productId] = []

    		if (customerId in product_customers[productId]) is False:
    			product_customers[productId].append(customerId)


with open(PRODUCT_CUSTOMERS_OUT, 'w') as f:
	writer = csv.writer(f)

	#Write the header
	writer.writerow(['id', 'customer_ids'])
	sort_orders = sorted(product_customers.items(), key=lambda x: x[0], reverse=False)
	for key, value in sort_orders:
		writer.writerow([key, " ".join(value)])
