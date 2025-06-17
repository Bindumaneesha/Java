use sales;
-- 3
select * from customers where city ="New York";
-- 4
select first_name, last_name , email from customers;
-- 5
select * from orders
where year(order_date) = 2016;

-- 9 
select first_name , last_name , order_id from orders
join customers on orders.customer_id = customers.customer_id;


-- AGGREGATION
-- 3
select s.store_name , sum(quantity*oi.list_price*(1-oi.discount/100)) as total_sales_amount
from sales.order_items oi
join sales.orders o on oi.order_id = o.order_id
join sales.stores s on o.store_id = s.store_id
group by s.store_name;


-- 4
select customer_id , count(order_id) from orders
group by customer_id;


-- 5
select sum(discount) from order_items
group by order_id;
-- select * from order_items;
-- desc order_items;

-- 7 
select month(order_date) , count(order_id) from orders
where year(order_date) =  2016
group by month(order_date);

-- 9
select  state , count(customer_id) from customers
group by state;

-- JOINS
-- 1
select o.order_id, o.order_date ,p.product_id from orders o 
join sales.order_items oi on o.order_id = oi.order_id
join production.products p on oi.product_id = p.product_id;


-- 2
use sales;
select * from orders o
join customers c on o.customer_id = c.customer_id
group by o.order_id;

-- 3
-- use production;
select p.product_id , o.order_id from production.products p
left join sales.order_items o on p.product_id = o.product_id
where o.product_id is null;

-- 4
select st.store_id , s.staff_id , o.order_id from orders o 
join stores st on o.store_id = st.store_id
join staffs s on o.staff_id = s.staff_id;


-- 6
select c.customer_id, c.first_name , c.last_name from customers c
join orders o on c.customer_id = o.customer_id
join order_items oi on o.order_id = oi.order_id
group by c.customer_id , c.first_name
having count(oi.order_id) > 5;

-- need to submit 
-- 7 
select o.order_id ,c.customer_id , s.state from orders o 
join customers c on o.customer_id = c.customer_id 
join stores s on o.store_id = s.store_id 
where s.state = 'CA'
group by o.order_id;

-- 9
select ot.order_id , p.product_id , c.category_id , c.category_name from order_items ot
left join production.products p on ot.product_id = p.product_id 
join production.categories c on p.category_id = c.category_id
right join orders o on ot.order_id = o.order_id
where c.category_name = 'Electric Bikes';


-- 10
select sum(ot.discount*ot.quantity) as total_discount , ot.order_id from order_items ot
join orders o on ot.order_id = o.order_id 
group by ot.order_id; 


-- SUBQUERIES
-- 1
/*select list_price from order_items
limit 2 offset 1; */

select max(list_price) as secondprice from order_items
where list_price < (select max(list_price) from order_items);

-- 3 
select o.order_id , c.customer_id from orders o
right join customers c on o.customer_id = c.customer_id 
where  o.order_id is null;

-- jdbc
use sales;
select o.order_id ,count(s.store_id) from stores s
join orders o on s.store_id = o.store_id
group by o.order_id
limit 5;


/*select * from orders
order by store_id desc;*/




