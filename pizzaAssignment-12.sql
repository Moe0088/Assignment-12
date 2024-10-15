CREATE TABLE `pizza` (
  `pizza_id` INT NOT NULL,
  `name` VARCHAR(50) NULL,
  `price` DECIMAL(5,2) NULL,
  PRIMARY KEY (`pizza_id`));
  
  insert into pizza(pizza_id, `name`, price)
  values(1, ' Pepperoni & Cheese ' , 7.99);
  
insert into pizza(pizza_id, `name`, price)
  values(2 , '  Vegetarian ' , 9.99);
  
insert into pizza(pizza_id, `name`, price)
  values(3 , ' Meat Lovers  ' , 14.99);
  
insert into pizza(pizza_id, `name`, price)
  values(4 , ' Hawaiian  ' , 12.99);
  
  select * from pizza;
  
  CREATE TABLE `customer` (
  `customer_id` INT NOT NULL,
  `customer_name` VARCHAR(50) NULL,
  `phone_number` VARCHAR(50) NULL,
  PRIMARY KEY (`customer_id`));
  
  insert into customer(customer_id, customer_name, phone_number)
  values(1 , ' Trevor Page ' , '226-555-4982');
  
   insert into customer(customer_id, customer_name, phone_number)
  values(2 , ' John Doe ' , '555-555-9498');
  
  select * from customer;
  
select * from orders;

alter table orders
add column customer_id INT,
ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

select * from orders;

insert into orders( order_id, order_date, amount, customer_id)
values (1 , ' 09/10/2023 09:47:00 ', 22.98, 1);

insert into orders( order_id, order_date, amount, customer_id)
values (2 , ' 09/10/2023 13:20:00' , 39.97, 2);

insert into orders( order_id, order_date, amount, customer_id)
values (3 , ' 09/10/2023 09:47:00' , 27.98, 1);


CREATE TABLE order_pizza (
    order_id INT,
    pizza_id INT,
    quantity INT,
    PRIMARY KEY (order_id, pizza_id),
    CONSTRAINT fk_orders FOREIGN KEY (order_id) REFERENCES `orders`(order_id),
    CONSTRAINT fk_pizza FOREIGN KEY (pizza_id) REFERENCES pizza(pizza_id)
);

insert into order_pizza( order_id, pizza_id, quantity)
values ( 1 , 1 , 1);

insert into order_pizza( order_id, pizza_id, quantity)
values ( 1 , 3 , 1);

insert into order_pizza( order_id, pizza_id, quantity)
values ( 2 , 2 , 1);

insert into order_pizza( order_id, pizza_id, quantity)
values ( 2 , 3 , 2);

insert into order_pizza( order_id, pizza_id, quantity)
values ( 3 , 3 , 1);

insert into order_pizza( order_id, pizza_id, quantity)
values ( 3 , 4 , 1);
  
select * from order_pizza;

CREATE TABLE customer_order (
    customer_id INT,
    order_id INT,
    PRIMARY KEY (customer_id, order_id),
    CONSTRAINT fk_customer_order_customer FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    CONSTRAINT fk_customer_order_order FOREIGN KEY (order_id) REFERENCES `orders`(order_id)
);


select * from customer_order;

insert into customer_order (customer_id, order_id)
values (1 , 1);

insert into customer_order (customer_id, order_id)
values (2 , 2);

insert into customer_order (customer_id, order_id)
values (1 , 3);

alter table orders
drop column amount;

select * from orders;
  
alter table orders
add column pizza_order VARCHAR(250);
  
UPDATE orders
SET pizza_order = '1x Pepperoni & Cheese Pizza, 1x Meat Lovers Pizza'
WHERE order_id = 1;

UPDATE orders
SET pizza_order = '1x Vegetarian Pizza, 2x Meat Lovers Pizza'
WHERE order_id = 2;

UPDATE orders
SET pizza_order = '1x Meat Lovers Pizza, 1x Hawaiian Pizza'
WHERE order_id = 3;


insert into orders( order_id , order_date, customer_id, pizza_order)

values( 4, ' 10/10/2023 10:37:00' , 2 , '3x Vegetarian Pizza, 1x Hawaiian Pizza');
  select * from customer;
  select * from orders;
 
  
  -- I need to show customer name with the order 
  
  select * from customer
  join orders on customer.customer_id = orders.customer_id;
  
  -- The restaurant wants to know which customer is spend the most money

select
c.customer_id,
c.customer_name, 
sum(p.price * op.quantity) as Total_spending
from `customer` c

JOIN `orders` o ON c.customer_id = o.customer_id
JOIN `order_pizza` op ON o.order_id = op.order_id
JOIN `pizza` p ON op.pizza_id = p.pizza_id

group by c.customer_id, c.customer_name;


  select 
  c.customer_name,
  c.customer_id,
 date(o.order_date) as Date_of_order_name_conclusion,
 
 sum(p.price * op.quantity) as Total_spending
 from `customer` c
 
 join `orders` o on  c.customer_id = o.customer_id
 join  `order_pizza` op on o.order_id = op.order_id
 join `pizza` p on op.pizza_id = p.pizza_id
 
 group by c.customer_name, date(o.order_date);
 
