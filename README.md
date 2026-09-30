<div align="center">

# 📊 Customer 360 & Revenue Intelligence

**End-to-end customer analytics: Python · MySQL · RFM · Machine Learning · Power BI · Tableau**

![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=for-the-badge&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=for-the-badge&logo=tableau&logoColor=white)
![scikit-learn](https://img.shields.io/badge/scikit--learn-F7931E?style=for-the-badge&logo=scikitlearn&logoColor=white)

</div>

---

## 📌 Overview

- Turns raw retail transactions into **customer-level insights**
- Covers cleaning, SQL analytics, RFM segmentation, churn analysis, ML, and BI dashboards
- Dataset: **UCI Online Retail II**

### 🔄 Workflow

```text
Raw Data → Python Cleaning → MySQL → SQL Analysis → Customer 360
        → RFM Segmentation → Churn Analysis → ML Model
        → Power BI → Tableau → Business Insights
```

---

## 🎯 Business Questions

- Which customers generate the most revenue?
- Which customers are loyal and valuable?
- Which customers are becoming inactive?
- Where is churn concentrated?
- Which products and countries drive revenue?
- How concentrated is revenue among top customers?
- Can churn risk be identified early?

---

## 🧰 Tech Stack

| Category | Tools |
|---|---|
| **Analysis** | Python, Pandas, NumPy, Jupyter Notebook |
| **Database** | MySQL, SQL |
| **Machine Learning** | Scikit-learn, Random Forest, GridSearchCV |
| **BI & Visualization** | Power BI, Tableau |
| **Dev Tools** | VS Code, MySQL Workbench, Git & GitHub |

---

## 🗂️ Dataset

- **Source:** UCI Online Retail II
- **Fields:** Invoice, Stock Code, Description, Quantity, Invoice Date, Unit Price, Customer ID, Country

### Data Preparation

| Stage | Records |
|---|---:|
| Initial dataset | 525,461 |
| After removing missing Customer IDs | 417,534 |
| After removing duplicates | 410,763 |
| After removing cancelled invoices | 400,947 |
| After removing invalid / zero prices | **400,916** |

---

## 🏗️ Project Architecture

```text
                 RAW RETAIL DATA
                        |
                        v
              PYTHON DATA CLEANING
                        |
                        v
                  CLEAN DATASET
                        |
                        v
                      MYSQL
                        |
          +-------------+-------------+
          |             |             |
          v             v             v
     SQL ANALYSIS   RFM ANALYSIS  CHURN ANALYSIS
          |             |             |
          +-------------+-------------+
                        |
                        v
                CUSTOMER 360 VIEW
                        |
                        v
              MACHINE LEARNING
              CHURN PREDICTION
                        |
              +---------+---------+
              |                   |
              v                   v
          POWER BI             TABLEAU
       Executive View       Deep Analytics
              |                   |
              +---------+---------+
                        |
                        v
                BUSINESS INSIGHTS
```

---

## 🔬 Project Breakdown

### 1️⃣ Data Cleaning (Python)

- Removed missing Customer IDs
- Removed duplicate transactions
- Removed cancelled invoices
- Removed zero / invalid prices
- Converted `InvoiceDate` to datetime
- Standardized Customer ID values

### 2️⃣ SQL Business Analysis (MySQL)

| Area | Metrics |
|---|---|
| **Customer** | Total customers, orders, revenue, AOV, repeat behavior, top customers |
| **Product** | Revenue, quantity, avg. price, order frequency, top products |
| **Country** | Revenue, customer count, contribution, top countries |
| **Time** | Monthly / yearly revenue, orders, customers, AOV, growth trends |

### 3️⃣ Customer 360

- Recency, Frequency, Monetary
- Total revenue & number of orders
- Average Order Value
- Purchase frequency
- Customer segment
- Churn status & prediction

### 4️⃣ RFM Segmentation

- Quintile-based R, F, M scoring
- **Segments:** Champions · Loyal Customers · Potential Loyalists · At Risk · Hibernating/Lost · Other

| Component | Meaning |
|---|---|
| **R**ecency | How recently a customer purchased |
| **F**requency | How often a customer purchased |
| **M**onetary | How much revenue a customer generated |

### 5️⃣ Revenue Concentration

- Top 10 customers → **~16.5%** of total revenue
- Highest-value customer → **~£349K** (~4% of revenue)
- **Opportunities:** VIP programs, loyalty strategies, cross-selling, personalized offers

### 6️⃣ Churn Analysis

- **Definition:** inactive for more than **90 days**

| Metric | Value |
|---|---:|
| Active customers | 2,877 |
| Churned customers | 1,435 |
| **Churn rate** | **33.28%** |

**Churn by RFM Segment**

| Segment | Churn Rate |
|---|---:|
| Hibernating/Lost | ~91.45% |
| At Risk | ~63.97% |
| Other | ~11.15% |
| Loyal Customers | 0% |
| Potential Loyalists | 0% |
| Champions | 0% |

### 7️⃣ Revenue Associated with Churn

- Historical revenue from churned customers: **~£1.08M**
- Share of analyzed revenue: **~12.27%**

> ⚠️ This is historical revenue from churned customers, not guaranteed future revenue loss.

**Recommended actions**

- Win-back campaigns
- Personalized promotions
- Product recommendations
- Email reactivation
- Engagement programs

### 8️⃣ Machine Learning: Churn Prediction

- **Model:** Random Forest Classifier
- **Features:** Recency, Frequency, Monetary, Country (One-Hot Encoded)

**Workflow**

1. Customer-level feature preparation
2. Stratified train/test split
3. One-Hot Encoding
4. Random Forest training
5. Hyperparameter tuning (GridSearchCV)
6. Model evaluation

**Best Parameters**

```text
n_estimators = 200
max_depth    = 10
class_weight = balanced
```

**Performance**

| Metric | Result |
|---|---:|
| Accuracy | **68.15%** |
| Recall (churn class) | **74%** |

---

## 📊 Dashboards

### 9️⃣ Power BI: Executive Overview

- Interactive, executive-level view of customer & revenue performance

**Includes**

- Total Revenue · Total Customers · Total Orders · AOV
- Active Customers · Churned Customers · Churn Rate
- Revenue by Year
- Customer Segment Distribution
- Revenue by Customer Segment
- Customer Churn
- Top Customers · Top Countries · Top Products
- Business Insights

### 🔟 Tableau: Deep Analytics

- 3 dashboards for deeper exploration, without duplicating the Power BI view

#### Dashboard 1: RFM Customer Intelligence

- Customer Segment Distribution
- Revenue by Customer Segment
- Recency vs Monetary
- Frequency vs Monetary
- **Purpose:** understand customer value, purchasing behavior, and segmentation

![RFM Customer Intelligence](RFM%20Customer%20Intelligence.png)

#### Dashboard 2: Churn Intelligence

- Active vs Churned Customers
- Churn Rate by RFM Segment
- Churn Rate by Country
- Historical Revenue by Churn Status
- **Purpose:** identify where churn is concentrated and how it relates to behavior

![Churn Intelligence](Churn%20Intelligence.png)

#### Dashboard 3: Revenue Intelligence

- Monthly Revenue Trend
- Average Order Value Trend
- Top 10 Countries by Revenue
- Top 10 Customers by Revenue
- Top 10 Products by Revenue
- **Purpose:** analyze revenue performance, customer concentration, geography, and products

![Revenue Intelligence](Revenue%20Intelligence.png)

---

## 💡 Key Business Insights

| Area | Insight |
|---|---|
| **Customer Value** | Top 10 customers contribute ~16.5% of total revenue |
| **Retention** | Hibernating/Lost segment has ~91.45% churn, the largest pool of inactive customers |
| **At-Risk Customers** | ~63.97% of At Risk customers are churned, an opportunity for early retention |
| **Overall Churn** | ~33.28% of customers churned under the 90-day inactivity definition |
| **Revenue Exposure** | ~£1.08M historical revenue linked to churned customers |
| **Geography** | Revenue is concentrated in few countries, with the **United Kingdom** dominant |
| **Products** | Revenue is concentrated in a smaller group of top products |
| **Predictive Analytics** | Random Forest: 68.15% accuracy, 74% churn recall, useful for prioritizing retention |

---

## ✅ Business Recommendations

- **Retain high-value customers:** loyalty & VIP programs for Champions and top-revenue customers
- **Reactivate inactive customers:** personalized win-back campaigns for Hibernating/Lost
- **Prevent churn earlier:** monitor and engage At Risk customers
- **Improve customer value:** cross-sell and upsell using purchase behavior
- **Optimize product strategy:** focus promotions and inventory on high-revenue products
- **Improve geographic strategy:** analyze high-revenue markets separately
- **Use predictive churn scoring:** prioritize customers for retention campaigns

---

## 📁 Repository Structure

```text
Customer-360-Revenue-Intelligence/
│
├── customer_360 python/
│   ├── data cleaning notebooks
│   ├── EDA notebooks
│   └── churn model
│
├── customer_360 intelligence.sql
├── customer_360 intelligence dashboard.pbix
│
├── tableau/
│   └── Tableau dashboard resources
│
├── RFM Customer Intelligence.png
├── Churn Intelligence.png
├── Revenue Intelligence.png
│
├── README.md
└── requirements.txt
```

> Large raw datasets and local data-source files are not included in the repository.

---

## ⚠️ Limitations

- Dataset covers the available transaction period, not a full-year comparison for every year
- Descriptive churn uses a 90-day inactivity threshold
- ML churn uses a future-order observation window, so it differs from descriptive churn
- Historical churn revenue ≠ guaranteed future revenue loss
- Random Forest is a decision-support tool, not a definitive predictor
- More customer attributes and longer history could improve the model

---

## 🔮 Future Improvements

- Customer Lifetime Value (CLV) prediction
- More advanced churn models
- Hyperparameter optimization with additional algorithms
- Real-time customer scoring
- Automated retention recommendations
- Product recommendation system
- Customer-level revenue forecasting
- Automated dashboard refresh
- Marketing campaign response prediction
- Cloud-based deployment

---

## 🛠️ Key Skills Demonstrated

- **Programming:** Python, Pandas, NumPy
- **Data Work:** Data Cleaning, EDA, SQL, MySQL
- **Analytics:** Customer Analytics, RFM Analysis, Segmentation, Churn Analysis
- **ML:** Machine Learning, Random Forest, Scikit-learn
- **BI:** Power BI, DAX, Tableau, Data Visualization, Business Intelligence
- **Tools:** Git, GitHub, Business Analysis

---

## 🏁 Project Outcome

- Converts raw retail data into **actionable customer & revenue intelligence**
- Pipeline: `Data Engineering → Analytics → Segmentation → Machine Learning → BI → Business Insights`
- Helps businesses:
  - Understand customer value
  - Identify churn risk
  - Analyze revenue performance
  - Support data-driven retention strategies

---

## 👤 Author

**Varunasiddesha H E**
Bachelor of Engineering, Computer Science & Engineering
Sambhram Institute of Technology

**Project:** Customer 360 & Revenue Intelligence Platform
**Technologies:** Python | SQL | MySQL | Power BI | Tableau | Machine Learning

<div align="center">

⭐ If you found this project useful, consider giving it a star!

</div>
