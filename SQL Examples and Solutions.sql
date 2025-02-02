
-- Sample code file for:
-- 
-- Self-Guided SQL: Build Your SQL Skills with SQLite
-- Andrew Comeau
-- Copyright 2025, Comeau Software Solutions
-- 
-- This file contains all of the example queries and exercise solutions from the book.
-- These queries assume the Chinook, Northwind and Sakila databases are loaded and attached.
-- This file will work best if Chinook is loaded as the main database and Sakila and Northwind are attached.
-- Queries are to be run on Chinook unless otherwise specified.

-- Refer to chapters and steps shown in comments.
-- i.e.  "3.2.6" refers to Chapter 3.2, step 6.

-- For more infomation, please visit the official book page at:
-- https://www.comeausoftware.com/self-guided-sql-sqlite/
-- 
-- Or visit the LeanPub sales page at:
-- https://leanpub.com/self-guided-sql

-- 2.2: Navigating the SQLite Console

-- 2.2.13 (Chinook):

.mode column
SELECT FirstName, LastName, Company, Phone 
FROM Customers LIMIT 10;

-- 2.2.14:

SELECT first_name, last_name 
FROM sakila.customer LIMIT 10;

-- 2.3: DB Browser for SQLite

-- 2.3.7 (Chinook)

SELECT * FROM albums
WHERE title LIKE '%greatest hits%';

-- 2.3.8

DETACH DATABASE Sakila;

-- 3.2: SELECT Basics

-- 3.2.1 (Chinook)

SELECT Name FROM Genres;

-- 3.2.2

SELECT GenreId, Name FROM Genres;

SELECT * FROM Genres;

-- 3.2.3

SELECT LastName, FirstName, Title, HireDate 
FROM Employees;

-- 3.2.4

SELECT Title FROM albums LIMIT 10;

SELECT Title FROM albums LIMIT 10 OFFSET 10;

-- 3.2.5

SELECT		OrderID, ProductID,  
			(UnitPrice * Quantity) * (1-Discount) AS [Extended Price]
FROM 		[Order Details]
LIMIT		100;

-- 3.2.6

SELECT 		(75 - 32) / (9/5.0);

-- 3.2.7

SELECT		LastName, FirstName, HireDate, 
 			timediff('now', HireDate) 
FROM 		employees;

-- 3.2.8

pragma table_info('employees');

-- 3.2 Challenge Solutions

-- 1. From the Chinook invoices table, select the invoice date, city, state and invoice total from the first 15 records.
SELECT InvoiceDate, BillingCity, BillingState, Total
FROM invoices
LIMIT 15;

-- 2. Change the query in the previous example to skip over the first 15 records and get the next 25.
SELECT InvoiceDate, BillingCity, BillingState, total
FROM invoices
LIMIT 25 OFFSET 15;

-- 3. Write a query to get the name, composer and milliseconds fields from the first 100 records in the Chinook tracks table.
SELECT Name, Composer, Milliseconds
FROM tracks
LIMIT 100;

-- 4. Use the appropriate wildcard to get all fields in all records from the Sakila database's category table.
select * from Sakila.category;

-- 5. Get the first name, last name and e-mail fields from the first 50 records of the Sakila customer table.
SELECT first_name, last_name, email 
FROM Sakila.customer 
LIMIT 50;

-- 3.3: Applying Filters: The WHERE clause

-- 3.3.1

SELECT * FROM albums 
WHERE title LIKE '%greatest hits%';

-- 3.3.2

SELECT * FROM albums 
WHERE title LIKE 'greatest hits';

-- 3.3.3

SELECT title FROM albums 
WHERE title LIKE 'Lost, Season _';

-- 3.3.4

SELECT FirstName, LastName, Company, Address, City, State, Country, PostalCode
FROM customers
WHERE Country = 'Canada';

-- 3.3.5

SELECT FirstName, LastName, Company, Address, City, State, Country, PostalCode
FROM customers
WHERE Country = 'Canada'
AND City = 'Toronto' 

-- 3.3.6

SELECT ProductName, QuantityPerUnit, UnitPrice
FROM Northwind.Products
WHERE UnitPrice > 100;

-- 3.3.7

SELECT ProductName, QuantityPerUnit, UnitsInStock
FROM Northwind.Products
WHERE UnitsInStock < 10;

-- 3.3.8

SELECT * FROM invoices WHERE Total BETWEEN 5 AND 14;

-- 3.3.9

SELECT LastName FROM customers 
WHERE substr(LastName, 1, 1) BETWEEN 'A' AND 'C';

-- 3.3.10

SELECT LastName FROM customers 
WHERE substr(LastName, 2, 2) = 'ar';

-- 3.3.11

SELECT LastName, FirstName, Title 
FROM employees 
WHERE LastName = 'Mitchell' OR Title = 'IT Staff';

-- 3.3.12

SELECT * FROM artists ar 
WHERE NOT EXISTS 
(SELECT 1 FROM albums al 
    WHERE al.artistid = ar.artistid);

	
-- 3.3.13

SELECT	FirstName, LastName, Company, city
FROM 	Customers c
WHERE 	c.Country NOT IN 
 		('USA', 'Canada');

-- 3.3.14

SELECT		al.Title, ar.name
FROM			albums al
INNER JOIN	artists ar
ON			ar.ArtistId = al.ArtistId
WHERE		ar.name IN 
 			('Eric Clapton', 'R.E.M.', 'The Doors');

-- 3.3.15

SELECT 	LastName, FirstName, Title 
FROM 	employees 
WHERE 	Title IS NOT 'IT Staff';

SELECT 	Name, Milliseconds
FROM 	tracks
WHERE 	Composer IS NULL;

-- 3.3.16

SELECT 	FirstName, LastName, State, Country
FROM 	customers
WHERE 	State IS DISTINCT FROM 'CA';

-- 3.3.17

SELECT 	FirstName, LastName, 
 		Company, City, State, Country
FROM 	Customers 
WHERE 	Company IS NULL;

-- 3.3.18

UPDATE customers SET Company = '' 
WHERE FirstName = 'Astrid' AND LastName = 'Gruber';

-- 3.3.19

SELECT FirstName, LastName, Company
FROM customers
WHERE Company IS NULL OR Company = '';

-- 3.3.20

SELECT 	FirstName, LastName, Company
FROM 	customers
WHERE 	nullif(Company, '') IS NULL
ORDER BY	LastName;

-- 3.3.21

SELECT	CustomerID, ShipName, OrderDate, ShipVia,   
 		Freight
FROM	Orders
WHERE	Date(OrderDate) > '1997-01-01'
AND		Date(OrderDate) < '1997-12-31';

SELECT	CustomerID, ShipName, OrderDate, ShipVia,   
 		Freight
FROM	Orders
WHERE	OrderDate > '1997-01-01'
AND		OrderDate < '1997-12-31';

-- 3.3.22

SELECT Date('now');

SELECT Time('now');

SELECT DateTime('now');

SELECT JulianDay('now');


-- 3.3.23

SELECT strftime('%m/%d/%Y','now');

-- 3.3.24

SELECT 	LastName, FirstName, 
 		strftime('%m/%d/%Y', HireDate) AS [Date Hired] 
FROM	employees;

-- 3.3.25

SELECT	LastName, FirstName, HireDate,
 		DateTime(HireDate, '+5 years') AS 
 		[Five Year Anniv.] 
FROM	employees;

SELECT	LastName, FirstName, HireDate,
 		DateTime(HireDate, '+0000-03-00') AS 
 		[90 Day Review] 
FROM	employees;

SELECT	LastName, FirstName, HireDate,
 		DateTime(HireDate, 'start of month',
 		'+1 month') AS 
 		[Benefits Start Date] 
FROM	employees;

-- 3.3.26

SELECT	LastName, FirstName, timediff(HireDate, 'now') 
 		AS [Time at Company] 
FROM	employees;

-- 3.3.27

SELECT	LastName, FirstName, 
 	ROUND((JulianDay('now') - JulianDay(HireDate)) 
 	/ 365.25, 1) AS [Years at Company]
FROM	employees;

-- 3.3.28

SELECT	LastName, FirstName, 
 		ROUND((JulianDay('now') - JulianDay(HireDate))
 		/ 365.25, 1) AS [Years at Company]
FROM	employees
WHERE 	[Years at Company] > 22;


-- 3.3 Challenge Solutions

-- 1. If you want to restore your Chinook data to its original value, write the SQL to set Astrid Gruber's 
-- company name back to NULL. As a precaution, you should make a backup copy of the database first.

UPDATE customers SET Company = NULL 
WHERE FirstName = 'Astrid' AND LastName = 'Gruber';

-- 2. In the Chinook database, write a query that finds all the albums with the word “Live” in the title.

SELECT Title FROM albums WHERE Title LIKE '%live%';

-- 3. In the Chinook database, the length of the individual music tracks is recorded in milliseconds 
-- and the composer field might contain more than one artist. Write a query to find all of the tracks 
-- between three and four minutes in length where Van Halen is listed as a composer. Try experimenting 
-- with different lengths and composers.

SELECT name, Composer FROM tracks 
WHERE (Milliseconds BETWEEN 180000 and 240000) 
AND Composer LIKE '%Van Halen%';

--(1000 milliseconds = 1 second * 60 * 3 = 180000. The parentheses around the Milliseconds criteria 
-- aren't strictly necessary but help to set off its use of 'and' from the AND keyword for the second criteria.)

-- 4. Browse the data in the Northwind customers table and then write the query to find all the customers 
-- located in the U.S. who have fax numbers.

SELECT CompanyName, Country, Fax
FROM Northwind.customers
WHERE country = 'USA' AND Fax IS NOT NULL;

-- 5. Write a query to find the names, titles and phone numbers of all the Northwind employees located in Seattle, WA.

SELECT LastName, FirstName, Title, HomePhone, city, Region
FROM Northwind.Employees
WHERE HireDate > '1994-01-01';

-- 6. In the Sakila database film table, find all the films for which the description contains the words 'drama' 
-- but doesn't contain the word 'space' and the description is longer than 100 characters. (Hint: You can include 
-- more than one WHERE condition for the same column.)

SELECT title, description
FROM Sakila.film
WHERE description LIKE '%drama%' 
AND description NOT LIKE '%space%' 
AND length(description) > 100;

-- 7. Write a SELECT statement that returns your age using either timediff() or JulianDay().
-- Samples:

SELECT timediff('1980-01-01', 'now');
SELECT timediff('now', '1980-01-01');

-- 3.4: Sorting Data: The ORDER BY Clause

-- 3.4.1

SELECT	LastName, FirstName
FROM	customers
WHERE	Country = 'USA';
ORDER BY	LastName
LIMIT	10;

-- 3.4.2

SELECT	Name, Composer, Milliseconds
FROM		tracks
ORDER BY 	Milliseconds DESC
LIMIT	15;

-- 3.4.3

SELECT 	CompanyName, Address, City, Country
FROM		customers
WHERE 	Country <> 'USA'
ORDER BY	country, CompanyName;

-- 3.4.4

SELECT FirstName, LastName, 
Company, City, State, Country
FROM Customers 
ORDER BY Company NULLS LAST;

-- 3.4.5

SELECT	LastName, FirstName
FROM		customers
WHERE	Country = 'USA'
ORDER BY	LastName COLLATE NOCASE;

-- 3.4.6

SELECT DISTINCT 	City, State, Country
FROM				customers
ORDER BY			City;

-- 3.4.7

SELECT DISTINCT	ProductName
FROM				invoices
WHERE			Quantity >= 100
ORDER BY			ProductName;

-- 3.4.8

SELECT	ProductName 
FROM 	Products 
ORDER BY 	Length(ProductName), ProductName;

-- 3.4.9

SELECT 		Name, Composer, Milliseconds,
			strftime('%H:%M:%S', Milliseconds / 1000, 'unixepoch') AS [Time (H:M:S)] 
FROM		tracks
ORDER BY	Milliseconds DESC;


-- 3.4 Challenge Solutions

-- 1. You'll probably notice that all the composers in the query from Step 2 in this chapter 
-- are null because it simply isn't filled in for the longest tracks in the database. 
-- In the last chapter, you saw a way to omit null values using the WHERE clause. Add a WHERE 
-- clause to the query in Step 2 to show the 15 longest tracks that actually have composers listed.

SELECT	Name, Composer, Milliseconds
FROM		tracks
WHERE	Composer IS NOT NULL
ORDER BY 	Milliseconds DESC
LIMIT	15;

-- 2. The groups listed in the Chinook artists table are not in alphabetical order. Create a query 
-- that will return the names in order.

SELECT Name FROM artists ORDER BY Name;

-- 3. Use the LIKE keyword to find all the artists whose name starts with “The” and return them alphabetically.

SELECT Name FROM artists 
WHERE Name LIKE 'The%' ORDER BY Name;

-- 4. Query the Northwind customers table for a list of customers in the USA who have fax numbers. 
-- Show company name and fax number and sort by company name.

SELECT CompanyName, Fax
FROM Customers
WHERE fax IS NOT NULL
ORDER BY CompanyName;

-- 5. From the Sakila database, retrieve a list of the 50 longest movies which include deleted 
-- scenes as one of the special features.

SELECT title, description, length, special_features
FROM film
WHERE special_features LIKE '%deleted scenes%'
ORDER BY length DESC
LIMIT 50;






			
















