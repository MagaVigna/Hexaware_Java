-- 1. Create the database named "HMBank"
create database HMBank;

-- 6. Write SQL scripts to create the mentioned tables with appropriate data types, constraints, and relationships.
use HMBank;

-- create the customers table
create table customers (
    customer_id int primary key,
    first_name varchar(50),
    last_name varchar(50),
    dob date,
    email varchar(100),
    phone_number varchar(20),
    address varchar(255)
);

-- create the accounts table
create table accounts (
    account_id int primary key,
    customer_id int,
    account_type varchar(20),
    balance decimal(15, 2),
    foreign key (customer_id) references customers(customer_id)
);

-- create the transactions table
create table transactions (
    transaction_id int primary key,
    account_id int,
    transaction_type varchar(20),
    amount decimal(15, 2),
    transaction_date date,
    foreign key (account_id) references accounts(account_id)
);
