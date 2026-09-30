import pandas as pd
import numpy as np
df = pd.read_csv("online_retail.csv")
print(df.shape)
print(df.columns)
print(df.columns.tolist())
print(df.head(5))
print(df.tail(5))
print(df.dtypes)

# step 2: missing values analysis
 
print("missing values in each column:")
print(df.isnull().sum())
print("/n missing values in percentage:")
print(df.isnull().sum()/df.shape[0]*100)

# step 3: Remove missing customer id's

df_clean = df.dropna(subset=['Customer ID'])
print("rows before:",len(df))
print("rows after:",len(df_clean))
print("missing customer id's remaining:",df_clean['Customer ID'].isnull().sum())


# step 4: Remove missing product descriptions

print("Rows before:", len(df_clean))

df_clean = df_clean.dropna(subset=['Description'])

print("Rows after:", len(df_clean))
print("Missing descriptions remaining:", df_clean['Description'].isna().sum())

#step 5 : remove duplicate rows

print("rows before:",len(df_clean))
print("duplicate rows:",df_clean.duplicated().sum())
df_clean = df_clean.drop_duplicates()
print("rows after:",len(df_clean))
print("duplicate rows remaining:",df_clean.duplicated().sum())

# step 6: check canceled invoices

canceled =df_clean['Invoice'].astype(str).str.startswith('C')
print("canceled invoices:",canceled.sum())
print("normal invoices:",(~canceled).sum())

# step 7: remove canceled invoices

print("rows before:",len(df_clean))
df_clean = df_clean[~df_clean['Invoice'].astype(str).str.startswith('C')]
print("rows after:",len(df_clean))
print("canceled invoices remaining:",df_clean['Invoice'].astype(str).str.startswith('C').sum())

# step 8: check negative quantities

print("negative quantities:",(df_clean['Quantity']<0).sum())
print("zero quantities:",(df_clean['Quantity']==0).sum())
print("positive quantities:",(df_clean['Quantity']>0).sum())

#step 9: check valid prices

print("negative prices:",(df_clean['Price']<0).sum())
print("zero prices:",(df_clean['Price']==0).sum())
print("positive prices:",(df_clean['Price']>0).sum())

# step 10: remove zero prices transactions

print("rows before:",len(df_clean))
df_clean = df_clean[df_clean['Price']>0]
print("rows after:",len(df_clean))
print("zero prices remaining:",(df_clean['Price']==0).sum())

# step 11: convert data types

df_clean['InvoiceDate'] = pd.to_datetime(
    df_clean['InvoiceDate'],
    format='%d-%m-%Y %H:%M'
)

df_clean['Customer ID'] = df_clean['Customer ID'].astype(int)

print(df_clean.dtypes)

# step 12 : final data quality check

print(df_clean.shape)
print(df_clean.isnull().sum())
print(df_clean.duplicated().sum())
print(df_clean.dtypes)
print(df_clean['InvoiceDate'].min())
print(df_clean['InvoiceDate'].max())

# Save cleaned data

df_clean.to_csv('online_retail_cleaned.csv', index=False)
print("Cleaned file saved")
print(f"Final shape: {df_clean.shape}")