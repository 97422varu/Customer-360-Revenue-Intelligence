import pandas as pd
import mysql.connector

conn = mysql.connector.connect(
    host='localhost',
    user='root',
    password='Varun021',
    database='customer_retail'
)
cursor = conn.cursor()

df = pd.read_csv('online_cleaned.csv')
df = df.fillna('')
print(f"Total rows: {len(df)}")

data = [tuple(row) for _, row in df.iterrows()]

query = """INSERT INTO online_cleaned 
           (Invoice, StockCode, Description, Quantity,
            InvoiceDate, Price, CustomerID, Country)
           VALUES (%s,%s,%s,%s,%s,%s,%s,%s)"""

batch_size = 5000
for i in range(0, len(data), batch_size):
    batch = data[i:i+batch_size]
    cursor.executemany(query, batch)
    conn.commit()
    print(f"Inserted {min(i+batch_size, len(data))} / {len(data)}")

print("Done ✅")
cursor.close()
conn.close()