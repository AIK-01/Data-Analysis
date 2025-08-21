# The Look: E-commerce Performance Analysis (2019–2025)

**Table of Contents**
- [Project Overview](#project-overview)
- [Analytics Tools](#analytics-tools)
- [Data Structure Overview](#data-structure-overview)
- [Executive Summary](#executive-summary)
- [Insights Deep Dive](#insights-deep-dive)
- [Recommendations](#recommendations)

---

## Project Overview

**The Look** is an e-commerce company launched in **2018**, specializing in clothing and accessories for men and women. This project was conducted at the request of the company owner to evaluate overall performance and identify growth opportunities.  

The primary objectives were to:  
- Assess **business growth** over time.  
- Evaluate **customer acquisition, sales volume, revenue, profit, and average order value (AOV)**.  
- Identify areas requiring strategic focus.  
- Recommend steps to improve both **business operations** and **data quality**.  

The analysis covers historical records from **2019 through mid-2025** and provides data-driven recommendations to support revenue growth and profitability.

---

## Analytics Tools

To complete this analysis, the following tools were used:  

- **MySQL (DBMS):** Data extraction, querying, KPI calculation, **exploratory data analysis (EDA)**, and **scenario modeling**.  
- **OpenRefine:** Data cleaning and standardization across large datasets.  
- **Excel / Google Sheets:** **Yearly aggregations and summary tables** used for documentation.  
- **Tableau:** Dashboard creation and visualization of KPIs, trends, and insights.  

---

## Data Structure Overview

The company’s operational data is stored in **four key tables**:

* **Inventory Items:** Product-level sales records with details of sold items, sale dates, and warehouse numbers.  
    * Records: **490,910**

* **Ordered Items:** Details of products ordered by customers, including supply chain dates.  
    * Records: **181,038**

* **Orders:** Unique identifiers for each order placed, including multiple supply chain timestamps.  
    * Records: **124,697**

* **Users:** Customer information including demographic and geographic details.  
    * Records: **100,000**

<p align="center">
<img  height="520" width="720"
   src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/ERD.png" 
   alt="ERD"> 
</p>

---

## Executive Summary

![Main KPI Dashboard](https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/KPI%20Dashboard.png)

Between 2019 and mid-2025, **The Look** has demonstrated strong growth across its core business metrics:  

- **User Acquisition:** The company consistently attracted ~1,150 new users per month, with a spike in May 2025 (3,100+ new users, 70% from Search traffic). Conversion from new users to buyers is strong, fueling revenue growth.  
- **Revenue & Profit:** Revenue exceeded **$16.7M** with profit at **$8.67M**. Margins have stabilized at ~**50%**, supported by effective cost management. The company achieved its **first $1M revenue month** in May 2025.  
- **Sales Volume:** Closely tracks growth in buyers, showing a healthy conversion of customer acquisition into transactions.  
- **Average Order Value (AOV):** Stable between **$80–95**, averaging **$87.10**. Growth is primarily volume-driven rather than price-driven.  

Overall, the company is in a period of **accelerating growth**, with strong revenue and profit performance and healthy customer acquisition trends. Continued focus on retention and pricing strategy could further enhance profitability.

---

## Insights Deep Dive

### 1. User and Customer Acquisition
- **New users:** Calculated via `creation_date` in the `Users` table.  
- **Buyers:** Identified through `shipping_date` in `Ordered Items`.  
- Challenge: `Inventory Items` lacks user IDs, underestimating true customer counts.  

**Assumption:** ~2 products per order, 1 purchase per customer per month. Applying this increases the estimated customer base significantly since late 2022, suggesting the dashboard underreports actual growth.  

---

### 2. Revenue, Profit, and Cost
- **Revenue:** Sum of `retail_price` of sold products.  
- **Cost:** Sum of `cost` column.  
- **Profit:** Revenue – Cost.  

The company’s first **$1M+ month** occurred in May 2025. Annualized totals: **$16.7M revenue** and **$8.67M profit**.  

- **Scenario analysis:** A **20% price increase** could raise margins from 50% → 60%, lifting revenue to **$20M+** and profit to **$12M** without major operational changes.  

<img  height="400" width="520"
   src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/Annual%20Comparison%20of%20CRP.png" 
   alt="Annual Comparison of Revenue and Profit with a 20% Increase">

---

### 3. Sales Volume
Sales volume growth mirrors buyer growth, confirming strong conversion of acquisition to transactions.  

- To sustain momentum, **customer retention strategies** and targeted marketing campaigns are critical.  

<img  height="250"
   src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/Annual%20Sales%20Volume%20%26%20GR.png" 
   alt="Annual Sales Volume and Growth Rate">

_Note: 2025 growth appears negative due to incomplete yearly data (Jan–Jun only)._

---

### 4. Average Order Value (AOV)
- **Challenge:** `Inventory Items` table lacks `order_id`, limiting accurate AOV calculation.  
- Dashboard AOV = **$87.10** (based only on `Ordered Items`).  
- Adjusted assumption (2 items/order) + combined tables estimate true AOV ≈ **$100**.  

![Comparison of AOV calculations with and without combined data](https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/ComparedAOV.png)

---

## Recommendations

### For the Operating Team
1. **Investigate May 2025 Spike**  
   Analyze Search traffic drivers to replicate and scale this surge in user acquisition.  
2. **Strategic Price Adjustment**  
   Introduce modest price increases (e.g., 10–20%) to capture higher margins and strengthen profitability.  
3. **Customer Retention Focus**  
   Develop loyalty programs, targeted campaigns, and personalized offers to sustain long-term growth.  

### For the Data Team
1. **Enhance Data Integration**  
   Ensure all sales records in `Inventory Items` are linked to **user IDs** and **order IDs** for accurate customer and AOV analysis.  
2. **Data Quality Improvements**  
   Implement stronger validation and tracking processes to reduce reliance on assumptions.  

---
