-- Order Table Overview --

-- Total Orders

select count(*) 
from order_details;

-- Total Unique Orders

select count(distinct(order_id)) as unique_orders
from order_details;

-- Items ordered by one order

select
    item_count as "items per order",
    count(order_id) as "order count"
from
   (
   select
      order_id,
      count(item_id) as item_count
	from order_details
    group by order_id
) subquery
group by item_count
order by item_count;

-- Menu Table Overview --

-- Total Menu Items

select count(*) 
from menu_items;

-- Total Category

select count(distinct(category))
from menu_items;

-- Costliest Product

select item_name, max(price) as highest_price
from menu_items
group by item_name
order by highest_price desc
limit 1;


-- Q1 What were the least and most ordered items? What categories were they in?

select mi.item_name, mi.category, count(od.item_id) as total orders
from order_details od
left join menu_items mi on mi.menu_item_id = od.item_id
order by total_orders desc
limit 1;

--Note: for least sold item replace desc with asc


-- Q2 What do the highest spend orders look like? Which items did they buy and how much did they spend?

SELECT 
    od.order_id,
    GROUP_CONCAT(mi.item_name) AS items_purchased,
    COUNT(mi.item_name) AS item_count,
    ROUND(SUM(mi.price),2) AS total_spent
FROM 
    order_details AS od
JOIN 
    menu_items AS mi
ON 
    od.item_id = mi.menu_item_id
GROUP BY 
    od.order_id
ORDER BY 
    total_spent DESC
LIMIT 1;

-- Q3 Were there certain times that had more or less orders?

SELECT 
    HOUR(STR_TO_DATE(order_time, '%h:%i:%s %p')) AS order_hour,
    COUNT(DISTINCT order_id) AS total_orders
FROM 
    order_details
GROUP BY 
    HOUR(STR_TO_DATE(order_time, '%h:%i:%s %p'))
ORDER BY 
    total_orders DESC;

-- Q4 Which cuisines should we focus on developing more menu items for based on the data?

SELECT 
    mi.category AS cuisine,
    COUNT(od.item_id) AS total_orders
FROM 
    order_details od
JOIN 
    menu_items mi
ON 
    od.item_id = mi.menu_item_id
GROUP BY 
    mi.category
ORDER BY 
    total_orders DESC;
