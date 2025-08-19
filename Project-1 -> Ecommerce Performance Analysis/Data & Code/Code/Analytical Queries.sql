-- Analytical Queries

-- 1. User Acquisition (MoM)
SELECT 
    year(creation_date) AS Year,
    month(creation_date) AS Month,
    count(id) AS num_of_new_users
FROM
    users
GROUP BY
    1,
    2
ORDER BY
    1,
    2
;





-- 2. New Customer(Buyer) acquisition (MoM) according to {ordered items} only. 
-- Unfortunately, {inventory items} couldn't be used as it has no information about user_id.
WITH ps AS (
SELECT 
    year(shipping_date) AS Year,
    month(shipping_date) AS Month,
    user_id,
    shipping_date,
    ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY shipping_date) AS purchase_number
FROM ordered_items
WHERE
    status IN ('Complete', 'Shipped', 'Returned')
ORDER BY 3, 5
) 

SELECT 
    Year,
    Month,
    COUNT(*) AS total_new_buyers
FROM ps
WHERE purchase_number = 1
GROUP BY 1, 2 
ORDER BY 1, 2
;





-- 3. Total Customers/Buyers (MoM) according to {ordered items} only.
SELECT 
    year(shipping_date) AS Year,
    month(shipping_date) AS Month,
    COUNT(DISTINCT user_id) AS Total_Customers
FROM 
    ordered_items
WHERE
    status IN ('Complete', 'Shipped', 'Returned')
GROUP BY 1, 2
ORDER BY 1, 2
;




-- 4. Combined Total Customers (MoM) according to { inventory items + ordered items }.
WITH
    oi AS 
    (
    SELECT 
    year(shipping_date) AS Year,
    month(shipping_date) AS Month,
    COUNT(DISTINCT user_id) AS Total_Customers
FROM 
    ordered_items
WHERE
    status IN ('Complete', 'Shipped', 'Returned')
GROUP BY 1, 2
ORDER BY 1, 2
    ),

    ii AS 
    (
    SELECT 
        year(sold_date) AS Year,
        month(sold_date) AS Month,
        COUNT(*)/2 AS Total_Customers
    FROM 
        inventory_items
    WHERE sold_date IS NOT NULL
    GROUP BY 1, 2
    ORDER BY 1, 2
    )

SELECT 
    ii.Year,
    ii.Month,
    TRUNCATE((oi.Total_Customers + ii.Total_Customers), 0) AS Total_Customers
FROM
    ii
INNER JOIN oi 
    ON  ii.Year = oi.Year 
        AND
        ii.Month = oi.Month
ORDER BY
    1,
    2
;


-- 5. Sales Revenue + Profit + Cost + Sales Volume (MoM) According to {ordered items + inventory items}. ----- Excluding [[Returned]] products.
SELECT 
    year(COALESCE(shipping_date, sold_date)) AS Year,
    month(COALESCE(shipping_date, sold_date)) AS Month,
    SUM(ii.retail_price) AS Gross_revenue,
    (SUM(ii.retail_price) - SUM(ii.cost)) AS Gross_profit,
    SUM(ii.cost) AS Cost,
    COUNT(ii.inventory_item_id) AS Sales_volume
FROM
    inventory_items ii
LEFT JOIN ordered_items oi
    ON ii.inventory_item_id = oi.inventory_item_id
WHERE
    oi.status IN ('Complete', 'Shipped')
    OR 
    ii.sold_date IS NOT NULL
GROUP BY
    1,
    2
ORDER BY 
    1,
    2
;





-- 6. Average Order Value (AOV) according to {ordered items} only.
-- Unfortunately, {inventory items} couldn't be used as it has no information about number of orders.
SELECT 
    year(oi.shipping_date) AS Year,
    month(oi.shipping_date) AS Month,
    SUM(sale_price) AS total_gross_revenue,
    COUNT(DISTINCT o.order_id) AS total_num_of_orders,
    ROUND((SUM(sale_price) / COUNT(DISTINCT o.order_id)), 2) AS AOV
FROM ordered_items oi
INNER JOIN orders o
    ON o.order_id = oi.order_id
WHERE
    o.status IN ('Complete', 'Shipped', 'Returned')
GROUP BY
    1,2
ORDER BY
    1,2 
;





-- 7. Combined Average Order Value (AOV) according to { ordered items + invenotry Items }
WITH 
    oi AS -- CTE 1
    (
    SELECT 
        year(o.shipping_date) AS Year,
        month(o.shipping_date) AS Month,
        SUM(oi.sale_price) AS TTV, -- Total Transaction Value
        COUNT(DISTINCT o.order_id) AS num_of_ord
    FROM orders o
    INNER JOIN ordered_items oi
        ON oi.order_id = o.order_id
    WHERE 
        o.status IN ('Complete', 'Shipped', 'Returned')
    GROUP BY
        1,2
    ),
    
    ii AS -- CTE 2
    (
    SELECT 
        year(sold_date) AS Year,
        month(sold_date) AS Month,
        SUM(retail_price) AS TTV, -- Total Transaction Value
        COUNT(*)/2 AS num_of_ord
    FROM inventory_items
    WHERE 
        sold_date IS NOT NULL
    GROUP BY
        1,2
    )
SELECT 
    ii.Year,
    ii.Month,
    -- oi.TTV + ii.TTV AS TTV,
    -- oi.num_of_ord + ii.num_of_ord AS num_of_ord,
    TRUNCATE((oi.TTV + ii.TTV)/(oi.num_of_ord + ii.num_of_ord),2) AS AOV
FROM ii
INNER JOIN oi 
    ON  oi.Year = ii.Year 
        AND
        oi.Month = ii.Month
ORDER BY
    1,
    2
;





-- 8. Current Annual Cost, Revenue, Profit comparison with 20% Product Price Increase. ----- Excluding [[Returned]] products.
SELECT 
    year(COALESCE(shipping_date, sold_date)) AS Year,
    SUM(ii.cost) AS Cost,
    SUM(ii.retail_price) AS Revenue,
    (SUM(ii.retail_price) - SUM(ii.cost)) AS Profit,
    SUM(ii.retail_price*1.2) AS `Revenue(120%)`,
    (SUM(ii.retail_price*1.2) - SUM(ii.cost)) AS `Profit(120%)`
FROM
    inventory_items ii
LEFT JOIN ordered_items oi
    ON ii.inventory_item_id = oi.inventory_item_id
WHERE
    oi.status IN ('Complete', 'Shipped')
    OR 
    ii.sold_date IS NOT NULL
GROUP BY
    1
ORDER BY 
    1
;
