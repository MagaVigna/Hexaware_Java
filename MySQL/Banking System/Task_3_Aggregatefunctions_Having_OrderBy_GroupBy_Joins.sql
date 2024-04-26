-- 1. Write a SQL query to Find the average account balance for all customers.
select avg(balance) as average_balance
from accounts;

-- 2. Write a SQL query to Retrieve the top 10 highest account balances.
select account_id, balance
from accounts
order by balance desc
limit 10;

-- 3. Write a SQL query to Calculate Total Deposits for All Customers in specific date.
select sum(amount) as total_deposits
from transactions
where transaction_type = 'deposit'
and transaction_date = '2024-04-01';

-- 4. Write a SQL query to Find the Oldest and Newest Customers.
select first_name, last_name, dob
from customers
order by dob;

-- 5. Write a SQL query to Retrieve transaction details along with the account type.
select t.*, a.account_type
from transactions t
inner join accounts a on t.account_id = a.account_id;

-- 6. Write a SQL query to Get a list of customers along with their account details.
select c.*, a.account_type, a.balance
from customers c
inner join accounts a on c.customer_id = a.customer_id;

-- 7. Write a SQL query to Retrieve transaction details along with customer information for a specific account.
select c.*, t.*
from customers c
inner join accounts a on c.customer_id = a.customer_id
inner join transactions t on a.account_id = t.account_id
where a.account_id = 101;

-- 8. Write a SQL query to Identify customers who have more than one account.
select c.customer_id, c.first_name, c.last_name, count(a.account_id) as num_accounts
from customers c
inner join accounts a on c.customer_id = a.customer_id
group by c.customer_id
having count(a.account_id) > 1;

-- 9. Write a SQL query to Calculate the difference in transaction amounts between deposits and withdrawals.
select account_id, sum(case when transaction_type = 'deposit' then amount else -amount end) as transaction_difference
from transactions
group by account_id;

-- 10. Write a SQL query to Calculate the average daily balance for each account over a specified period.
select account_id, avg(balance) as average_daily_balance
from accounts
group by account_id;

-- 11. Calculate the total balance for each account type.
select account_type, sum(balance) as total_balance
from accounts
group by account_type;

-- 12. Identify accounts with the highest number of transactions order by descending order.
select account_id, count(transaction_id) as num_transactions
from transactions
group by account_id
order by num_transactions desc;

-- 13. List customers with high aggregate account balances, along with their account types.
select c.customer_id, c.first_name, c.last_name, sum(a.balance) as total_balance
from customers c
inner join accounts a on c.customer_id = a.customer_id
group by c.customer_id
order by total_balance desc;

-- 14. Identify and list duplicate transactions based on transaction amount, date, and account.
select transaction_id, account_id, amount, transaction_date
from transactions
group by account_id, amount, transaction_date
having count(*) > 1;

