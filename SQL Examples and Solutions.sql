
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


-- 3.7: Breaking it Down: Subqueries and Common Table Expressions

-- Intro

SELECT 		a.title, tc.track_count AS 'Songs'
FROM 		albums a
INNER JOIN	(SELECT	AlbumId, COUNT(*) AS track_count
 			FROM		tracks 
 			GROUP BY	AlbumId) AS tc
ON 		tc.AlbumId = a.AlbumId
ORDER BY 	a.title;

-- 3.7.1

SELECT	ii.InvoiceId
FROM		invoice_items ii
GROUP BY	ii.InvoiceId
HAVING	COUNT(ii.TrackID) > 12 ;

-- 3.7.2

SELECT		FirstName, LastName, Address, City, State
FROM			Customers c
INNER JOIN	Invoices i
ON			i.CustomerId = c.CustomerId
WHERE		i.InvoiceId IN 
			(select 	ii.InvoiceId
			FROM 	invoice_items ii
			GROUP BY 	ii.InvoiceId
			HAVING 	COUNT(ii.TrackID) > 12);

-- 3.7.3

SELECT		FirstName, LastName, Address, City, State
FROM			Customers c
INNER JOIN	invoices i
ON			i.CustomerId = c.CustomerId
INNER JOIN 	(SELECT 	ii.InvoiceId
			FROM 	invoice_items ii
			GROUP BY 	ii.InvoiceId
			HAVING 	count(ii.TrackID) > 12) AS LI
ON			LI.InvoiceId = i.InvoiceId ;

-- 3.7.4

SELECT 		c.customer_id
FROM 		Customer c
INNER JOIN 	Payment p
ON 			p.customer_id = c.customer_id
GROUP BY 		c.customer_id
HAVING 		TOTAL(p.amount) > 150;

-- 3.7.5

SELECT		* 
FROM			customer_list cl
WHERE		cl.id IN
 	(SELECT		c.customer_id
 	FROM 		Customer c
 	INNER JOIN 	payment p
 	ON 			p.customer_id = c.customer_id
 	GROUP BY 		c.customer_id
 	HAVING 		TOTAL(p.amount) > 150)
ORDER BY 		cl.name;

-- 3.7.6

WITH [Order Totals] AS
(SELECT OrderID, TOTAL(ExtendedPrice) AS OT 
 	FROM [Order Details Extended] 
 	GROUP BY OrderID)
SELECT 	OrderID, PRINTF("%.2f", OT) AS [Order Total] FROM 	[Order Totals]
ORDER BY	OT DESC
LIMIT 	20;

-- 3.7.7

SELECT 	strftime('%Y-%m', OrderDate) AS Period,  
 		EmployeeId, COUNT(OrderID) as [Order Count]
FROM 	Orders
GROUP BY 	Period, EmployeeId;

-- 3.7.8

WITH [MonthlyTotals] AS 
 	(SELECT 	strftime('%Y-%m', OrderDate) AS Period,  
 	EmployeeId, COUNT(OrderID) as [Order Count]
 	FROM 	Northwind.Orders
 	GROUP BY 	Period, EmployeeId)
SELECT	Period, MAX([Order Count]) AS [Max Orders], 
 		mt.EmployeeId, e.FirstName, e.LastName
FROM 	MonthlyTotals mt
INNER JOIN Northwind.Employees e
ON 		e.EmployeeId = mt.EmployeeId
GROUP BY 	Period;

-- Big spender's solution

SELECT 		cl.* 
FROM 		customer_list cl
INNER JOIN 
	(SELECT 		c.customer_id
	FROM 		Customer c
	INNER JOIN 	payment p
	ON 			p.customer_id = c.customer_id
	GROUP BY 		c.customer_id
	HAVING 		TOTAL(p.amount) > 150) AS HighSpend
ON 			HighSpend.customer_id = cl.ID
ORDER BY 		cl.name;

-- Northwind order totals solution

SELECT 	OrderID, printf("$%.2f", TOTAL(ExtendedPrice)) 
 		AS [Order Total] 
FROM		[Order Details Extended]
GROUP BY	OrderID
ORDER BY	TOTAL(ExtendedPrice) DESC
LIMIT	20;


-- 3.7 Challenge solutions

-- 1. In the Sakila database, create a query that will return the five movies that earned 
-- the most from rentals within a specific month. Remember that you will need to join to multiple 
-- tables to create a path from the Film table to the Payment table.

-- This was a challenging one and I chose to use a common table expression. It starts with the query 
-- to get the titles and sales for each month as the inner query. From that, the outer query sorts 
-- the results, filters by the data and gets the top five rows.

WITH [SalesByTitleMonth] AS
(SELECT	f.title AS FilmTitle, 
 SUM(p.amount) AS [Total Sales],
 strftime('%Y-%m', r.rental_date) AS Period
 FROM 		payment AS p
 INNER JOIN 	rental AS r 
 ON 			p.rental_id = r.rental_id
 INNER JOIN 	inventory AS i
 ON 			r.inventory_id = i.inventory_id
 INNER JOIN 	film AS f 
 ON 			i.film_id = f.film_id
 GROUP BY 	f.title, Period)
SELECT Period, FilmTitle, [Total Sales] 
FROM SalesByTitleMonth
WHERE Period = '2005-05'
ORDER BY [Total Sales] DESC
LIMIT 5;

-- 2. In the Chinook database, get a listing of albums with more than 20 tracks. Return the album 
-- title, the artist and the number of tracks on the album.

-- This solution joins to a subquery and references one of its fields for the track count.

SELECT a.title, ar.name as Artist, tc.[Track Count]
FROM albums a
INNER JOIN (
    SELECT AlbumId, COUNT(*) AS [Track Count]
    FROM tracks
    GROUP BY AlbumId
    HAVING COUNT(*) > 20
) AS tc ON a.AlbumId = tc.AlbumId
INNER JOIN artists ar
ON ar.ArtistId = a.ArtistId
ORDER BY a.title;

-- 3. In the Chinook database, get a listing of customers who have invoices with more than 12 
-- tracks listed on them. List each customer only once, even if they have multiple invoices with 
-- more than 12 tracks.

SELECT 	c.FirstName, c.LastName, 
 		c.Address, c.City, c.State
FROM 	customers c
INNER JOIN invoices i 
ON 		i.CustomerId = c.CustomerId
WHERE 	i.InvoiceId IN (
    SELECT 	InvoiceId
    FROM 		invoice_items
    GROUP BY 	InvoiceId
    HAVING 	COUNT(TrackId) > 12
)
GROUP BY 	c.CustomerId
ORDER BY 	LastName;

-- 4. In the Sakila database, get a contact list for all the customers who have spent more than $150.

-- The customer_list view provides the contact information without having to link to a bunch of different tables.

SELECT 	cl.*
FROM 	customer_list cl
INNER JOIN (
    SELECT 	c.customer_id
    FROM 		customer c
    INNER JOIN payment p 
    ON 		p.customer_id = c.customer_id
    GROUP BY 	c.customer_id
    HAVING 	SUM(p.amount) > 150
) AS HighSpend 
ON 		HighSpend.customer_id = cl.id
ORDER BY 	cl.name;

-- 5. In the Northwind database, find the first and last name of the employee with the most 
-- orders for each month.

-- The common table expression first calculates the number of order per month, per employee 
-- and then the main query finds the most active employee for each month.

WITH MonthlyTotals AS (
    SELECT strftime('%Y-%m', OrderDate) AS Period,
           EmployeeId,
           COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY Period, EmployeeId
)
SELECT 	mt.Period, MAX(mt.OrderCount)
 		AS [Order Count], 
 		e.FirstName, e.LastName
FROM 	MonthlyTotals mt
INNER JOIN Employees e 
ON 		e.EmployeeId = mt.EmployeeId
GROUP BY 	mt.Period;

-- 3.8 Storing Queries: Creating Views

-- 3.8.1

CREATE VIEW vTrackListing AS
 	SELECT	tr.name AS [Track Name], 
 			al.title AS Album, 
 			ar.name AS Artist, tr.Composer,     
 			tr.Milliseconds, tr.UnitPrice
 	FROM			tracks tr
 	INNER JOIN	albums al
 	ON			al.AlbumId = tr.AlbumId
 	INNER JOIN	artists ar
 	ON			ar.ArtistId = al.ArtistId
 	ORDER BY		tr.name;

-- 3.8.2

SELECT * FROM vTrackListing
WHERE Artist = 'Led Zeppelin'
ORDER BY Album;

-- 3.8.3

DROP VIEW vTrackListing;

-- 3.8.4

SELECT	tr.TrackId, tr.name AS [Track Name], 
 		al.AlbumId, al.title AS Album, 
 		ar.ArtistID, ar.name AS Artist, tr.Composer,     
 		strftime('%M:%S', Milliseconds / 1000,
 			'unixepoch') AS [Length], 
 		tr.UnitPrice;

-- 3.8.6

CREATE VIEW vTrackListing AS
(TrackID, Track, AlbumID, Album,
 ArtistID, Artist, Composer, Minutes, PerUnit)
 	SELECT	tr.TrackId, tr.name, 
 			al.AlbumId, al.title, 
 			ar.ArtistID, ar.name, tr.Composer,     
 			strftime('%M:%S', Milliseconds / 1000,
 			'unixepoch'), tr.UnitPrice
 	FROM			tracks tr
 	INNER JOIN	albums al
 	ON			al.AlbumId = tr.AlbumId
 	INNER JOIN	artists ar
 	ON			ar.ArtistId = al.ArtistId
 	ORDER BY		tr.name;

	
-- 3.8 Challenge Solutions

-- 1. Create a view that lists all invoices in the Chinook database along with the customer's first 
-- and last name, phone, e-mail and the total of the invoice. The CREATE statement should not throw 
-- an error if you run it a second time.

-- The IF NOT EXISTS clause in the CREATE statement prevents SQLite from attempting to create a view that already exists.

CREATE VIEW IF NOT EXISTS vInvoiceTotals
AS
SELECT 	i.InvoiceId, i.CustomerId, i.InvoiceDate, 
 		c.LastName, c.FirstName, 
 		t.[Invoice Total], c.phone, c.email
FROM 	invoices i
INNER JOIN customers c
ON 		c.CustomerId = i.CustomerId
INNER JOIN
 	(SELECT 	InvoiceId, SUM(UnitPrice * Quantity) 
 			AS [Invoice Total]
 	FROM 	invoice_items ii
 	GROUP BY 	InvoiceId) t
ON 	t.InvoiceId = i.InvoiceId;

-- 2. Drop the view from the previous exercise and re-create it supplying alternative names of your choosing for each column.

-- Remember that, if you use alternative names as part of the CREATE statement, you need to define one for 
-- each column, even if you're not actually changing the name.

DROP VIEW vInvoiceTotals;

CREATE VIEW IF NOT EXISTS vInvoiceTotals
(InvoiceID, CustomerID, [Invoice Date], [Last Name], [First Name], [Total], [Phone Number], [E-mail])
AS
SELECT 	i.InvoiceId, i.CustomerId, i.InvoiceDate, 
 		c.LastName, c.FirstName, 
 		t.[Invoice Total], c.phone, c.email
FROM 	invoices i
INNER JOIN customers c
ON 		c.CustomerId = i.CustomerId
INNER JOIN
 	(SELECT 	InvoiceId, SUM(UnitPrice * Quantity) 
 			AS [Invoice Total]
 	FROM 	invoice_items ii
 	GROUP BY 	InvoiceId) t
ON 	t.InvoiceId = i.InvoiceId;

-- 3. In the Northwind database, create a view with reordering information on current products (Discontinued = 0) 
-- including the category name, supplier company and contact name and phone number. 

CREATE TEMP VIEW IF NOT EXISTS vProductContactList
AS
SELECT 	p.ProductName, p.QuantityPerUnit, plUnitPrice,
 		c.CategoryName, p.Description, s.CompanyName,  
 		s.ContactName, s.Phone
FROM 	Products p
INNER JOIN Categories c
ON 		c.CategoryID = p.CategoryID
INNER JOIN Suppliers s
ON 		s.SupplierID = p.SupplierID
WHERE 	Discontinued = 0
ORDER BY 	ProductName;

-- 4. In the Sakila database, create a temporary view that lists films by number of rentals in descending order.  
-- Include the film ID so that the view can be joined in another query as needed.

CREATE TEMP VIEW IF NOT EXISTS vFilmsByRentals
AS
SELECT 		f.film_id, f.title, 
 			count(*) as Rentals 
FROM			rental r
INNER JOIN	inventory i
ON			i.inventory_id = r.inventory_id
INNER JOIN 	film f
ON			f.film_id = i.film_id
GROUP BY		f.film_id
ORDER BY		Rentals DESC; 

-- 3.9 - Combining Queries: Unions, Intersections and Exceptions
	
-- 3.9.1

SELECT 	FirstName, LastName, Address, City, State,  
 		Country, PostalCode, "Customer" AS 
 		Relationship
FROM 	customers
UNION
SELECT 	FirstName, LastName, Address, City, State, 
 		Country, PostalCode, "Employee" AS 
 		Relationship
FROM 	employees
ORDER BY 	LastName, FirstName;

-- 3.9.2

SELECT	FirstName, LastName
FROM 	Chinook.employees
UNION
SELECT	FirstName, LastName
FROM 	Northwind.employees
UNION
SELECT	first_name, last_name
FROM		Sakila.staff
ORDER BY 	LastName;

-- 3.9.3

SELECT	FirstName, LastName
FROM 	Chinook.employees
UNION ALL
SELECT	FirstName, LastName
FROM 	Northwind.employees
UNION ALL
SELECT	first_name, last_name
FROM		Sakila.staff
ORDER BY 	LastName;


-- 3.9.4

SELECT	FirstName, LastName
FROM 	Chinook.employees
INTERSECT
SELECT	FirstName, LastName
FROM 	Northwind.employees;

-- 3.9.5

SELECT		me.FirstName, me.LastName, me.phone, 
 			ne.FirstName, ne.LastName, ne.HomePhone
FROM 		main.employees me
INNER JOIN 	Northwind.Employees ne
ON 			ne.FirstName = me.FirstName 
AND 			ne.LastName = me.LastName;

-- 3.9.6

SELECT		me.FirstName, me.LastName, me.phone, 
 			ne.FirstName, ne.LastName, ne.HomePhone
FROM 		main.employees me
INNER JOIN 	Northwind.Employees ne
ON 			ne.FirstName = me.FirstName 
OR 			ne.LastName = me.LastName;

-- 3.9.7

SELECT 	ArtistId
FROM 	Artists
EXCEPT
SELECT 	ArtistId
FROM 	Albums;

-- 3.9.8

SELECT	Name as Artist
FROM		artists
WHERE 	ArtistId IN
 	(SELECT	ArtistId
 	FROM 	Artists
 	EXCEPT
 	SELECT	ArtistId
 	FROM		Albums)
 	ORDER BY	Artist;

-- 3.9.9

SELECT 	first_name, last_name, email
FROM 	Sakila.customer
WHERE 	customer_id IN
 	(SELECT 	Customer_ID
 	FROM 	sakila.Customer
 	EXCEPT
 	SELECT 	Customer_ID
 	FROM 	sakila.Rental
 	WHERE 	return_date IS NULL)
AND active <> 0;

-- 3.9 Challenge Solutions

-- 1. In the Northwind database, write a basic EXCEPT query that will return a list of customers who have 
-- never placed orders.

SELECT 	CustomerID
FROM 	Northwind.Customers
EXCEPT
SELECT CustomerID
FROM 	Northwind.Orders;

-- 2. In the Chinook database, use an INTERSECT query to find the names of the employees who have acted 
-- as customer support representatives.  Also use an EXCEPT query to find those who haven't.

SELECT	LastName, FirstName
FROM	employees
WHERE	EmployeeId IN
 	(SELECT	EmployeeId
 	FROM		employees
 	INTERSECT
 	SELECT	SupportRepId
 	FROM		customers);

-- You only need to change the INTERSECT to EXCEPT to find non-supporting employees.

-- 3. Create a cross-database UNION query between the Chinook and Northwind databases to pull a mailing 
-- list for all customers. Include the customer's company field and a field to indicate which company 
-- the person is a customer of. The two databases store first and last names differently so you will need 
-- to write the query to compensate for this. 

SELECT 		CONCAT(FirstName, " ", LastName) AS [Customer  
 			Name], Company, Address, City, State, 
 			PostalCode, Country,"Chinook" AS [Vendor]
FROM 		Chinook.customers
UNION
SELECT 		ContactName, CompanyName, Address, City, 
 			Region, PostalCode, Country, "Northwind" AS 
 			[Vendor]
FROM 		Northwind.customers;

-- 4. In any of the databases, write a query to determine if any of the employees are also representing 
-- customers. You will probably need to change a customer name or contact name to match that of an employee.

Northwind example:
SELECT		c.ContactName, e.FirstName, e.LastName 
FROM		Northwind.customers c
INNER JOIN 	Northwind.employees e
ON			CONCAT(e.FirstName, " ", e.LastName) =  
 				c.ContactName;
Sakila:
SELECT		c.first_name, c.last_name, s.first_name, 
 			s.last_name
FROM		Sakila.customer c
INNER JOIN 	Sakila.staff s
ON			s.first_name = c.first_name
AND		s.last_name = s.last_name;

-- 5. In the Northwind database, the customer's contact address may be different than the shipping address on 
-- their order.  Pull a unique list of all customer and shipping locations by city, state or region and postal 
-- code. Sort it by the postal code.

-- As an extra challenge, eliminate any records where the city, state and postal code are all NULL.

SELECT DISTINCT 	city, Region, PostalCode 
FROM 			Northwind.customers
WHERE 			COALESCE(city, Region, PostalCode) 
 				IS NOT NULL
UNION
SELECT DISTINCT	ShipCity, ShipRegion, ShipPostalCode 
FROM			Northwind.Orders
WHERE			COALESCE(ShipCity, ShipRegion, 
 				ShipPostalCode) IS NOT NULL
ORDER BY		PostalCode;

-- The COALESCE function is one way of combining the three potentially NULL value into a single value that can be evaluated.

-- 3.10 - Finding it Faster: Full Text Search

-- 3.10.1

CREATE VIRTUAL TABLE sakila.fts_films 
USING FTS5(title, description);

INSERT INTO fts_films(title, description)
SELECT title, description FROM film;

-- 3.10.2

SELECT * FROM fts_films LIMIT 100;
SELECT * FROM fts_films_content LIMIT 100;

-- 3.10.3

UPDATE film SET title = 'Apollo Teenagers' 
WHERE title = 'Apollo Teen';

SELECT * FROM fts_films WHERE fts_films MATCH 'Apollo';


-- 3.10.4

DROP TABLE IF EXISTS fts_films;

CREATE VIRTUAL TABLE sakila.fts_films 
USING FTS5(title, description, content=film, content_rowid=film_id);

INSERT INTO sakila.fts_films(fts_films) VALUES ('rebuild');

-- 3.10.5

UPDATE film SET title = 'ACE WRITER' 
WHERE title = 'ACE GOLDFINGER';

SELECT * FROM fts_films 
WHERE fts_films MATCH 'writer';

-- 3.10.6

SELECT * FROM fts_films('explorer writer');

-- 3.10.7

SELECT * FROM fts_films ('out*');

-- 3.10.8

SELECT * FROM fts_films ('out* NOT outgun');
SELECT * FROM fts_films ('out* AND thought*');
SELECT * FROM fts_films ('data* OR thought*');

-- 3.10.9
SELECT * FROM fts_films ('explorer writer')
ORDER BY title;

-- 3.10.10

SELECT * FROM fts_films 
WHERE fts_films MATCH 'writer'
ORDER BY rank;

-- 3.10.11

SELECT *, rank FROM fts_films 
WHERE fts_films MATCH 'writer'
ORDER BY rank;

SELECT * FROM fts_films 
WHERE fts_films MATCH 'writer'
ORDER BY bm25(fts_films);

-- 3.10.12

SELECT title, highlight(fts_films, 1, '<b>', '</b>') AS Description 
FROM fts_films 
WHERE fts_films MATCH 'waitress';

-- 3.10.13

SELECT title, snippet(fts_films, 1, '[', ']', '...', 10) AS Description 
FROM fts_films 
WHERE fts_films MATCH 'student';

-- 3.10 Challenge Solutions

-- 1. In an earlier chapter on creating views in SQLite (3.8 – Storing Queries), you saw the
-- vTrackListing view which drew from three tables in the Chinook database to present the album 
-- and artist information on every track in the database. As an overview of this chapter, re-create 
-- that view and then create a full-text search virtual table from it. 

CREATE VIRTUAL TABLE fts_TrackListing 
USING FTS5(TrackID, track, album, artist, composer, minutes, perunit, CONTENT=vTrackListing, CONTENT_ROWID=TrackID);

INSERT INTO fts_TrackListing(fts_TrackListing) 
VALUES ('rebuild');

SELECT *, rank FROM fts_TrackListing 
WHERE fts_TrackListing MATCH 'rock';

SELECT *, rank 
FROM fts_TrackListing 
WHERE fts_TrackListing MATCH 'young*';

-- 2. In your new virtual track listing table, find the record(s) that have words starting 
-- with “wild” but not the word “wild” itself.

SELECT * FROM fts_TrackListing 
WHERE fts_TrackListing MATCH 'wild* NOT wild';

-- 3. Search the track titles in your track listing table for the word “shout” and use the highlight() 
-- function to place brackets around the word wherever it's found.

SELECT highlight(fts_TrackListing, 1, '[', ']') as Track, Album, Artist 
FROM fts_TrackListing 
WHERE fts_TrackListing MATCH 'shout';

-- 4. Using the FTS5 table in the Sakila database, find films that have both “teacher” and “scientist” 
-- in the title. Limit the portion of the title returned to the 10 word portion containing the search terms.

SELECT title, snippet(fts_films, 1, '[', ']', '...', 10) AS Description 
FROM fts_films 
WHERE fts_films MATCH 'scientist teacher';


-- 3.11 - Analysing Data: Window Functions

-- 3.11.1

SELECT 	row_number() OVER(ORDER BY total DESC) AS Row,
 		i.CustomerId, LastName, FirstName InvoiceDate, 
 		BillingCountry, total
FROM 	invoices i
INNER JOIN customers c
ON 		c.CustomerId = i.CustomerId
LIMIT 	10

-- 3.11.2

SELECT 	row_number() OVER() AS Row,
 		i.CustomerId, LastName, FirstName InvoiceDate, 
 		BillingCountry, total
FROM 	invoices i
INNER JOIN customers c
ON 		c.CustomerId = i.CustomerId
ORDER BY total DESC
LIMIT 	10

-- 3.11.3

SELECT	* 
FROM	(SELECT row_number() OVER(ORDER BY Track) AS Listing,
 		Track, Album, Artist, Composer, Minutes
 		FROM vTrackListing)
WHERE 	Listing BETWEEN 100 and 149;

-- 3.11.4

SELECT 	row_number() OVER(PARTITION BY ShipCountry ORDER BY 
 		OrderDate) AS Row,
 		CustomerId, LastName, OrderDate, ShippedDate, 
 		ShipName, ShipCountry 
FROM		Orders o 
INNER JOIN Employees e 
ON 		e.EmployeeId = o.EmployeeId 
WHERE	e.LastName = 'Davolio'

-- 3.11.5

SELECT 	* 
FROM
 	(SELECT	row_number() OVER(PARTITION BY ShipCountry 
 			ORDER BY OrderDate) AS Row, 
 			CustomerId, LastName, OrderDate, ShippedDate, 
 			ShipName, ShipCountry 
 	FROM		Northwind.Orders o 
 	INNER JOIN Northwind.Employees e 
 	ON 		e.EmployeeId = o.EmployeeId) 
WHERE	Row = 1 
ORDER BY	OrderDate;

-- 3.11.6

SELECT 	oq.OrderID, CustomerId, ShippedDate, Subtotal, 
 		SUM(Subtotal) over(PARTITION BY CustomerId 
 		ORDER BY ShippedDate 
  		ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
 		AS [Customer Total] 
FROM 	[Orders Qry] oq 
INNER JOIN [Order Subtotals] os 
ON		os.OrderID = oq.OrderID


-- 3.11.7

SELECT 	oq.OrderID, CustomerId, ShippedDate, Subtotal, 
 		SUM(Subtotal) over(PARTITION BY CustomerId 
 		ORDER BY ShippedDate 
  		RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) 
 		AS [Customer Total] 
FROM 	[Orders Qry] oq 
INNER JOIN [Order Subtotals] os 
ON		os.OrderID = oq.OrderID

-- 3.11.8

SELECT 	oq.OrderID, CustomerId, OrderDate, Subtotal, 
 		round(AVG(Subtotal) over(PARTITION BY CustomerId 
 		ORDER BY OrderDate 
  		ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) 
 		AS [Customer Total] 
FROM 	[Orders Qry] oq 
INNER JOIN [Order Subtotals] os 
ON		os.OrderID = oq.OrderID

-- 3.11.9

SELECT	ProductName, CategoryName, UnitPrice,
 		cume_dist() over(PARTITION BY CategoryName ORDER BY 
 		UnitPrice)
FROM			Products p
INNER JOIN	Categories c
ON			c.CategoryID = p.CategoryID

-- 3.11.10

SELECT 	strftime('%Y', OrderDate) AS OrderYear, o.EmployeeId, 
 		e.FirstName, e.LastName,  count(o.orderid) AS [Order 
 		Count], 
 		rank() over(PARTITION BY strftime('%Y', OrderDate) 
 		ORDER BY count(o.orderid) DESC) AS Ranking
FROM			orders o
INNER JOIN	employees e
ON			e.EmployeeId = o.EmployeeId
GROUP BY		o.EmployeeId, OrderYear

-- 3.11.11

SELECT 	oq.OrderID, CustomerId, ShippedDate, Subtotal, 
 		first_value(Subtotal) over(PARTITION BY CustomerId) 
 		AS [First Order] 
FROM			[Orders Qry] oq 
INNER JOIN	[Order Subtotals] os 
ON			os.OrderID = oq.OrderID

-- 3.11.12

SELECT 	oq.OrderID, CustomerId, ShippedDate, Subtotal, 
 		last_value(Subtotal) over(PARTITION BY CustomerId 
 		ORDER BY Subtotal RANGE BETWEEN UNBOUNDED 
 		PRECEDING AND UNBOUNDED FOLLOWING) AS [Max Order] 
FROM		[Orders Qry] oq 
INNER JOIN	[Order Subtotals] os  
ON			os.OrderID = oq.OrderID

-- 3.11.13

SELECT 	oq.OrderID, CustomerId, ShippedDate, Subtotal, 
 		lag(Subtotal, 1, 0) over(PARTITION BY CustomerId 
 		ORDER BY ShippedDate) 
 		AS [Prev Total]
FROM			[Orders Qry] oq 
INNER JOIN 	[Order Subtotals] os
ON			os.OrderID = oq.OrderID

-- 3.11.14

WITH OrderResults AS
(SELECT 	oq.OrderID, CustomerId, ShippedDate, Subtotal, 
 		lag(Subtotal, 1, 0) over(PARTITION BY CustomerId 
 		ORDER BY ShippedDate) 
 		AS [Prev Total]
FROM			[Orders Qry] oq 
INNER JOIN 	[Order Subtotals] os
ON			os.OrderID = oq.OrderID)
SELECT 	OrderID, CustomerId, ShippedDate, Subtotal, 
 		[Prev Total]
  		round(((Subtotal - [Prev Total]) / Subtotal) * 100, 2) 
 		AS [Pct. Change]
FROM		OrderResults;

-- 3/11.15

SELECT		FirstName, LastName, Company, Phone, Fax, email, 
			ntile (4) over(order by LastName) AS [Call Group]
FROM		customers; 


-- 3.11 Challenge Solutions

/* 1.	Using the vTrackListing view in the Chinook database, generate a track listing with a column showing the total time 
of all tracks for the artist shown in each row.  You will need to modify the vTrackListing view to have it return the raw 
Milliseconds column in order to calculate an accurate total for each artist.

After you modify vTrackListing, there are a couple ways you can do this.*/

SELECT	track, album, artist, Minutes, strftime('%H:%M:%S', 
 		(sum(Milliseconds) over(PARTITION BY Artist))/1000, 
 		'unixepoch') 
 		AS [Artist Total] 
FROM		vTrackListing 
ORDER BY 	Artist, Album

SELECT	track, album, artist, Minutes, 
 		strftime('%H:%M:%S', (sum(Milliseconds)  
 		over(PARTITION BY Artist ORDER BY Album RANGE BETWEEN 
 		UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))  / 1000,  
 		'unixepoch') AS [Artist Total] 
FROM		vTrackListing

/* Unlike the row_number() function, other window functions allow the query's sort order to be changed either in the window 
function or at the end of the query. In this case, if you do it within the function you need to use the window frame clause 
shown in the second example to control the function's focus. You can try it with and without this clause to see the difference.

2.	You can use window functions in combination with regular aggregate functions. Write a query using the Sakila film_list view 
that will count the number of films each actor appears in and then rank the actors based on this number with the most films in 
first place.*/

SELECT 	actors, COUNT(*) as Roles, 
 		dense_rank() over(order by COUNT(*) desc) AS Place
FROM		film_list
GROUP BY	actors

/*3.	After updating the Sakila film table with random release years, link to the film_list view to get the first movie 
released by each actor. You can return the first film for each of the actors or the list of the actor's movies with the title 
of the first movie.

Film list with actor's introductory role:*/

SELECT	fl.*, f.release_year, first_value(fl.title) 
 		over(PARTITION BY actors ORDER BY release_year) AS 
 		[Introductory Role]
FROM		film_list fl
INNER JOIN film f
ON 		f.film_id = fl.FID

/* First film listing for each actor. There probably will be multiple records for many actors because the random assignment 
of years results in the actor having multiple roles that year:*/

WITH Filmography AS 
(SELECT	fl.*, f.release_year, 
 		rank() over(PARTITION BY actors ORDER BY release_year) 
 		AS [Intro Role]
FROM			film_list fl
INNER JOIN	film f
ON			f.film_id = fl.FID)
 	SELECT	* 
 	FROM		Filmography
 	WHERE	[Intro Role] = 1

/* 4.	In the Northwind database, create a query from the Products table that will show the price of each product and the 
percentage it represents of the most expensive product price for that category. For example, under Condiments, "Vegie-Spread" 
is the most expensive confection at a price of $43.90. "Aniseed Syrup" is $10 which represents a 22.78% comparison against 
the higher price.*/

WITH ProductList AS 
(SELECT	ProductID, ProductName, CategoryID, 
 		UnitPrice, max(UnitPrice) over(PARTITION BY CategoryID) 
 		AS [Category High] FROM Northwind.Products)
SELECT	ProductID, ProductName, CategoryName, UnitPrice, 
 		round((UnitPrice * 1.0 / [Category Leader]) * 100, 2) 
 		AS [Percent of Lead], [Category Leader]
FROM 		ProductList pl
INNER JOIN 	Categories c
ON 			c.CategoryID = pl.CategoryID

/*The common table expression provides the result of each category's high price so that the second query can use it in the 
percentage calculation without running it twice. 

Notice that the UnitPrice in the second query is multiplied by 1.0 to ensure a non-integer value. Remember that SQLite performs 
integer division which would result in a false result if both prices were integers so it's necessary to change at least one to a 
decimal value.

5.	As a final challenge, in the Northwind database create a query that will read the total amount of invoicing for each month 
and include a column that will show a running average of that total. You might have some trouble putting the monthly sales in 
chronological order because of the way SQLite handles dates so don't be afraid to improvise with what you've learned about CTEs.*/

WITH MonthlyTotals AS
(SELECT	strftime('%m-%Y', ShippedDate) as Period, 
 		min(ShippedDate) AS ShipDate, 
 		sum(ExtendedPrice) AS Invoiced
FROM		Northwind.Invoices
WHERE	Period IS NOT NULL
GROUP BY	Period)
SELECT	Period, [Invoiced], round(avg(Invoiced) 
 		over(ORDER BY ShipDate ROWS BETWEEN UNBOUNDED PRECEDING 
 		AND CURRENT ROW), 2) AS [Running Average]
FROM		MonthlyTotals

/* Because SQLite treats the date as a string, it will sort the Period field created by 
the strftime() function by month and then by year which is not chronological. So, I 
decided to have it supply the first shipped date it found in each monthly period.  
The second half the query can use this unformatted date to put the monthly billing 
periods in order. */





