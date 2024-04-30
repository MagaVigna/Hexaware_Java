-- 1. Retrieve the customer(s) with the highest account balance.
select c.customer_id, c.first_name, c.last_name, 
       (select max(balance) from accounts where customer_id = c.customer_id) as highest_balance
from customers c
order by highest_balance desc;

-- 2. Calculate the average account balance for customers who have more than one account.
select avg(balance) 
from (
    select c.customer_id, count(a.account_id) as num_accounts, sum(a.balance) as balance
    from customers c
    inner join accounts a on c.customer_id = a.customer_id
    group by c.customer_id
    having num_accounts > 1
);

-- 3. Retrieve accounts with transactions whose amounts exceed the average transaction amount.
select a.*
from accounts a
inner join transactions t on a.account_id = t.account_id
where t.amount > (select avg(amount) from transactions);

-- 4. Identify customers who have no recorded transactions.
select customer_id, first_name, last_name
from customers
where customer_id not in (
    select distinct c.customer_id
    from customers c
    inner join accounts a on c.customer_id = a.customer_id
    inner join transactions t on a.account_id = t.account_id
);

-- 5. Calculate the total balance of accounts with no recorded transactions.
select sum(balance) as total_balance_no_transactions
from accounts
where account_id not in (select account_id from transactions);

-- 6. Retrieve transactions for accounts with the lowest balance.
select t.*
from transactions t
inner join accounts a on t.account_id = a.account_id
where a.balance = (select min(balance) from accounts);

-- 7. Identify customers who have accounts of multiple types.
select c.customer_id, c.first_name, c.last_name
from customers c
inner join (select customer_id 
from accounts 
group by customer_id 
having count(distinct account_type) > 1) as multi_account_customers on c.customer_id = multi_account_customers.customer_id;

-- 8. Calculate the percentage of each account type out of the total number of accounts.
select account_type, 
       count(*) * 100/ (select count(*) from accounts) as percentage
from accounts
group by account_type;

-- 9. Retrieve all transactions for a customer with a given customer_id.
select t.*
from transactions t
where t.account_id in (select account_id from accounts where customer_id = 101);

-- 10. Calculate the total balance for each account type, including a subquery within the SELECT clause.
select account_type, 
       (select sum(balance) from accounts where account_type = a.account_type) as total_balance
from accounts a
group by account_type;
