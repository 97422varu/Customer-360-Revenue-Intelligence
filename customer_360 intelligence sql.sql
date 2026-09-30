create database customer__360;
use customer__360;
CREATE TABLE customer_transactions (
    Invoice VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    Price DECIMAL(10,2),
    Customer_ID INT,
    Country VARCHAR(100)
);
SHOW DATABASES;
USE customer_360;
SHOW TABLES;
USE customer__360;
SELECT COUNT(*) AS total_rows
FROM customer_transactions;
select*from customer_transactions;
select count(distinct Customer_ID) as total_customer
from customer_transactions;
select count(distinct Invoice) as total_invoices
from customer_transactions;
select count(distinct StockCode) as total_product
from customer_transactions;
select sum(Quantity) as total_prodctsold
from customer_transactions;
select sum(Quantity*Price) as total_revenue
from customer_transactions;
select sum(Quantity*price) / count(distinct Invoice) as avg_ordervalue
from customer_transactions;
#customer analysis 
select customer_ID, count(distinct Invoice) as total_order
from customer_transactions
group by customer_ID
order by total_order desc;
select Customer_ID, sum(Quantity*price) as total_revenue
from customer_transactions
group by Customer_ID;
# top 10 customer by revenue 
select Customer_ID,sum(Quantity*price) as total_revenue
from customer_transactions
group by Customer_ID
order by total_revenue desc
limit 10;
#top 10 customers by order
select Customer_ID,count(distinct Invoice) as total_order
from customer_transactions
group by Customer_ID
order by total_order DESC
limit 10;
#Find the Average Order Value (AOV) for each customer
select Customer_ID,sum(Quantity*Price) / count(distinct Invoice) as Average_order_value
from customer_transactions
group by Customer_ID;
#6 — Repeat Customers
select Customer_ID,count(distinct Invoice) as total_orders
from customer_transactions
group by Customer_ID
having count(distinct Invoice) >1;
#7 — Repeat Customer Percentage
SELECT
    COUNT(*) * 100.0 /
    (SELECT COUNT(DISTINCT Customer_ID)
     FROM customer_transactions) AS repeat_customer_percentage
FROM (
    SELECT Customer_ID
    FROM customer_transactions
    GROUP BY Customer_ID
    HAVING COUNT(DISTINCT Invoice) > 1
) AS repeat_customers;
#8 — Customer Revenue Contribution
select Customer_ID,
sum(Quantity*Price) as customer_revenue,
sum(Quantity*Price) *100.0 /
(select sum(Quantity*Price)
from customer_transactions) as revenue_contribution_pct
from customer_transactions
group by Customer_ID
order by customer_revenue desc;
#product analysis
#9. Product Revenue
select 
StockCode,
Description,
sum(Quantity*price) As total_revenue
from customer_transactions
group by StockCode,Description
order by total_revenue desc;
#10. Product Quantity Sold
select StockCode,Description,
sum(Quantity) as product_quantity_sold
from customer_transactions
group by StockCode,Description
order by product_quantity_sold desc;
#11. Top 10 Products by Revenue
select 
StockCode,
Description,
sum(Quantity*price) As total_revenue
from customer_transactions
group by StockCode,Description
order by total_revenue desc
limit 10;
#12 — Top 10 Products by Quantity:
select StockCode,Description,
sum(Quantity) as product_quantity_sold
from customer_transactions
group by StockCode,Description
order by product_quantity_sold desc
limit 10;
#13 — Product Average Price
select StockCode,Description,avg(price) as product_avg_price
from customer_transactions
group by Stockcode,Description
order by product_avg_price desc;
#14 — Product Order Count
select StockCode,Description,
count(distinct Invoice) as total_product_order
from customer_transactions
group by StockCode,Description
order by total_product_order desc;
#15 — Revenue Contribution by Product
select Stockcode,Description,
sum(Quantity*Price) * 100.0 /
(select sum(Quantity*Price) 
from customer_transactions) as revenue_contribution_pct 
from customer_transactions
group by StockCode,Description
order by revenue_contribution_pct desc ;
#16 — Country Revenue Analysis
select country , sum(Quantity*price) as country_revenue
from customer_transactions
group by country
order by country_revenue desc;
#17 — Top 10 Countries by Revenue
select country , sum(Quantity*price) as country_revenue
from customer_transactions
group by country
order by country_revenue desc
limit 10;
#18 — Country Customer Count
select 
country,
count(distinct Customer_ID)  as country_customer_count
from customer_transactions
group by country ;
#19 — Country Revenue Contribution:
select country,
sum(Quantity*Price)*100.0/
(select sum(Quantity*Price)
from customer_transactions) as country_revenue_pct
from customer_transactions
group by country
order by country_revenue_pct desc;
#20 — Monthly Revenue
select year(InvoiceDate) as revenue_year,
month(InvoiceDate) as revenue_month,
sum(Quantity*Price) as monthly_revenue
from customer_transactions
group by year(InvoiceDate),month(InvoiceDate)
order by revenue_year, revenue_month asc;
#21 Monthly Order Count.
select year(InvoiceDate) as yearly_order,
month(InvoiceDate) as monthly_order,
count(distinct Invoice) as total_orders
from customer_transactions
group by year(InvoiceDate),month(InvoiceDate)
order by yearly_order, monthly_order desc;
#22: Monthly Unique Customers
select month(InvoiceDate) AS monthly_customer,
count(distinct Customer_ID) 
from customer_transactions
group by month(InvoiceDate)
order by monthly_customer asc;
#23 — Monthly Average Order Value (AOV).
select year(InvoiceDate) as year_order,month(InvoiceDate) as month_order,
sum(Quantity*Price) / count(distinct Invoice) as avg_order_value
from customer_transactions
group by year(InvoiceDate) ,month(InvoiceDate)
order by year_order,month_order asc;
#24 — Year-over-Year Revenue
select year(InvoiceDate) as Year_revenue,
sum(Quantity*Price) as revenue
from customer_transactions
group by year(InvoiceDate),month(InvoiceDate)
order by year_revenue asc;
#25 — Best/Worst Revenue Months
select year(InvoiceDate) as Year_revenue,
month(InvoiceDate) as month_revenue,
sum(Quantity*Price) as revenue
from customer_transactions
group by year(InvoiceDate),month(Invoicedate)
order by revenue desc
limit 1;
#lowest revenue month
select year(InvoiceDate) as Year_revenue,
month(InvoiceDate) as month_revenue,
sum(Quantity*Price) as revenue
from customer_transactions
group by year(InvoiceDate),month(Invoicedate)
order by revenue asc
limit 1;
#26 — Revenue Growth
select year(InvoiceDate) as year_revenue,
sum(Quantity*Price) as revenue 
from customer_transactions
group by Year(InvoiceDate)
order by year_revenue;
SELECT 
    SUM(
        CASE 
            WHEN YEAR(InvoiceDate) = 2009
            THEN Quantity * Price 
            ELSE 0 
        END
    ) AS revenue_2009,

    SUM(
        CASE 
            WHEN YEAR(InvoiceDate) = 2010
            THEN Quantity * Price 
            ELSE 0 
        END
    ) AS revenue_2010,

    (
        SUM(
            CASE 
                WHEN YEAR(InvoiceDate) = 2010
                THEN Quantity * Price 
                ELSE 0 
            END
        )
        -
        SUM(
            CASE 
                WHEN YEAR(InvoiceDate) = 2009
                THEN Quantity * Price 
                ELSE 0 
            END
        )
    )
    /
    SUM(
        CASE 
            WHEN YEAR(InvoiceDate) = 2009
            THEN Quantity * Price 
            ELSE 0 
        END
    ) * 100 AS revenue_growth_pct

FROM customer_transactions;
#RMF ANALYSIS
#27 RECENCY
select Customer_ID,max(InvoiceDate)
from customer_transactions
group by Customer_ID;
#28 — Frequency
select Customer_ID,
count(distinct Invoice) as total_order
from customer_transactions
group by Customer_ID
order by total_order desc;
#29 — Monetary
select Customer_ID,
sum(Quantity*Price) as customer_revenue
from customer_transactions
group by Customer_ID
order by Customer_revenue desc;
CREATE TABLE customer_RMF AS
SELECT
    Customer_ID,
    MAX(InvoiceDate) AS Recency,
    COUNT(DISTINCT Invoice) AS Frequency,
    SUM(Quantity * Price) AS Monetary
FROM customer_transactions
GROUP BY Customer_ID;
SELECT *
FROM customer_RMF
limit 10;
select max(InvoiceDate) as last_transaction_date
from customer_transactions;
alter table customer_RMF
add column Recency_days int;
UPDATE customer_RMF
SET Recency_Days = DATEDIFF('2010-12-10', Recency)
WHERE Customer_ID IS NOT NULL;
SELECT *
FROM customer_RMF
LIMIT 10;
#32 — RFM Scoring
ALTER TABLE customer_RMF
ADD COLUMN R_Score INT,
ADD COLUMN F_Score INT,
ADD COLUMN M_Score INT;
UPDATE customer_RMF
SET R_Score =
    CASE
        WHEN Recency_Days <= (SELECT MAX(Recency_Days) FROM customer_RMF) * 0.2 THEN 5
        WHEN Recency_Days <= (SELECT MAX(Recency_Days) FROM customer_RMF) * 0.4 THEN 4
        WHEN Recency_Days <= (SELECT MAX(Recency_Days) FROM customer_RMF) * 0.6 THEN 3
        WHEN Recency_Days <= (SELECT MAX(Recency_Days) FROM customer_RMF) * 0.8 THEN 2
        ELSE 1
    END
WHERE Customer_ID IS NOT NULL;
SHOW TABLES;
DESCRIBE customer_RMF;
WITH scored AS (
    SELECT
        Customer_ID,
        NTILE(5) OVER (ORDER BY Recency_days DESC) AS R_Score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(5) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM customer_rmf
)
UPDATE customer_rmf r
JOIN scored s
    ON r.Customer_ID = s.Customer_ID
SET
    r.R_Score = s.R_Score,
    r.F_Score = s.F_Score,
    r.M_Score = s.M_Score;
    SELECT
    Customer_ID,
    Recency_days,
    Frequency,
    Monetary,
    R_Score,
    F_Score,
    M_Score
FROM customer_rmf
LIMIT 20;
#33 — Create the RFM Score
alter table customer_rmf
add column RFMSCORE INT;
UPDATE customer_rmf
SET RFMSCORE = R_Score + F_Score + M_Score;
SELECT Customer_ID, R_Score, F_Score, M_Score, RMFSCORE
FROM customer_rmf
LIMIT 20;
UPDATE customer_rmf
SET RMFSCORE = R_Score + F_Score + M_Score;
SELECT Customer_ID, R_Score, F_Score, M_Score, RMFSCORE
FROM customer_rmf
LIMIT 20;
#34 — Customer Segmentation
ALTER TABLE customer_rmf
ADD COLUMN Customer_Segment VARCHAR(30);
UPDATE customer_rmf
SET Customer_Segment =
    CASE
        WHEN R_Score >= 4
             AND F_Score >= 4
             AND M_Score >= 4
            THEN 'Champions'

        WHEN R_Score >= 3
             AND F_Score >= 3
             AND M_Score >= 3
            THEN 'Loyal Customers'

        WHEN R_Score >= 4
             AND F_Score <= 3
            THEN 'Potential Loyalists'

        WHEN R_Score <= 2
             AND F_Score >= 3
             AND M_Score >= 3
            THEN 'At Risk'

        WHEN R_Score <= 2
             AND F_Score <= 2
            THEN 'Hibernating/Lost'

        ELSE 'Other'
    END;
SELECT Customer_ID, R_Score, F_Score, M_Score, RMFSCORE, Customer_Segment
FROM customer_rmf
LIMIT 20;
SELECT Customer_Segment, COUNT(*) AS customer_count
FROM customer_rmf
GROUP BY Customer_Segment
ORDER BY customer_count DESC;
#35 — Analyze the segments
SELECT
    Customer_Segment,
    COUNT(*) AS customer_count
FROM customer_rmf
GROUP BY Customer_Segment
ORDER BY customer_count DESC;
#Revenue by segment
SELECT
    Customer_Segment,
    COUNT(*) AS customer_count,
    SUM(Monetary) AS total_revenue
FROM customer_rmf
GROUP BY Customer_Segment
ORDER BY total_revenue DESC;
#36 — Top 10 Customers by Revenue
SELECT
    Customer_ID,
    Monetary AS total_revenue
FROM customer_rmf
ORDER BY Monetary DESC
LIMIT 10;
#36.2 — Top 10 Revenue Contribution
SELECT
    Customer_ID,
    Monetary AS total_revenue,
    Monetary * 100.0 /
        (SELECT SUM(Monetary) FROM customer_rmf) AS revenue_contribution_pct
FROM customer_rmf
ORDER BY Monetary DESC
LIMIT 10;
#37 — Cumulative Revenue Contribution
SELECT
    CASE
        WHEN Recency_Days > 90 THEN 'Churned'
        ELSE 'Active'
    END AS Customer_Status,
    COUNT(*) AS Customer_Count
FROM customer_rmf
GROUP BY
    CASE
        WHEN Recency_Days > 90 THEN 'Churned'
        ELSE 'Active'
    END;
    #37.2 — Churn Rate
    SELECT
    SUM(CASE WHEN Recency_Days > 90 THEN 1 ELSE 0 END) * 100.0
    / COUNT(*) AS churn_rate_percentage
FROM customer_rmf;
#38 — Revenue at Risk
SELECT
    SUM(Monetary) AS revenue_at_risk
FROM customer_rmf
WHERE Recency_Days > 90;
SELECT
    COUNT(*) AS churned_customers,
    SUM(Monetary) AS revenue_at_risk
FROM customer_rmf
WHERE Recency_Days > 90;
 #39 — Churned Customer Revenue Contribution.
SELECT
    SUM(Monetary) AS churned_revenue,
    SUM(Monetary) * 100.0 /
        (SELECT SUM(Monetary)
         FROM customer_rmf) AS churned_revenue_percentage
FROM customer_rmf
WHERE Recency_Days > 90;
#40 — Churn Analysis by Customer Segment
SELECT
    Customer_Segment,
    COUNT(*) AS total_customers,
    SUM(CASE
            WHEN Recency_Days > 90 THEN 1
            ELSE 0
        END) AS churned_customers,
    SUM(CASE
            WHEN Recency_Days > 90 THEN 1
            ELSE 0
        END) * 100.0 / COUNT(*) AS churn_rate,
    SUM(CASE
            WHEN Recency_Days > 90 THEN Monetary
            ELSE 0
        END) AS churned_revenue
FROM customer_rmf
GROUP BY Customer_Segment
ORDER BY churn_rate DESC;
use customer__360;
select Customer_ID,
max(InvoiceDate) as last_purchase_date
from customer_transactions
where InvoiceDate <='2010-09-10'
group by Customer_ID
order by last_purchase_date desc;
select Customer_ID ,
count(distinct Invoice) as Frequency
from customer_transactions
where InvoiceDate <='2010-09-10'
group by Customer_ID
order by Frequency desc;
select Customer_ID,
sum(Quantity*price) as monetory
from customer_transactions
where InvoiceDate <= '2010-09-10'
group by Customer_ID
order by monetory desc;
select Customer_ID,
max(Country) as customer_country
from customer_transactions
where InvoiceDate <='2010-09-10'
group by Customer_ID;
select Customer_ID,
datediff('2010-09-10',max(InvoiceDate)) as Recency,
count(distinct Invoice) as Frequency,
sum(Quantity*Price) as monetory,
max(Country) as country
from customer_transactions
where InvoiceDate<='2010-09-10'
group by Customer_ID
order by Customer_ID;
select Customer_Id,count(distinct Invoice) as future_orders
from customer_transactions
where InvoiceDate >  '2010-09-10' and InvoiceDate <='2010-12-09'
group by Customer_ID
order by future_orders desc;
SELECT
    c.Customer_ID,
    c.Recency,
    c.Frequency,
    c.Monetary,
    c.Country,
    CASE
        WHEN COUNT(DISTINCT f.Invoice) > 0 THEN 0
        ELSE 1
    END AS Churn
FROM
(
    SELECT
        Customer_ID,
        DATEDIFF('2010-09-10', MAX(InvoiceDate)) AS Recency,
        COUNT(DISTINCT Invoice) AS Frequency,
        SUM(Quantity * Price) AS Monetary,
        MAX(Country) AS Country
    FROM customer_transactions
    WHERE InvoiceDate <= '2010-09-10'
    GROUP BY Customer_ID
) c
LEFT JOIN customer_transactions f
    ON c.Customer_ID = f.Customer_ID
    AND f.InvoiceDate > '2010-09-10'
    AND f.InvoiceDate <= '2010-12-09'
GROUP BY
    c.Customer_ID,
    c.Recency,
    c.Frequency,
    c.Monetary,
    c.Country
ORDER BY c.Customer_ID;
SELECT
    Churn,
    COUNT(*) AS Customer_Count,
    COUNT(*) * 100.0 / SUM(COUNT(*)) OVER () AS Percentage
FROM
(
    SELECT
        c.Customer_ID,
        CASE
            WHEN COUNT(DISTINCT f.Invoice) > 0 THEN 0
            ELSE 1
        END AS Churn
    FROM
    (
        SELECT Customer_ID
        FROM customer_transactions
        WHERE InvoiceDate <= '2010-09-10'
        GROUP BY Customer_ID
    ) c
    LEFT JOIN customer_transactions f
        ON c.Customer_ID = f.Customer_ID
        AND f.InvoiceDate > '2010-09-10'
        AND f.InvoiceDate <= '2010-12-09'
    GROUP BY c.Customer_ID
) x
GROUP BY Churn;
CREATE TABLE customer_ml_dataset AS
SELECT
    c.Customer_ID,
    c.Recency,
    c.Frequency,
    c.Monetary,
    c.Country,
    CASE
        WHEN COUNT(DISTINCT f.Invoice) > 0 THEN 0
        ELSE 1
    END AS Churn
FROM
(
    SELECT
        Customer_ID,
        DATEDIFF('2010-09-10', MAX(InvoiceDate)) AS Recency,
        COUNT(DISTINCT Invoice) AS Frequency,
        SUM(Quantity * Price) AS Monetary,
        MAX(Country) AS Country
    FROM customer_transactions
    WHERE InvoiceDate <= '2010-09-10'
    GROUP BY Customer_ID
) c
LEFT JOIN customer_transactions f
    ON c.Customer_ID = f.Customer_ID
    AND f.InvoiceDate > '2010-09-10'
    AND f.InvoiceDate <= '2010-12-09'
GROUP BY
    c.Customer_ID,
    c.Recency,
    c.Frequency,
    c.Monetary,
    c.Country;
    SELECT COUNT(*) AS total_customers
FROM customer_ml_dataset;
