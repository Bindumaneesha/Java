
-- CREATE SCHEMA bikestores;

-- CREATE SCHEMA bikestores;

create database bikestores;
use bikestores;
-- create tables
CREATE TABLE bikestores.categories (
	category_id INT  ( 1) PRIMARY KEY,
	category_name VARCHAR (255) NOT NULL
);


CREATE TABLE bikestores.brands (
	brand_id INT ( 1) PRIMARY KEY,
	brand_name VARCHAR (255) NOT NULL
);

CREATE TABLE bikestores.products (
	product_id INT (1) PRIMARY KEY,
	product_name VARCHAR (255) NOT NULL,
	brand_id INT NOT NULL,
	category_id INT NOT NULL,
	model_year SMALLINT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	FOREIGN KEY (category_id) REFERENCES bikestores.categories (category_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (brand_id) REFERENCES bikestores.brands (brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);

drop table if exists customers;
CREATE TABLE bikestores.customers (
	customer_id INT  PRIMARY KEY auto_increment,
	first_name VARCHAR (255) NOT NULL,
	last_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255) NOT NULL,
	street VARCHAR (255),
	city VARCHAR (50),
	state VARCHAR (25),
	zip_code VARCHAR (5)
);

CREATE TABLE bikestores.stores (
	store_id INT PRIMARY KEY,
	store_name VARCHAR (255) NOT NULL,
	phone VARCHAR (25),
	email VARCHAR (255),
	street VARCHAR (255),
	city VARCHAR (255),
	state VARCHAR (10),
	zip_code VARCHAR (5)
);


CREATE TABLE bikestores.staffs (
	staff_id INT ( 1) PRIMARY KEY,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	email VARCHAR (255) NOT NULL UNIQUE,
	phone VARCHAR (25),
	active tinyint NOT NULL,
	store_id INT NOT NULL,
	manager_id INT,
	FOREIGN KEY (store_id) REFERENCES bikestores.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (manager_id) REFERENCES bikestores.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);
drop table if exists orders;
CREATE TABLE bikestores.orders (
	order_id INT (1) PRIMARY KEY auto_increment,
	customer_id INT,
	order_status tinyint NOT NULL,
	-- Order status: 1 = Pending; 2 = Processing; 3 = Rejected; 4 = Completed
	order_date DATE NOT NULL,
	required_date DATE NOT NULL,
	shipped_date DATE,
	store_id INT NOT NULL,
	staff_id INT NOT NULL,
	FOREIGN KEY (customer_id) REFERENCES bikestores.customers (customer_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (store_id) REFERENCES bikestores.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (staff_id) REFERENCES bikestores.staffs (staff_id) ON DELETE NO ACTION ON UPDATE NO ACTION
);

drop table if exists order_items;
CREATE TABLE bikestores.order_items (
	order_id INT auto_increment,
	item_id INT,
	product_id INT NOT NULL,
	quantity INT NOT NULL,
	list_price DECIMAL (10, 2) NOT NULL,
	discount DECIMAL (4, 2) NOT NULL DEFAULT 0,
	PRIMARY KEY (order_id, item_id),
	FOREIGN KEY (order_id) REFERENCES bikestores.orders (order_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES bikestores.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE bikestores.stocks (
	store_id INT,
	product_id INT,
	quantity INT,
	PRIMARY KEY (store_id, product_id),
	FOREIGN KEY (store_id) REFERENCES bikestores.stores (store_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (product_id) REFERENCES bikestores.products (product_id) ON DELETE CASCADE ON UPDATE CASCADE
);

use bikestores;
-- select * from stocks;
-- alter table stocks modify column store_id int auto_increment;

-- alter table order_items modify column item_id int auto_increment;