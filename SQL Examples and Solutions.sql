
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

-- 3.5: Joining Tables

-- Intro

SELECT 		a.title AS Album, t.Name AS Track, t.Composer, strftime('%M:%S', Milliseconds / 1000,
 			'unixepoch') AS [Length]
FROM 		tracks t
INNER JOIN 	albums a 
ON			a.AlbumId = t.AlbumId
WHERE 		a.title = 'Jagged Little Pill';

-- 3.5.1

SELECT 		al.title, ar.name as [Artist]
FROM 		albums al
INNER JOIN 	artists ar
ON 			ar.ArtistId = al.ArtistId
ORDER BY 		al.Title;

-- 3.5.2

SELECT ar.ArtistId, ar.name as [Artist], al.title
FROM artists ar
LEFT OUTER JOIN albums al
ON al.ArtistId = ar.ArtistId
ORDER BY al.Title;

-- 3.5.3

SELECT 		c.LastName, c.FirstName,
 			concat(e.LastName, ', ', e.FirstName) 
 			AS [Support Rep]
FROM 		customers c 
LEFT JOIN 	employees e 
ON 			e.EmployeeId = c.SupportRepId;

-- 3.5.4

SELECT 		c.LastName, c.FirstName,
 			concat(e.LastName, ', ', e.FirstName) 
 			AS [Support Rep]
FROM 		customers c 
RIGHT JOIN 	employees e 
ON 			e.EmployeeId = c.SupportRepId;

-- 3.5.5

SELECT 		c.LastName, c.FirstName,
 			concat(e.LastName, ', ', e.FirstName) 
 			AS [Support Rep] 
FROM			employees e 
RIGHT JOIN 	customers c 
ON 			e.EmployeeId = c.SupportRepId;

-- 3.5.6

SELECT 		c.LastName, c.FirstName,
 			concat(e.LastName, ', ', e.FirstName) 
  			AS 'Support Rep'
FROM 		employees e 
FULL JOIN		customers c 
ON			e.EmployeeId = c.SupportRepId
WHERE		c.LastName IS NULL or e.LastName IS NULL;

-- 3.5.7

SELECT 		e.LastName, e.FirstName, 
concat(m.LastName, ', ', m.FirstName) as [Reporting to:]
FROM 		Employees e
INNER JOIN	Employees m
ON 			m.EmployeeId = e.ReportsTo;

-- 3.5.8

SELECT 		concat(e.LastName, ', ', e.FirstName) as [Sales Rep],c.CategoryName
FROM 		employees e
CROSS JOIN 	Categories c
WHERE 		e.title = 'Sales Representative';

-- 3.5.9

SELECT 		al.title, ar.name as [Artist]
FROM 		albums al
NATURAL JOIN	artists ar
ORDER BY 		title;

-- 3.5.10

SELECT 		f.title, f.description, 
 			f.length, f.rating
FROM 		film f
INNER JOIN 	film_category fc
ON 			fc.film_id = f.film_id
INNER JOIN 	category c
ON 			c.category_id = fc.category_id
WHERE 		c.name = 'Action';

-- 3.5.11

SELECT 		concat(a.first_name, ' ', last_name) AS [Actor]
FROM 		actor a
INNER JOIN 	film_actor fa
ON 			fa.actor_id = a.actor_id
INNER JOIN 	film f
ON 			fa.film_id = f.film_id
WHERE 		f.title = 'CADDYSHACK JEDI';

-- 3.5.12

SELECT 		a.actor_id, f.title 
FROM 		actor a
INNER JOIN 	film_actor fa
ON 			fa.actor_id = a.actor_id
INNER JOIN 	film f
ON 			fa.film_id = f.film_id
WHERE 		a.first_name = 'ED' 
AND			a.last_name = 'CHASE';

-- 3.5.13

SELECT 		cl.*, c.email 
FROM 		customer_list cl
INNER JOIN 	customer c
ON			c.customer_id = cl.ID;

-- 3.5.14

SELECT 		cl.*, email, sa.address, 
 			sa.address2, sa.postal_code, sa.phone
FROM 		customer_list cl
INNER JOIN 	customer c
ON 			c.customer_id = cl.ID
INNER JOIN 	store s
ON 			s.store_id = cl.SID
INNER JOIN 	address sa
ON 			sa.address_id = s.address_id;

-- 3.5.15

SELECT 		cl.*, email, concat(sa.address,' ',
 			sa.address2, ', ' , city.city, 
 			'  ', sa.postal_code, ', ', co.country) 
 			AS [Store Location], 
 			sa.phone as 'Store Phone'
FROM 		customer_list cl
INNER JOIN 	customer c
ON 			c.customer_id = cl.ID
INNER JOIN 	store s
ON 			s.store_id = cl.SID
INNER JOIN 	address sa
ON 			sa.address_id = s.address_id
INNER JOIN 	city
ON 			city.city_id = sa.address_id
INNER JOIN 	country co
ON 			co.country_ID = city.country_id
ORDER BY	c.last_name;


-- 3.5 Challenge Solutions

-- 1. On the Chinook database, write a query that lists all invoices before January 1, 2010 
-- with the invoice ID, invoice date, customer first and last name, customer company and e-mail address. 
-- (Hint: You'll need to join the Invoices and Customers table. Also, refer to the section on searching 
-- by dates in section 3.3.)

SELECT		i.InvoiceId, i.InvoiceDate,  
 			concat(c.LastName, ', ', c.FirstName) 
 			AS [Customer], 
 			c.Company, c.email
FROM			invoices i
INNER JOIN	customers c
ON			c.CustomerId = i.CustomerId
WHERE		i.InvoiceDate < '2010-01-01'
ORDER BY		i.InvoiceDate;

-- 2. In the Sakila database, write queries that return the rental and return dates for a specific 
-- movie by movie title and film ID. (Hint: You'll need to join the film, inventory and rental tables.)  
-- You'll notice that the rental times overlap because there is more than one copy of the film so add the 
-- inventory ID to the query. The movie title and film ID criteria can be combined into a single WHERE 
-- statement so that the query can return two films if specified.
SELECT		f.title, r.rental_date, r.return_date, 
 			i.inventory_id
FROM			Sakila.film f
inner JOIN	Sakila.inventory i
ON			i.film_id = f.film_id
INNER JOIN	rental r
ON			r.inventory_id = i.inventory_id
WHERE		f.title = 'ANTITRUST TOMATOES'
OR			f.film_id = 29;

-- 3. On the Northwind database, get a list of all products with product name, category name and the 
-- company name of the supplier. Order by category and then product name.
SELECT		p.ProductName, c.description, 
 			s.CompanyName
FROM			Northwind.Products p
INNER JOIN	Categories c
ON			c.CategoryID = p.CategoryID
INNER JOIN	Suppliers s
ON			s.SupplierID = p.SupplierID
ORDER BY		c.description, p.ProductName;

-- 4. Get a list of all Northwind orders shipped by the company 'Speedy Express'. List the Order ID, 
-- customer's company name, the order date, date shipped and the freight.
SELECT		o.OrderID, c.CompanyName, o.OrderDate, 
 			o.ShippedDate, o.Freight
FROM			Northwind.Orders o
INNER JOIN	Northwind.Shippers s
ON			s.ShipperID = o.ShipVia
INNER JOIN	Northwind.Customers c
ON			c.CustomerId = o.CustomerId
WHERE		s.CompanyName = 'Speedy Express';

-- 5. On the Chinook database write a query that will return all the tracks that a customer has been 
-- invoiced for. You can search by customer ID or name. Include the invoice date, track name, album title 
-- and the name of the genre. Sort by the invoice date. You will need to consult the Chinook diagram and 
-- the query will involve six tables. 
SELECT 		i.InvoiceDate, t.name, a.title, g.name
FROM			customers c
INNER JOIN	invoices i
ON			i.customerId = c.CustomerId
INNER JOIN	invoice_items ii
ON			ii.InvoiceId = i.InvoiceId
INNER JOIN	tracks t
ON			t.TrackId = ii.TrackId
INNER JOIN	albums a
ON			a.AlbumId = t.AlbumId
INNER JOIN	genres g
ON			g.GenreId = t.GenreId
WHERE		c.customerid = 27
order by	i.InvoiceDate;

-- 3.6: Defining Groups: The GROUP BY Clause

-- 3.6.1

SELECT 	COUNT(*) AS [Invoices],
 		concat(c.LastName, ', ', c.FirstName) 
 		AS [Customer]
FROM 	invoices i
INNER JOIN customers c
ON 		C.CustomerId = i.InvoiceId
GROUP BY 	i.CustomerId
ORDER BY 	count(*) DESC;

-- 3.6.2

SELECT 	COUNT(*)
FROM 	customers
WHERE 	country = 'Canada';

SELECT 	COUNT(DISTINCT country)
FROM 	customers;

SELECT	DISTINCT Country
FROM 	customers;

-- 3.6.3

SELECT 		COUNT(*) AS [Invoices], c.Country
FROM 		invoices i
INNER JOIN 	customers c
ON 			c.CustomerId = i.InvoiceId
GROUP BY 		c.country
ORDER BY 		[Invoices] DESC;

-- 3.6.4

SELECT 	COUNT(company)
FROM 	customers;

-- 3.6.5

SELECT	t.AlbumId, a.title, COUNT(*) AS track_count
FROM		tracks t
INNER JOIN  	albums a
ON 		a.AlbumId = t.AlbumId
GROUP BY	t.AlbumId;

-- 3.6.6

SELECT 	CategoryName, ROUND(AVG(UnitPrice), 2) 
 		AS [Average Price] 
FROM 	[Alphabetical List of Products]
GROUP BY 	CategoryName
ORDER BY 	[Average Price] DESC;

-- 3.6.7

SELECT 	GenreId, 
ROUND	(AVG(Bytes / 1024 / 1024), 2) 
 		AS [Avg Size (MB)]
FROM 	tracks
GROUP BY 	GenreId;

-- 3.6.8

SELECT 		t.GenreId, g.name, 
  			ROUND(AVG(Bytes / 1024 / 1024), 2) 
 			AS [Avg Size (MB)]
FROM 		tracks t 
INNER JOIN 	genres g
ON 			g.GenreId = t.GenreId
GROUP BY 		t.GenreId, g.name;

-- 3.6.9

SELECT * FROM invoices;

SELECT 	InvoiceDate, BillingCountry FROM invoices;

SELECT	MIN(InvoiceDate) AS [First Invoice], 
 		BillingCountry
FROM		invoices
GROUP BY	BillingCountry
ORDER BY	[First Invoice];

-- 3.6.10

SELECT TOTAL(replacement_cost) FROM film;

-- 3.6.11

SELECT	GROUP_CONCAT(DISTINCT BillingCity) AS Cities,
 		BillingCountry
FROM		invoices
GROUP BY 	BillingCountry;

-- 3.6.12

SELECT 	CategoryName, ROUND(AVG(UnitPrice), 2) AS  
 		[Average Price] 
FROM 	[Alphabetical List of Products]
GROUP BY	CategoryName
HAVING	[Average Price] > 25
ORDER BY 	[Average Price] DESC;

-- 3.6.13

SELECT 	strftime('%m-%Y', ShippedDate) AS Month, 
 		ROUND(SUM(Subtotal), 2) as [Monthly Sales]
FROM		[Summary of Sales By Year]
GROUP BY	Month
HAVING	[Monthly Sales] > 75000
ORDER BY	ShippedDate;


-- 3.6 Challenge Solutions

-- 1. As promised, your first challenge is to determine the total value of the inventory in 
-- the Sakila database using the replacement cost field in the film table. Remember that the
-- inventory table actually stores a record for each copy of the movies available so you'll 
-- need to link to that and then use the TOTAL or SUM function to determine the total investment 
-- the business has in inventory.

SELECT		TOTAL(f.replacement_cost)
FROM			inventory i
INNER JOIN	film f
ON			f.film_id = i.film_id

-- 2. Write a query to pull all the playlists from the Chinook Playlist table and how many 
-- tracks they have. Show both the playlist ID and the playlist name. Sort by track count descending. 
-- Then modify the query so that you are showing the playlists with only a single track on them.

Remove the HAVING clause below to show all playlists sorted descending.
SELECT 		p.PlaylistId, p.name, 
 			count(pt.trackID) AS [Track Count]
FROM			playlists p
INNER JOIN  	playlist_track pt
ON 			pt.PlaylistId = p.PlaylistId
GROUP BY 		p.PlaylistId, p.name
HAVING 		[Track Count] = 1
ORDER BY 		[Track Count] DESC;

-- 3. You can use both the WHERE and HAVING clauses in a single query to limit individual records
-- first and then limit based on group. Change the playlist query in challenge #2 to show playlists 
-- of all lengths but only those that contain songs from a specific composer.

SELECT 		p.PlaylistId, p.name, 
 			count(pt.trackID) AS [Track Count]
FROM			playlists p
INNER JOIN  	playlist_track pt
ON 			pt.PlaylistId = p.PlaylistId
INNER JOIN 	tracks t
ON 			t.TrackId = pt.TrackId
WHERE 		t.Composer LIKE '%Ballard%'
GROUP BY 		p.PlaylistId, p.name
ORDER BY 		[Track Count] DESC;

-- 4. In the Northwind database, write a query that returns the number of orders taken per employee 
-- for the first quarter of 1997 (1/1 to 3/31). Sort by the number of orders descending. Return the 
-- EmployeeID fields, first and last name concatenated into one name field and the count of the orders.

SELECT		e.EmployeeId, concat(e.FirstName, ' ', 
 			e.LastName) as [Employee], 
			count(*) as [Order Count]
FROM			Orders o
INNER JOIN	Employees e
ON			e.EmployeeId = o.EmployeeId
WHERE		o.OrderDate > '1996-12-31' AND 
 			o.OrderDate < '1997-04-01'
GROUP BY 		e.EmployeeId, [Employee]
ORDER BY		[Order Count] DESC;

-- 5. In Northwind, write a query that returns the total of all invoicing for each month, including 
-- freight. Use the order date to get the month and sort chronologically. You can use the Invoices view 
-- to avoid doing any joins and the Extended Price field to get a total of all products on each invoice. 
-- (Hint: You can add two fields, such as Extended Price and Freight, within the SUM() function to get the 
-- total of both for all records in the group.)

SELECT	strftime('%m-%Y', OrderDate) AS [Month], 
 		ROUND(SUM(ExtendedPrice + Freight), 2) 
 		AS [Month Total]
FROM		Invoices
GROUP BY	[Month]
ORDER BY	OrderDate;















			
















