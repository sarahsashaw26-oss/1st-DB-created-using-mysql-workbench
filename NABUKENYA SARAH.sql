create database smartbank_db;
use smartbank_db;

create table customers (
    customer_id int auto_increment primary key,
    first_name varchar(50),
    last_name varchar(50),
    phone varchar(20),
    email varchar(100),
    address varchar(150),
    join_date date
);

create table accounts (
account_id int auto_increment primary key,
customer_id int,
account_type enum ('Savings','Current', 'fixed'),
balance decimal (12,2),
date_opened date,
account_status varchar(20),
FOREIGN KEY (CUSTOMER_ID)
REFERENCES customers (customer_id)
);

create table employees (
    employee_id int auto_increment primary key,
    first_name varchar(50),
    last_name varchar(50),
    position varchar(50),
    branch_name varchar(100),
    hire_date date,
    salary decimal(12,2)
);

create table transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    transaction_type ENUM('Deposit','Withdrawal','Transfer'),
    amount DECIMAL(12,2),
    transaction_date DATE,
    employee_id INT,
    FOREIGN KEY (account_id)
    REFERENCES accounts(account_id),
    FOREIGN KEY (employee_id)
    REFERENCES employees(employee_id)
);

CREATE TABLE loans (
    loan_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id int,
    loan_type varchar(50),
    loan_amount decimal(12,2),
    interest_rate decimal(5,2),
    issue_date date,
    repayment_status varchar(30),
    foreign key (customer_id)
    references customers(customer_id)
);

insert into customers
(first_name,last_name,phone,email,address,join_date)
VALUES
('Sarah','Nabukenya','0702879416','sarahsashaw26@gmail.com','Mukono','2025-01-10'),
('Aaron','Amanya','0701111111','aaron@gmail.com','Nsambya','2024-02-15'),
('Joviah','Mpagi','0702222222','joviah6@gmail.com','Jinja','2024-03-20'),
('Vicky','Prosper','0703333333','vkpros@gmail.com','Mbarara','2024-05-18'),
('Peace','Esther','0704444444','mesther@gmail.com','Gulu','2024-08-25');

insert into accounts
(customer_id,account_type,balance,date_opened,account_status)
VALUES
(1,'Savings',5000000,'2025-01-10','Active'),
(2,'Current',2500000,'2024-02-15','Active'),
(3,'Savings',3000000,'2024-03-20','Active'),
(4,'Fixed',10000000,'2024-05-18','Active'),
(5,'Savings',1500000,'2024-08-25','Dormant');

INSERT INTO employees
(first_name,last_name,position,branch_name,hire_date,salary)
VALUES
('Dauglas','Lubega','Manager','Kampala','2020-01-05',3500000),
('Jackie','Nakanwagi','Teller','Mukono','2021-06-10',1800000),
('Angel','Lubega','Accountant','Jinja','2022-04-15',2500000),
('Emma','Bukenya','Loan Officer','Gulu','2021-11-20',2200000),
('Gordon','Mugisha','Customer Care','Mbarara','2023-02-01',1700000);

insert into transactions
(account_id,transaction_type,amount,transaction_date,employee_id)
values
(1,'Deposit',500000,'2026-01-05',2),
(2,'Withdrawal',300000,'2026-01-06',2),
(3,'Deposit',1000000,'2026-01-07',3),
(4,'Transfer',2000000,'2026-01-08',1),
(5,'Deposit',400000,'2026-01-09',5);

insert into loans
(customer_id,loan_type,loan_amount,interest_rate,issue_date,repayment_status)
values
(1,'Business',5000000,12.5,'2025-06-01','Ongoing'),
(2,'Personal',3000000,10.0,'2025-07-10','Paid'),
(3,'Education',4000000,11.0,'2025-08-15','Ongoing'),
(4,'Mortgage',15000000,9.5,'2025-09-20','Ongoing'),
(1,'Agriculture',2500000,8.0,'2025-11-05','Paid');


SELECT * FROM customers;
SELECT account_id, account_type, balance
from accounts;
select *
from accounts
where balance >3000000;
select *
from transactions
where account_id = 1;
SELECT c.first_name,
       c.last_name,
       a.account_type
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id;

select c.customer_id,
       c.first_name,
       c.last_name,
       sum(a.balance) as total_balance
from customers c
join accounts a
on c.customer_id = a.customer_id
group by c.customer_id;

select distinct c.first_name,
       c.last_name
from customers c
join loans l
on c.customer_id = l.customer_id;

select t.transaction_id,
       t.transaction_type,
       t.amount,
       e.first_name,
       e.last_name
from transactions t
join employees e
on t.employee_id = e.employee_id;

select c.first_name,
       c.last_name
from customers c
left join loans l
on c.customer_id = l.customer_id
where l.loan_id is null;

select *
from accounts
order by balance desc
limit 1; 

select account_id,
       COUNT(*) as total_transactions
from transactions
Group by account_id;

select SUM(loan_amount) as total_loans
from loans;