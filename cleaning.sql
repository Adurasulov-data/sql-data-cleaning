CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    full_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(50),
    address TEXT,
    birth_date VARCHAR(50),
    gender CHAR(1)
);


INSERT INTO customers (customer_id, full_name, email, phone, address, birth_date, gender) VALUES
(1, 'John Doe', 'johndoe@gmailcom', '123-456-7890', '123 Main St', '1985-04-23', 'M'),
(2, 'Jane, Smith', 'jane.smith@email.com', '987654321', '45 Elm St', '1990/12/05', 'F'),
(3, 'Robert Brown', 'robertbrown@domain', NULL, '78 Oak St', '1988-07-15', 'M'),
(4, 'Emily Davis', 'emily.davis@email.com', '555-123-4567', 'NULL', '1983-09-30', 'F'),
(5, 'Michael! White', 'michael.white@email..com', '321.654.0987', '90 Pine St', '1980-02-29', 'M'),
(6, 'Anna Green', '', '555-777-9999', '12 Maple St', '1995-06-21', 'F'),
(7, 'NULL', 'charles.miller@email.com', '555-888-0000', '45 Oak St', '1979-11-11', 'M'),
(8, 'Chris Adams', 'chrisadams@email.com', 'NULL', 'NULL', '2000-03-05', 'M'),
(9, 'Patricia Reed', 'patricia.reed@email.com', '555.666.3333', '89 Birch St', '1992-08-18', 'F'),
(10, 'Daniel! Clark', 'danielclark@email,com', '444*555*6666', '77 Cedar St', '1987-01-07', 'M'),
(11, 'David "Owen"', 'davidowen@email.com', '555-999-1111', '23 Cherry St', '1993-04-29', 'M'),
(12, 'NULL', 'julia.moore@email.com', 'NULL', '56 Spruce St', '1981-05-12', 'F'),
(13, 'Olivia Hall', 'oliviahall@em@il.com', '555-222-3333', 'NULL', '1978-10-14', 'F'),
(14, 'George King', 'george.king@email.com', 'NULL', 'NULL', '1999-07-21', 'M'),
(15, 'Emma Scott', 'emmascott@email.com', '555-444-7777', '22 Walnut St', '2001-02-28', 'F'),
(16, 'Lucas Young', 'lucasyoung@email.com', '666-777-8888', '10 Fir St', '1994-09-10', 'M'),
(17, 'Sophia Carter', 'sophia.carter@email.com', '777-888-9999', 'NULL', '1996-12-31', 'F'),
(18, 'William Nelson', 'williamnelson@email.com', 'NULL', '5 Willow St', '1982-06-03', 'M'),
(19, 'Ava Baker', 'ava.baker@email.com', '555-111-2222', '78 Redwood St', '1989-03-09', 'F'),
(20, 'James Wright', 'jameswright@email.com', '444-222-1111', '31 Oak St', '1991-11-25', 'M'),
(21, 'John Doe', 'johndoe@gmailcom', '123-456-7890', '123 Main St', '1985-04-23', 'M'),
(22, 'Jane, Smith', 'jane.smith@email.com', '987654321', '45 Elm St', '1990/12/05', 'F'),
(23, 'Michael! White', 'michael.white@email..com', '321.654.0987', '90 Pine St', '1980-02-29', 'M'),
(24, 'Emma Scott', 'emmascott@email.com', '555-444-7777', '22 Walnut St', '2001-02-28', 'F'),
(25, 'Daniel! Clark', 'danielclark@email,com', '444*555*6666', '77 Cedar St', '1987-01-07', 'M');


select * from customers


--Finding and removing duplicates
---------------------------------------------------
WITH CTE AS (    SELECT *, ROW_NUMBER() OVER (PARTITION BY full_name, email ORDER BY customer_id) AS DuplicatesFound    FROM customers)
SELECT * FROM CTE WHERE DuplicatesFound > 1;

WITH CTE AS (    SELECT *, ROW_NUMBER() OVER (PARTITION BY full_name, email ORDER BY customer_id) AS DuplicatesFound    FROM customers)
DELETE FROM CTE WHERE DuplicatesFound > 1;
----------------------------------------------------
----------------------------------------------------


--full_name
---------------------------------------------------
select full_name, replace(replace(replace(full_name, ',', ''),'!',''),'"','')
from customers

select full_name, translate(full_name, ',!"', '   ')
from customers

update customers
set full_name = lower(replace(replace(replace(full_name, ',', ''),'!',''),'"',''))

select concat(parsename(replace(email, '@', '.'),4),' ' ,parsename(replace(email, '@', '.'),3))
from customers
where customer_id in (7, 12)

update customers
set full_name = concat(parsename(replace(email, '@', '.'),4),' ' ,parsename(replace(email, '@', '.'),3))
where customer_id in (7, 12)
----------------------------------------------------
----------------------------------------------------
select * from customers

--email
----------------------------------------------------
SELECT email, REPLACE(email, '@gmailcom', '@gmail.com') AS corrected_email
FROM customers
WHERE email LIKE '%@gmailcom'

update customers
set email = REPLACE(email, '@gmailcom', '@gmail.com')
WHERE email LIKE '%@gmailcom'

select email, replace(email, '@em@il.com','@email.com')
from customers
where email like '%@%@%'

update customers
set email = replace(email, '@em@il.com','@email.com')
where email like '%@%@%'

select REPLACE(email, 'main','main.com')
from customers
where email like '%domain'


update customers
set email = REPLACE(email, 'main','main.com')
where email like '%domain'

update customers
set email = 'unknown'
where customer_id = 6


select email, replace(replace(email, ',', '.'),'..','.')
from customers

update customers
set email = replace(replace(email, ',', '.'),'..','.')

----------------------------------------------------
----------------------------------------------------
select * from customers

--phone
----------------------------------------------------
select translate(phone, '.*', '--')
from customers

update customers
set phone = translate(phone, '.*', '--')

update customers
set phone = 'unknown'
where phone is null or phone = 'NULL'

select phone, concat(left(phone,3),'-',SUBSTRING(phone, 3,3),'-',RIGHT(phone, 3))
from customers
where customer_id = 2

update customers
set phone = concat(left(phone,3),'-',SUBSTRING(phone, 3,3),'-',RIGHT(phone, 3))
where customer_id = 2
----------------------------------------------------
----------------------------------------------------

select * from customers
--address
----------------------------------------------------
update customers
set address = 'unknown'
where address is null or address = 'NULL'

update customers
set address = LOWER(address)
----------------------------------------------------
----------------------------------------------------


--birth_date
----------------------------------------------------
select replace(birth_date, '/','-')
from customers

update customers
set birth_date = replace(birth_date, '/','-')
----------------------------------------------------
----------------------------------------------------


--gender
----------------------------------------------------
select gender, lower(gender)
from customers

update customers
set gender = LOWER(gender)
----------------------------------------------------
----------------------------------------------------


select * from customers


--Data Type
----------------------------------------------------
SELECT COLUMN_NAME, DATA_TYPE  
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customers';
----------------------------------------------------
----------------------------------------------------


--Changing data type
----------------------------------------------------
ALTER TABLE customers ALTER COLUMN address NVARCHAR(100)

ALTER TABLE customers ALTER COLUMN birth_date date
----------------------------------------------------
----------------------------------------------------