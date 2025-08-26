<h1> <p align = "center"> Technical Documentation & Methods </p> </h1>

<h1> The Look: E-commerce Performance Analysis (2019–2025) </h1> 

This appendix reorganizes the **same information** from the main README into a technical format for reviewers who want methods, assumptions, and metric definitions. No new claims are introduced.

## 1) Scope & Dates
- Business launched: **2018**  
- Analysis window: **Jan 2019 – Jun 2025** (partial year in 2025)

## 2) Tables & Record Counts
- **Inventory Items** — product-level sales (sale date, product details, warehouse)  
  - Records: **490,910**
- **Ordered Items** — line items ordered by customers (includes user IDs and supply-chain dates)  
  - Records: **181,038**
- **Orders** — unique orders with supply-chain timestamps  
  - Records: **124,697**
- **Users** — customer geo/demographics  
  - Records: **100,000**

> **Data model note:** `Ordered Items` links sales lines to **user IDs** and **order IDs**. `Inventory Items` contains a larger set of sold products but **does not include user IDs or order IDs**.

## 3) Data Limitations (as stated in README)
- **Customer counts** (new buyers / total buyers): Underestimated if derived from `Inventory Items` because it lacks user IDs. Buyer metrics are therefore computed from `Ordered Items`.
- **AOV**: True AOV requires **order-level granularity**. `Ordered Items` has `order_id`, but `Inventory Items` does not. Dashboard AOV uses only `Ordered Items`.
- **Partial year 2025**: Annual growth rates in 2025 appear negative due to incomplete year.

## 4) KPI Definitions (from README)
- **Revenue** = Sum of `retail_price` of sold products (from combined sales records across `Inventory Items` and `Ordered Items` where applicable).  
- **Cost** = Sum of `cost`.  
- **Profit** = Revenue − Cost.  
- **New Users** = Count of users by `creation_date` (from `Users`).  
- **New Buyers / Total Buyers** = Distinct customers with purchases by `shipping_date` (from `Ordered Items`).  
- **AOV (Dashboard)** = Total transaction value ÷ Number of **orders** using `order_id` **from `Ordered Items` only**.

## 5) Assumptions Used (explicitly in README)
- **Average 2 items per order** (for `Inventory Items` where `order_id` is missing).  
- **One purchase per customer per month** (for estimating buyers where user linkage is incomplete).  
- **Scenario pricing**: A **+20%** uniform price increase used to estimate potential margin lift.

## 6) Key Results (from README)
- **User Acquisition:** ~**1,150** new users/month; spike **May 2025** with **3,100+** new users; **70%** from Search.
- **Financials:** First **$1M** revenue month in **May 2025**.  
  - Cumulative Revenue: **$16.7M**  
  - Cumulative Profit: **$8.67M**  
  - Profit margin stabilized ~**50%**
- **AOV:** Dashboard AOV ~**$87.10**; Combined approach suggests true AOV ≈ **$100** (average difference **$16.61** = $103.71 − $87.10).
- **Sales Volume:** Tracks buyer growth; 2025 growth appears negative due to partial-year data.

## 7) Scenario Illustration (from README)
- If prices increased **20%**:
  - Margin could rise from **~50%** to **~60%**
  - **Revenue** could exceed **$20M**
  - **Net profit** could reach **~$12M**
- (These figures are **scenario estimates** derived from current revenue and cost stability described in the README.)

## 8) Data Quality & Modeling Recommendations (from README)
- **Linkage Fixes:** Add **user IDs** and **order IDs** to **all** sales records in `Inventory Items`.  
- **Outcome:** Improves accuracy for **buyers**, **AOV**, and any order/customer-based metrics.  
- **Operational Note:** Prices and costs have been stable historically; consider strategic price adjustments to improve margin while monitoring conversion.

## 9) Visual References (same as README)
- **ERD**
<p align="left">
<img  height="520" width="720"
src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/ERD.png" 
alt="ERD"> 
</p>

- **KPI Dashboard**

<p align="left">
<img
src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/KPI%20Dashboard.png" 
alt="Main KPI Dashboard"> 
</p>

- **Annual revenue/profit comparison (with +20% price scenario)**

<p align="left">
<img height="400" width="520"
src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/Annual%20Comparison%20of%20CRP.png" 
alt="Annual Comparison of Revenue and Profit with a 20% Increase"> 
</p>
  
- **Annual sales volume & growth**

<p align="left">
<img height="250"
src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/Annual%20Sales%20Volume%20%26%20GR.png" 
alt="Annual Sales Volume and Growth Rate"> 
</p>

- **AOV comparison chart**

<p align="left">
<img height="250"
src="https://github.com/AIK-01/Data-Analysis/blob/main/Project-1%20-%3E%20Ecommerce%20Performance%20Analysis/Others/Images/ComparedAOV.png" 
alt="Comparison of AOV calculations with and without combined data"> 
</p>
