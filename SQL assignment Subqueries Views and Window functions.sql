/*Consider the Country table and Persons table that you created earlier and perform the following: 
1. Find the number of persons in each country. 
2. Find the number of persons in each country sorted from high to low. 
3. Find out an average rating for Persons in respective countries if the average is greater than 3.0 
4. Find the countries with the same rating as the USA. (Use Subqueries) 
5. Select all countries whose population is greater than the average population of all nations.
 Create a database named Product and create a table called Customer with the following fields in the 
 Product database: Customer_Id - Make PRIMARY KEY First_name Last_name Email Phone_no Address City State Zip_code Country
 1. Create a view named customer_info for the Customer table that displays Customer’s Full name and email address.
 Then perform the SELECT operation for the customer_info view. 
 2. Create a view named US_Customers that displays customers located in the US.
 3. Create another view named Customer_details with columns full name(Combine first_name and last_name), email, phone_no, and state. 
 4. Update phone numbers of customers who live in California for Customer_details view. 
 5. Count the number of customers in each state and show only states with more than 5 customers. 
 6. Write a query that will return the number of customers in each state, based on the "state" column in the "customer_details" view. 
7. Write a query that returns all the columns from the "customer_details" view, sorted by the "state" column in ascending order.*/
use practice;
select * from country_info;
select * from persons;

#1. Find the number of persons in each country. 
select count(fname) ,country_name from persons group by country_name;
# 2. Find the number of persons in each country sorted from high to low. 
SELECT COUNT(fname), country_name
FROM Persons
GROUP BY country_name
ORDER BY COUNT(fname) DESC;

#3. Find out an average rating for Persons in respective countries if the average is greater than 3.0 
SELECT fname, AVG(rating)
FROM Persons
GROUP BY fname
HAVING AVG(rating) > 3;

#4. Find the countries with the same rating as the USA. (Use Subqueries) 
SELECT country_name from persons where 
rating = (select rating from persons where Country_name = 'usa');

#5. Select all countries whose population is greater than the average population of all nations.
SELECT country_name
FROM persons
GROUP BY country_name
HAVING AVG(population) > (SELECT AVG(population) FROM persons);

/*Create a database named Product and create a table called Customer with the following fields in the 
 Product database: Customer_Id - Make PRIMARY KEY First_name Last_name Email Phone_no Address City State Zip_code Country*/
 
 create database Product;
 use product;
 CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,     -- Assuming Customer_Id is an integer
    F_name VARCHAR(50),
    L_name VARCHAR(50),
    Email VARCHAR(100),
    Phone_no VARCHAR(15),
    Address VARCHAR(255),
    City VARCHAR(50),
    State VARCHAR(50),
    Zip_code VARCHAR(20),
    Country VARCHAR(50)
);
describe customer;
INSERT INTO Customer (Customer_Id, F_name, L_name, Email, Phone_no, Address, City, State, Zip_code, Country)
VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '123-456-7890', '123 Maple St', 'New York', 'NY', '10001', 'USA'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', '456 Oak St', 'Los Angeles', 'CA', '90001', 'USA'),
(3, 'Michael', 'Brown', 'michael.brown@example.com', '345-678-9012', '789 Pine St', 'Chicago', 'IL', '60601', 'USA'),
(4, 'Emily', 'Davis', 'emily.davis@example.com', '456-789-0123', '101 Maple St', 'Houston', 'TX', '77001', 'USA'),
(5, 'David', 'Johnson', 'david.johnson@example.com', '567-890-1234', '202 Oak St', 'Phoenix', 'AZ', '85001', 'USA'),
(6, 'Sarah', 'Lee', 'sarah.lee@example.com', '678-901-2345', '303 Pine St', 'San Antonio', 'TX', '78201', 'USA'),
(7, 'James', 'Wilson', 'james.wilson@example.com', '789-012-3456', '404 Maple St', 'San Diego', 'CA', '92101', 'USA'),
(8, 'Linda', 'Taylor', 'linda.taylor@example.com', '890-123-4567', '505 Oak St', 'Dallas', 'TX', '75201', 'USA'),
(9, 'Robert', 'Anderson', 'robert.anderson@example.com', '901-234-5678', '606 Pine St', 'San Jose', 'CA', '95101', 'USA'),
(10, 'Patricia', 'Martinez', 'patricia.martinez@example.com', '012-345-6789', '707 Maple St', 'Austin', 'TX', '73301', 'USA');
select * from customer;

/*1. Create a view named customer_info for the Customer table that displays Customer’s Full name and email address.
 Then perform the SELECT operation for the customer_info view.*/
  create view  customer_info as select  concat(f_name,' ', L_name) as Full_name ,email from customer;
  select * from customer_info;

#2. Create a view named US_Customers that displays customers located in the US.
create view US_Customers as  select concat(f_name,' ', L_name) as Full_name, city from customer where country = 'USA';
 select * from US_Customers;
 
 #3. Create another view named Customer_details with columns full name(Combine first_name and last_name), email, phone_no, and state. 
 create view Customer_details as  select concat(f_name,' ', L_name) as Full_name,email,phone_no,state from customer;
  select * from Customer_details;
  
 #4. Update phone numbers of customers who live in California for Customer_details view. 
 update Customer_details 
 set phone_no = '894-849-3784' where state = 'CA';

 #5. Count the number of customers in each state and show only states with more than 3 customers. 
 select count(full_name),state from customer_details group by state having count(full_name)> 3;
 
# 6. Write a query that will return the number of customers in each state, based on the "state" column in the "customer_details" view. 
 select count(full_name) as Number_of_customers ,state from customer_details group by state ;
 
#7. Write a query that returns all the columns from the "customer_details" view, sorted by the "state" column in ascending order.
select * from customer_details order by state asc;

/*1. Ranking Customers by Zip Code Using ROW_NUMBER()
Let's assign a unique row number to each customer within each Zip_code:*/
SELECT 
    Customer_Id,
    F_name,
    L_name,
    Zip_code,
    ROW_NUMBER() OVER(PARTITION BY Zip_code ORDER BY Customer_Id) AS row_num_by_zip
FROM 
    Customer;

/*2. Counting Customers Per State Using COUNT()
Using COUNT() as a window function, you can calculate the number of customers in each State:*/
SELECT 
    Customer_Id,
    F_name,
    L_name,
    State,
    COUNT(Customer_Id) OVER(PARTITION BY State) AS total_customers_in_state
FROM 
    Customer;
    
/* 3. Getting the Next and Previous Customers Using LEAD() and LAG()
Retrieve the previous and next customer F_name for each customer:*/

SELECT 
    Customer_Id,
    F_name,
    L_name,
    LAG(F_name, 1) OVER(ORDER BY Customer_Id) AS previous_customer,
    LEAD(F_name, 1) OVER(ORDER BY Customer_Id) AS next_customer
FROM 
    Customer;

