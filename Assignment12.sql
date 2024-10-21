CREATE database pizza_restaurant;
USE pizza_restaurant;

CREATE TABLE `pizza` (
  `pizza_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50),
  `price` DECIMAL(5,2)
);
  
INSERT INTO pizza( `name`, price)
  values('Pepperoni & Cheese', 7.99),
		('Vegetarian' , 9.99),
        (' Meat Lovers', 14.99),
        ('Hawaiian', 12.99)
	;
    
select * from pizza;


CREATE TABLE `customer` (
  `customer_id` INT NOT NULL  PRIMARY KEY AUTO_INCREMENT,
  `customer_name` VARCHAR(50) NULL,
  `phone_number` VARCHAR(25)NULL 
  );


  INSERT INTO customer (customer_id, customer_name, phone_number)
  values(1, 'Trevor Page', '226-555-4982');
  
 INSERT INTO customer (customer_id, customer_name, phone_number)
 values (2, 'John Doe', '555-555-9498');
		

CREATE TABLE `order` (
  `order_id` INT NOT NULL  PRIMARY KEY AUTO_INCREMENT,
  `order_date` DATETIME NULL,
  `customer_id` INT NOT NULL,
FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
  );


INSERT INTO `order`(order_id, order_date, customer_id)
values (1, '2023-10-09 09:47:00', 1),
       (2, '2023-10-09 13:20:00', 2),
       (3, '2023-10-09 09:47:00', 1),
       (4, '2023-10-10 10:37:00', 2);
       
       
select * from `customer`;
select * from `order`;
select * from pizza;

CREATE TABLE order_pizza (
    order_id INT NOT NULL,
    pizza_id INT NOT NULL,
    quantity INT NOT NULL,
   FOREIGN KEY (order_id) REFERENCES `order`(order_id),
   FOREIGN KEY (pizza_id) REFERENCES pizza(pizza_id)
);

INSERT INTO order_pizza( order_id, pizza_id, quantity)
values ( 1 , 1 , 1),
       ( 1 , 3 , 1),
       ( 2 , 2 , 1),
       ( 2 , 3 , 2),
       ( 3 , 3 , 1),
	     ( 3 , 4 , 1);
  
  -- The restaurant wants to know which customer is spend the most money

SELECT
c.customer_id,
c.customer_name, 
sum(p.price * op.quantity) as Total_spending
FROM `customer` c

JOIN `order` o ON c.customer_id = o.customer_id
JOIN `order_pizza` op ON o.order_id = op.order_id
JOIN `pizza` p ON op.pizza_id = p.pizza_id

GROUP BY c.customer_id, c.customer_name;

-- Show the customer info by the date

SELECT 
  c.customer_name,
  c.customer_id,
date(o.order_date) as Date_of_order,
  SUM(p.price * op.quantity) as Total_spending
from `customer` c

join `order` o on c.customer_id = o.customer_id
join `order_pizza` op on o.order_id = op.order_id
join `pizza` p on op.pizza_id = p.pizza_id

group by  c.customer_name, c.customer_id, date(o.order_date);

