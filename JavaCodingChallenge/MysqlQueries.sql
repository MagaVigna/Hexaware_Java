create database order_management;

use order_management;

create table product (
    productid int AUTO_INCREMENT primary key,
    productname varchar(255),
    description text,
    price double,
    quantityinstock int,
    type varchar(50),
    brand varchar(100), 
    warrantyperiod int, 
    size varchar(20), 
    color varchar(20) 
);

create table user (
    userid int AUTO_INCREMENT primary key,
    username varchar(50),
    password varchar(50),
    role varchar(20),
	constraint chk_role check (role IN ('admin', 'user'))

);

create table orders (
    order_id int AUTO_INCREMENT primary key,
    user_id int not null,
    product_id int not null,
    quantity int not null,
    foreign key (user_id) references user(userid),
    foreign key (product_id) references product(productid)
);

insert into product (productid, productname, description, price, quantityinstock, type, brand, warrantyperiod, size, color) values
(1, 'Laptop', 'Gaming Laptop', 1200.00, 10, 'Electronics', 'Dell', 2, null, null),
(2, 'T-shirt', 'cotton t-shirt', 20.00, 50, 'Clothing', null, null, 'Medium', 'Blue'),
(3, 'Smartphone', 'Latest smartphone', 800.00, 20, 'Electronics', 'Samsung', 1, null, null);

insert into user (userid, username, password, role) values
(1, 'admin', 'admin123', 'Admin'),
(2, 'user1', 'password123', 'User'),
(3, 'user2', 'qwerty', 'User');
