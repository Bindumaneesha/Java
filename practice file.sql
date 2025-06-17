use production;
show databases;
-- 1
select*from brands;
-- 2
select * from products where list_price > 1000;

-- 6
select * from products
join categories on categories.category_id = products.category_id 
where category_name = 'Mountain Bikes';

-- 7
select count(product_id) from products;

-- 8
select * from products
order by list_price desc
limit 1;

-- 10
select * from products
where model_year = 2017;

-- AGGREGATION 
-- 1
select avg(list_price) from products ;

-- 2
select product_id ,sum(quantity) from stocks
group by product_id;
-- group by quantity;

-- 6
select category_id , avg(list_price) from products
group by category_id;

-- 8
select category_id , sum(list_price) from products
group by category_id;

-- 10
select sum(stocks.quantity) , products.model_year from stocks
join products on stocks.product_id = products.product_id
group by products.model_year;

select model_year,count(product_id) from products
group by model_year;



-- JOINS 
-- 5
select p.product_id , c.category_id , b.brand_id from products p 
join categories c on p.category_id = c.category_id
join brands b on p.brand_id = b.brand_id;

-- need to submit
-- 8
select p.product_id , sum(oi.quantity) as total_quantity from products p 
join sales.order_items oi on p.product_id = oi.product_id 
group by p.product_id;


-- SUBQUERIES
-- 2
select  distinct c.category_name , max(p.list_price) from products p
join categories c on p.category_id = c.category_id
where list_price >= ( select max(p.list_price) from products )
group by c.category_name;


/*select distinct c.category_name , max(p.list_price) from products p 
join categories c on p.category_id = c.category_id
group by c.category_name;*/








