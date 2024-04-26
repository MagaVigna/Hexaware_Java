-- 1. Insert at least 10 sample records into each of the following tables. • Customers • Accounts • Transactions

insert into customers  values
  (101, 'Rajesh', 'Kumar', '1988-05-12', 'rajesh.kumar@example.com', '9876543210', '21 GAV Nagar, Delhi'),
  (102, 'Priya', 'Sharma', '1992-08-25', 'priya.sharma@example.com', '8765432109', '37 ABC, Mumbai'),
  (103, 'Amit', 'Patel', '1985-02-17', 'amit.patel@example.com', '7654321098', '8 Sector 22, Chandigarh'),
  (104, 'Sneha', 'Singh', '1990-11-30', 'sneha.singh@example.com', '6543210987', '15 CVB Road, Kolkata'),
  (105, 'Neha', 'Gupta', '1995-04-08', 'neha.gupta@example.com', '5432109876', '42 MG Road, Bangalore'),
  (106, 'Vikram', 'Yadav', '1982-12-10', 'vikram.yadav@example.com', '4321098765', '3 NBV Nagar, Pune'),
  (107, 'Shikha', 'Verma', '1987-09-22', 'shikha.verma@example.com', '3210987654', '12 GFDr, Lucknow'),
  (108, 'Rahul', 'Mishra', '1993-06-14', 'rahul.mishra@example.com', '2109876543', '25 YTRg, Jaipur'),
  (109, 'Anjali', 'Sinha', '1980-03-19', 'anjali.sinha@example.com', '1098765432', '51 REW, Nagpur'),
  (110, 'Vivek', 'Rajput', '1984-07-05', 'vivek.rajput@example.com', '9876543210', '6 Station Road, Ahmedabad');


insert into accounts  values
  (201, 101, 'savings', 50000.00),
  (202, 101, 'current', 25000.00),
  (203, 102, 'savings', 75000.00),
  (204, 102, 'current', 100000.00),
  (205, 103, 'savings', 30000.00),
  (206, 103, 'current', 45000.00),
  (207, 104, 'savings', 200000.00),
  (208, 104, 'current', 80000.00),
  (209, 105, 'savings', 10000.00),
  (210, 105, 'current', 5000.00);


insert into transactions values
  (1001, 201, 'deposit', 15000.00, '2024-04-01'),
  (1002, 202, 'withdrawal', 5000.00, '2024-04-02'),
  (1003, 203, 'deposit', 20000.00, '2024-04-03'),
  (1004, 204, 'withdrawal', 10000.00, '2024-04-04'),
  (1005, 205, 'deposit', 5000.00, '2024-04-05'),
  (1006, 206, 'withdrawal', 2000.00, '2024-04-06'),
  (1007, 207, 'deposit', 100000.00, '2024-04-07'),
  (1008, 208, 'withdrawal', 30000.00, '2024-04-08'),
  (1009, 209, 'deposit', 3000.00, '2024-04-09'),
  (1010, 210, 'withdrawal', 1000.00, '2024-04-10');


-- 2. Write SQL queries for the following tasks:
   --1. Write a SQL query to retrieve the name, account type and email of all customers.
          select c.first_name, c.last_name, a.account_type, c.email
          from customers c
          inner join accounts a on c.customer_id = a.customer_id;
      
   -- 2. Write a SQL query to list all transaction corresponding customer.
          select c.first_name, c.last_name, t.*
          from customers c
          inner join accounts a on c.customer_id = a.customer_id
          inner join transactions t on a.account_id = t.account_id;

   -- 3. Write a SQL query to increase the balance of a specific account by a certain amount.
          update accounts
          set balance = balance + 5000
          where account_id = 101;


   -- 4. Write a SQL query to Combine first and last names of customers as a full_name.
          select concat(c.first_name, ' ', c.last_name) as full_name
          from customers c;

   -- 5. Write a SQL query to remove accounts with a balance of zero where the account type is savings.
          delete from accounts
          where balance = 0 and account_type = 'savings';

   -- 6. Write a SQL query to Find customers living in a specific city.
          select *
          from customers
          where address like '%Delhi%';

   -- 7. Write a SQL query to Get the account balance for a specific account.
          select balance
          from accounts
          where account_id = 102;

   -- 8. Write a SQL query to List all current accounts with a balance greater than $1,000.
          select *
          from accounts
          where account_type = 'current' and balance > 1000;

   -- 9. Write a SQL query to Retrieve all transactions for a specific account.
          select *
          from transactions
          where account_id = 103;

   -- 10. Write a SQL query to Calculate the interest accrued on savings accounts based on given interest rate.
          select account_id, balance * 0.05 as interest_accrued
          from accounts
          where account_type = 'savings';

   -- 11. Write a SQL query to Identify accounts where the balance is less than a specified overdraft limit.
          select *
          from accounts
          where balance < -500;

   -- 12. Write a SQL query to Find customers not living in a specific city.
          select *
          from customers
          where address not like '%Mumbai%';
