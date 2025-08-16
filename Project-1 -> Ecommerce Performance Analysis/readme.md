# The Look: E-commerce Performance Analysis (2019-2025)

**Table of Contents**

- [Project Overview](#project-overview)
- [Data Structure Overview](#data-structure-overview)
- [Executive Summary](#executive-summary)
- [Insights Deep Dive](#insights-deep-dive)
- [Recommendations](#recommendations)

---

## Project Overview

"The Look" is an e-commerce company that began its operations in **2018**, specializing in various clothing and accessories for both men and women. This project was initiated at the request of the company owner to conduct a thorough analysis of the store's performance. The primary goals of this analysis are to determine the overall business growth rate and to identify any specific areas that the operating team should focus on.

This report is based on all historical data from **2019** through **2025**. I have analyzed key performance indicators (KPIs) such as customer acquisition, sales volume, sales revenue, and average order value (AOV). The aim is to understand the company's performance, identify opportunities for improvement, and generate more revenue and profit. In addition, I will provide recommendations for the data team to improve data quality, which will help the company make better, more informed decisions in the future.

---

## Data Structure Overview

The company's data is stored across **four** key tables, which are used to measure the different performance indicators.

* **Inventory Items:** This table contains information on every product the company has ever owned. It includes the date a product was sold, details about the product itself, and the warehouse number it was shipped from.
    * **Number of Records:** **490,910**

* **Ordered Items:** This table has details about individual products that customers ordered. It also includes various dates related to the product's journey through the supply chain.
    * **Number of Records:** **181,038**

* **Orders:** This table is used to uniquely identify each order placed. It contains different dates corresponding to the stages of an order in the supply chain.
    * **Number of Records:** **124,697**

* **Users:** This table holds geographic and some demographic information about every customer the company has ever had.
    * **Number of Records:** **100,000**

![ERD](https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/ERD.png)

---

## Executive Summary

![Main KPI Dashboard](https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/KPI%20Dashboard.png)

For the majority of the period analyzed, the company consistently attracted around **1,150** new users each month. However, a significant spike occurred in May **2025**, when the company gained over **3,100** new users. Notably, **70%** of these new users came from the 'Search' traffic source. This presents an opportunity for the operating team to investigate what caused this exceptional increase and learn how to attract more users. The company has been very effective at turning new users into paying customers, which has led to a major increase in both new buyers and total buyers since **2024**.

Total Revenue and Profit have shown impressive growth over this period, with a substantial increase in profit since the start of **2025**. Although total revenue experienced a small dip in February **2025** after a period of rapid growth in late **2024**, it recovered quickly to offset that decline. The company's costs appear to be well-managed in comparison to its revenue and profit, which suggests improved operational efficiency and growing profit margins. Over the analyzed period, the company has stabilized its profit margin at approximately **50%**. The current annual growth rate for revenue and profit is also very strong.

Sales Volume consistently reflects the positive trends in customer acquisition and revenue, showing a steady and accelerating increase. The clear upward trend in late **2024** and early **2025** confirms that the company is successfully turning increased customer engagement into higher sales.

Unlike the other metrics, the Average Order Value (AOV) has remained fairly stable over the period, staying between **$80** and **$95**, with an average of **$87.10**. This stability suggests that the major growth in revenue and sales volume is primarily driven by an increase in the *number* of customers and transactions, rather than an increase in the value of each individual order.

In summary, the company is experiencing a period of strong, accelerating growth across key business areas. The significant increases in new users, total buyers, revenue, profit, and sales volume are very positive. The consistent Average Order Value shows that our current strategy is effectively expanding our customer base and increasing how often they buy.

Moving forward, it will be important to continue watching these trends, with a special focus on keeping up the momentum in customer acquisition and making sure that costs are managed effectively as the company scales.

---

## Insights Deep Dive

### User and Customer Acquisition

New users were counted using the `creation_date` from the `Users` table. New buyers and total buyers were counted using the `shipping_date` from the `Ordered Items` table. We had to connect user IDs with sales records to accurately count each customer's purchase. Fortunately, the `Ordered Items` table contains both user IDs and sales records. However, the user ID is not available in the `Inventory Items` table, which contains many more records of sold products. This makes it difficult to get an exact number of new and total buyers for each month.

A potential way to account for this missing data is to assume that each order includes an average of **two** products, and that no customer makes more than one purchase in a single month. Using this assumption, the total customer base in each month would include thousands of more people since October **2022**. This suggests that the company's actual customer base is likely much larger than what is shown in the main KPI dashboard.

### Total Revenue, Profit, and Cost

All **three** of these metrics were calculated by combining sales records from the `Inventory Items` and `Ordered Items` tables. Unlike the customer acquisition metric, there are no missing data issues for these calculations. This means the numbers shown in the KPI dashboard for these **three** metrics are accurate. Revenue was calculated by adding up the `retail_price` of all sold products. Cost was calculated by adding up the values in the `cost` column, and Profit was calculated by subtracting the total cost from the total revenue. The company achieved its first Million Dollar Revenue per month in May **2025**. The company's total (Net) Revenue is **$16.7M**, and its total (Net) Profit is **$8.67M**.

As mentioned in the executive summary, the company has stabilized its profit margin at about **50%**. A simple **20%** increase in the sale price of all products could have raised the profit margin to **60%**. A price increase of this magnitude could have resulted in total revenue exceeding **$20M**, and net profit could have been as high as **$12M**. This shows the significant growth that could be achieved by making a small change to product pricing. The company has not changed its product prices since its beginning, even though the economy has fluctuated. The fact that both retail prices and product costs have remained steady gives the company a great opportunity to grow by creating a better sales strategy. For this reason, I believe that increasing product prices to boost the bottom line is a smart move for the operating team to consider. The table below shows a yearly comparison of the current revenue and profit against a **20%** increase in the products.

![Annual Comparison of Revenue and Profit with a 20% Increase](https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/Annual%20Comparison%20of%20CRP.png)

### Sales Volume

The company is successfully converting customer interest into more sales. The trends for total buyers and sales volume look nearly identical, which shows that more buyers lead to a greater quantity of sales. Therefore, the company needs to not only understand how to attract more customers but also how to keep them. The company should also plan better marketing campaigns to hold the attention of its customer base. The table below displays the company's annual sales volume and the growth rate compared to previous years.

![Annual Sales Volume and Growth Rate](https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/Annual%20Sales%20Volume%20%26%20GR.png)

### Average Order Value (AOV)

To calculate the AOV, we need the total value of all transactions for a given period and the number of orders in that same time frame. To identify each unique order, we need a unique `order_id` connected to the sales records. However, similar to the customer acquisition data, there is a lack of data for AOV. While the `Ordered Items` table includes the `order_id`, the `Inventory Items` table does not. This means most of the sales records are missing a way to track the order they belong to.

The AOV presented in the main dashboard is based only on the `Ordered Items` table. To include the records from the `Inventory Items` table, we can make an assumption that every order contains **two** items. With this assumption, the number of orders from the `Inventory Items` table would be the number of records divided by **two**. When we combine both tables to calculate a new, "combined" AOV, the results are quite different.

![Comparison of AOV calculations with and without combined data](https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/ComparedAOV.png)

As you can see, the average difference between the two calculations is **$16.61**, which is a significant difference for this metric. The combined AOV has been consistently between **$99** and **$110** since June **2021**. This suggests that the company's true AOV is likely closer to **$100**.

---

## Recommendations

Based on our analysis of the company's performance, here are some key recommendations for the operating and data teams:

### For the Operating Team

* **Investigate Recent Growth:** Look into the reasons behind the significant jump in new users in May **2025**, especially the success of the 'Search' traffic source. Understanding this can help us attract more users in the future.
* **Consider a Price Adjustment:** Since product prices haven't changed since the company started, consider a small, strategic increase. Our analysis suggests this could significantly raise the company's profit margin.
* **Focus on Customer Retention:** Alongside attracting new customers, develop new plans and marketing campaigns to encourage existing customers to keep buying from us. This will help sustain long-term growth.

### For the Data Team

* **Improve Data Quality:** It's crucial to get a more accurate picture of our customers and sales. We need to work on a solution to connect user IDs to all sales records, especially in the `Inventory Items` table. This will give us a much better understanding of our actual customer base and the true Average Order Value.
