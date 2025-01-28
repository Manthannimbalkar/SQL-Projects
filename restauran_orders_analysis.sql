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





