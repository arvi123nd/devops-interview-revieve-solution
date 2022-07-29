"""Task 3 - Customer Ranking
To evaluate our customers, we need a `customer_ranking.csv` containing the following columns, ranked in descending order by total_euros:
* `id` numeric id of the customer
* `firstname` customer first name
* `lastname` customer last name
* `total_euros` total euros this customer has spent on products
"""
import os
import csv
import pandas as pd

# pylint: disable=W0312
# pylint: disable=C0103

PRODUCTS_IN = 'reports_in/products.csv'
CUSTOMERS_IN = 'reports_in/customers.csv'
ORDERS_IN = 'reports_in/orders.csv'
ORDERS_TEMP = 'reports_in/orders_new.csv'
CUST_RANKING_OUT = 'reports_out/customer_ranking.csv'

products = {}

# Read the products from CSV and make it a dictionary
with open(PRODUCTS_IN, newline='') as csvfile:
	productsData = csv.reader(csvfile, delimiter=',')

	#Skip the header while reading
	next(productsData)

	for row in productsData:
		products[row[0]] = row

custIds_customers = []
custIds_orders = []
customers = {}
customer_ranking = {}
customer_ranking_zero = {}

# Combine duplicate customer ids and dump into a new orders_new.csv
df = pd.read_csv(ORDERS_IN, sep=',', dtype=str)
g_df = df.groupby("customer")
group = g_df["products"].agg(lambda column: " ".join(column))
group = group.reset_index(name="products").to_csv(ORDERS_TEMP, sep=',', index=False)

# Open the customers & orders CSV files
with open(CUSTOMERS_IN, newline='') as csvcustomer:
	with open(ORDERS_TEMP, newline='') as csvorders:

	# Read the customers from CSV and make it a dictionary
		customerData = csv.reader(csvcustomer, delimiter=',')

		#Skip the header while reading
		next(customerData)

		for row in customerData:
			customers[row[0]] = row
		# Create a list of the customer ids from customers.csv
		custIds_customers = customers.keys()

	# Read the orders from CSV
		orders = csv.reader(csvorders, delimiter=',')

		#Skip the header while reading
		next(orders)

		for row in orders:
			totalPrice = 0.0

			#Get the product IDs
			productIds = row[1].split(" ")
			customerId = row[0]

			# Create a list custIds_orders from orders.csv
			custIds_orders.append(row[0])

			#Loop through product ids
			for productId in productIds:
				totalPrice = totalPrice + float(products[productId][2])
			customer_ranking[customerId] = totalPrice

		# Create dictionary for the additional custIds with Zero total_euros spent
		addtional_custIds = (set(custIds_customers).difference(custIds_orders))
		totalPrice = 0.0
		for row in addtional_custIds:
			customer_ranking_zero[row] = totalPrice

		# Append the above dict to the dict with Non-Zero total_euros
		customer_ranking.update(customer_ranking_zero)
		os.remove(ORDERS_TEMP)

with open(CUST_RANKING_OUT, 'w') as f:
	writer = csv.writer(f)

	#Write the header
	writer.writerow(['id', 'firstname', 'lastname', 'total_euros'])

	#Sort the total_euros in descending order
	sort_orders = sorted(customer_ranking.items(), key=lambda x: x[1], reverse=True)

	for customerId, total_euros in sort_orders:
		writer.writerow([customerId, customers[customerId][1], customers[customerId][2], total_euros])
