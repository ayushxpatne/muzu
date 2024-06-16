import csv
from datetime import datetime, timedelta
import random
import json

# Define categories
categories = ["Food", "Entertainment", "Transportation", "Shopping", "Fitness"]

# Generate transactions
transactions = []
start_date = datetime(2023, 3, 1)  # Start from January  1, 2024
days = 365  # 90 days for February, March, and April

for i in range(days):
    current_date = start_date + timedelta(days=i)
    for j in range(20):  # 20 transactions per day
        category = random.choice(categories)
        title = f"Transaction{j+1} on {category}"
        amount = round(random.uniform(5, 200), 0)  # Random amount between $5 and $200
        transactions.append((title, amount, current_date.strftime("%a, %b %d, %Y"), category))

# Write transactions to CSV
with open('transactions2.csv', 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile)
    csvwriter.writerow(['title', 'amount', 'date', 'category'])
    csvwriter.writerows(transactions)


with open('transactions2.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    data = [row for row in reader]

import json
import os

with open('transaction2.json', 'w') as jsonfile:
    json.dump(data, jsonfile)