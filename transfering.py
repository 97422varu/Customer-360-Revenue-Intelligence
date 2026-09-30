import pandas as pd
import mysql.connector

# CSV file
csv_file = r"D:\Customer_360_Revenue_Intelligence\online_cleaned.csv"

# Connect to MySQL
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="Varun021",
    database="customer__360"
)

cursor = conn.cursor()

# Read CSV in batches
for chunk in pd.read_csv(csv_file, chunksize=5000):

    data = [
        (
            row["Invoice"],
            row["StockCode"],
            row["Description"],
            row["Quantity"],
            row["InvoiceDate"],
            row["Price"],
            row["Customer ID"],
            row["Country"]
        )
        for _, row in chunk.iterrows()
    ]

    sql = """
    INSERT INTO customer_transactions
    (Invoice, StockCode, Description, Quantity, InvoiceDate, Price, Customer_ID, Country)
    VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
    """

    cursor.executemany(sql, data)
    conn.commit()

    print(f"Imported {len(chunk)} rows")

cursor.close()
conn.close()

print("FULL IMPORT COMPLETED!")
