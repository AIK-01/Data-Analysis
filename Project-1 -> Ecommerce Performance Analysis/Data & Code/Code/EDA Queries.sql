-- EDA Queries

-- COUNTING TOTAL RECORDS --
-- --------------------------------------------------
SELECT COUNT(DISTINCT inventory_item_id) AS cnt /* {ordered items} contains | 181,038 | records. */
FROM ordered_items; 

SELECT COUNT(DISTINCT inventory_item_id) AS cnt /* {inventory items} contains | 490,910 | records. */
FROM inventory_items;

SELECT COUNT(DISTINCT order_id) AS cnt /* {orders} contains | 124,697 | records. */
FROM orders;

SELECT COUNT(DISTINCT id) AS cnt /* {users} contains | 100,000 | records. */
FROM users;
-- --------------------------------------------------



-- Checking is there any difference between the retail_price of {inventory items} and sale_price of {ordered items}. Ans: NO
SELECT ii.retail_price, oi.sale_price
FROM inventory_items ii
INNER JOIN ordered_items oi ON oi.product_id = ii.product_id
WHERE 
    ii.retail_price <> oi.sale_price
;



-- Checking if there any product_id mismatch for the same inventory_item_id between {inventory items} & {ordered items}... Ans: NO
SELECT ii.product_id, oi.product_id
FROM inventory_items ii
INNER JOIN ordered_items oi
    ON oi.inventory_item_id = ii.inventory_item_id
WHERE 
    oi.product_id <> ii.product_id
;



-- Checking if the user_id is CONSISTENT across {ordered items} & {orders}.... Ans: Yes
SELECT *
FROM ordered_items oi
INNER JOIN orders o
    ON o.order_id = oi.order_id
WHERE
    oi.user_id <> o.user_id
;



-- ------------------------------------------------------------------------------ ordered_items
-- ------------------------------------------------------------------------------
-- Logically creation_date should come before shipping_date, But if for some reason this logic gets reversed ( creation_date > shipping_date ) then we need to understand the reason behind it to ensure the integrity of the data. 
-- Here | 25,985 | DISTINCT order_id has shipping_date before creation_date ( creation_date > shipping_date ), while the day difference between these two dates of these orders are not more than 4. You can confirm it by running the inner query.
SELECT COUNT(*) total_num_of_rows
FROM (
SELECT 
    DISTINCT order_id,
    creation_date,
    shipping_date,
    datediff(creation_date, shipping_date) AS diff
FROM ordered_items                                
WHERE 
     creation_date > shipping_date
ORDER BY 
    diff DESC
) AS dif
;



-- This may help in understanding the creation_date of {orders}.
-- Unlike {ordered items}, NO | 0 | records found in the {orders} where the creation_date is after either of ( shipping_date, delivery_date, return_date).
-- This behavior suggest that the creation_date follows a strong sequencial policy in the {orders}. 
-- Which can be defined by this ( creation_date <= shipping_date <= delivery_date <= return_date )
SELECT 
    creation_date,
    shipping_date,
    delivery_date,
    return_date
FROM orders
WHERE
    creation_date > shipping_date
    OR
    shipping_date > delivery_date
    OR
    delivery_date > return_date
    OR
    shipping_date > delivery_date
    OR
    creation_date > delivery_date
    OR
    creation_date > return_date
    OR
    shipping_date > return_date
;



-- This may help in understanding the creation_date of {ordered items}.
-- There are | 424 | records where the creation_date is (4/3/2/1 day(s)) after the return date.
-- This behavior suggests that the creation_date can be at anytime in the product's supply & management lifecycle.
-- And that means the creation_date has No specific terms and policy applied. ( creation_date has No ties to `shipping_date <= delivery_date <= return_date` )
SELECT creation_date, shipping_date, delivery_date, return_date, datediff(creation_date, return_date) dif
FROM ordered_items
WHERE
    shipping_date > delivery_date
    OR
    delivery_date > return_date
    OR
    shipping_date > return_date
    OR 
    creation_date > return_date
--     creation_date < shipping_date
--     (creation_date > shipping_date
--     AND 
--     (
--     creation_date < delivery_date
--     OR 
--     creation_date < return_date
--     )
--     )
;



-- Checking how many days after the delivery, a customer returns the products. This helps determining the company's return-policy. Ans: Highest 3 days after delivery
SELECT DISTINCT datediff(return_date, delivery_date) AS Difference
FROM ordered_items oi
WHERE 
    return_date IS NOT NULL
ORDER BY
    1 DESC
;



-- -----------------------------------------------------------------------------------------------------------------------------------
-- -----------------------------------------------------------------------------------------------------------------------------------


-- Understanding different status category.
SELECT DISTINCT status
FROM ordered_items
;



SELECT DISTINCT status
FROM orders
;



/* About PROCESSING.
   The status of a record in the {ordered items}/{orders} is "Processing", when it has
   a `creation date` 
   BUT 
   NOT shipped & NOT delivered & NOT returned

*/ 
SELECT 
    creation_date,
    shipping_date,
    delivery_date,
    return_date
FROM ordered_items
WHERE 
    status = 'Processing'
    -- AND
--     (
--     shipping_date IS NOT NULL OR    
--     delivery_date IS NOT NULL OR
--     return_date   IS NOT NULL
--     )
;



/* About SHIPPED.
   The status of a record in the {ordered items}/{orders} is "Shipped", when it has
   a `creation date` & a `shipping date`
   BUT 
   NOT delivered & NOT returned
*/
SELECT 
    creation_date,
    shipping_date,
    delivery_date,
    return_date
FROM ordered_items
WHERE 
    status = 'Shipped'
    AND
    (
--     shipping_date IS NOT NULL OR    
    delivery_date IS NOT NULL OR
    return_date   IS NOT NULL
    )
;



/* About CANCELLED. 
   The status of a record in the {ordered items}/{orders} is "Cancelled", when it has
   a `creation date`
   BUT 
   NOT shipped & NOT delivered & NOT returned
   -- -- -- --- --- --- --- --- --- --
   -- --  Just like "PROCESSING".-- --
*/
SELECT 
    creation_date,
    shipping_date,
    delivery_date,
    return_date
FROM ordered_items
WHERE 
    status = 'Cancelled'
    AND
    (
    shipping_date IS NOT NULL OR    
    delivery_date IS NOT NULL OR
    return_date   IS NOT NULL
    )
;



/* About COMPLETE.
   The status of a record in the {ordered items}/{orders} is "Complete", when it has
   a `creation date` & a `shipping date` & a `delivery date`
   BUT 
   NOT returned
*/
SELECT 
    creation_date,
    shipping_date,
    delivery_date,
    return_date
FROM ordered_items
WHERE 
    status = 'Complete'
    AND
    (
--     shipping_date IS NOT NULL OR    
--     delivery_date IS NOT NULL OR
    return_date   IS NOT NULL
    )
;



/* About RETURNED.
   The status of a record in the {ordered items}/{orders} is "Returned", when it has
   a `creation date` & a `shipping date` & a `delivery date` & a `return date`
*/
SELECT 
    creation_date,
    shipping_date,
    delivery_date,
    return_date
FROM ordered_items
WHERE 
    status = 'Returned'
--     AND
--     (
--     shipping_date IS NOT NULL OR    
--     delivery_date IS NOT NULL OR
--     return_date   IS NULL
--     )
;


-- ------------------------

-- | 309,872 | inventory_item_id from {inventory items} doesn't exist in the {ordered items}. Among these | 309872 | inventory_item_ids 
-- | 181,802 | is already sold ( Accroding to {inventory items}) &
-- | 128,070 | is not sold (According to {inventory items})

SELECT COUNT(DISTINCT ii.inventory_item_id) AS cnt      -- 309,872
FROM inventory_items ii
LEFT JOIN ordered_items oi 
    ON oi.inventory_item_id = ii.inventory_item_id
WHERE oi.inventory_item_id IS NULL;

SELECT COUNT( DISTINCT inventory_item_id) AS cnt        -- 181,802
FROM inventory_items
WHERE sold_date IS NOT NULL;

SELECT COUNT(DISTINCT ii.inventory_item_id) AS cnt      -- 128,070 
FROM inventory_items ii
LEFT JOIN ordered_items oi 
    ON oi.inventory_item_id = ii.inventory_item_id
WHERE 
    sold_date IS NULL
    AND
    oi.inventory_item_id IS NULL
;



-- Ensuring that a single order_id has only a single category of status assigned in the {ordered items}.
SELECT order_id, COUNT(DISTINCT status) AS cnt
FROM ordered_items
GROUP BY 1
ORDER BY 2 DESC
;



-- (*__*) Both {ordered items} & {orders} have the same `shipping_date, delivery_date, return_date`. ------- 100% reliable data.--
SELECT 
    oi.shipping_date, o.shipping_date,
    oi.delivery_date, o.delivery_date,
    oi.return_date  , o.return_date
FROM ordered_items oi
INNER JOIN orders o
    ON oi.order_id = o.order_id
WHERE
    oi.shipping_date <> o.shipping_date
    OR
    oi.delivery_date <> o.delivery_date
    OR
    oi.return_date <> o.return_date
;
