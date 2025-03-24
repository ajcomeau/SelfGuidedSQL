
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


-- ************************************
-- 2.2: Navigating the SQLite Console
-- ************************************

-- 2.2.13 (Chinook):

.mode column
SELECT FirstName, LastName, Company, Phone 
FROM Customers LIMIT 10;

-- 2.2.14:

SELECT first_name, last_name 
FROM sakila.customer LIMIT 10;

-- ************************************
-- 2.3: DB Browser for SQLite
-- ************************************

-- 2.3.7 (Chinook)

SELECT * FROM albums
WHERE title LIKE '%greatest hits%';

-- 2.3.8

DETACH DATABASE Sakila;



-- ************************************
-- 3.2: SELECT Basics
-- ************************************

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

-- ************************************
-- 3.2 Challenge Solutions
-- ************************************

-- 1.)
SELECT InvoiceDate, BillingCity, BillingState, Total
FROM invoices
LIMIT 15;

-- 2.)
SELECT InvoiceDate, BillingCity, BillingState, total
FROM invoices
LIMIT 25 OFFSET 15;

-- 3.)
SELECT Name, Composer, Milliseconds
FROM tracks
LIMIT 100;

-- 4.)
select * from Sakila.category;

-- 5. )
SELECT first_name, last_name, email 
FROM Sakila.customer 
LIMIT 50;

-- ************************************
-- 3.3: Applying Filters: The WHERE clause
-- ************************************

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

-- ************************************
-- 3.3 Challenge Solutions
-- ************************************

-- 1.)
UPDATE customers SET Company = NULL 
WHERE FirstName = 'Astrid' AND LastName = 'Gruber';

-- 2.)

SELECT Title FROM albums WHERE Title LIKE '%live%';

-- 3.)

SELECT name, Composer FROM tracks 
WHERE (Milliseconds BETWEEN 180000 and 240000) 
AND Composer LIKE '%Van Halen%';

--(1000 milliseconds = 1 second * 60 * 3 = 180000. The parentheses around the Milliseconds criteria 
-- aren't strictly necessary but help to set off its use of 'and' from the AND keyword for the second criteria.)

-- 4.)

SELECT CompanyName, Country, Fax
FROM Northwind.customers
WHERE country = 'USA' AND Fax IS NOT NULL;

-- 5.)

SELECT LastName, FirstName, Title, HomePhone, city, Region
FROM Northwind.Employees
WHERE HireDate > '1994-01-01';

-- 6. )

SELECT title, description
FROM Sakila.film
WHERE description LIKE '%drama%' 
AND description NOT LIKE '%space%' 
AND length(description) > 100;

-- 7. )

SELECT timediff('1980-01-01', 'now');
SELECT timediff('now', '1980-01-01');

-- ************************************
-- 3.4: Sorting Data: The ORDER BY Clause
-- ************************************

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

-- ************************************
-- 3.4 Challenge Solutions
-- ************************************

-- 1. )

SELECT	Name, Composer, Milliseconds
FROM		tracks
WHERE	Composer IS NOT NULL
ORDER BY 	Milliseconds DESC
LIMIT	15;

-- 2. )

SELECT Name FROM artists ORDER BY Name;

-- 3. )

SELECT Name FROM artists 
WHERE Name LIKE 'The%' ORDER BY Name;

-- 4. )

SELECT CompanyName, Fax
FROM Customers
WHERE fax IS NOT NULL
ORDER BY CompanyName;

-- 5.)

SELECT title, description, length, special_features
FROM film
WHERE special_features LIKE '%deleted scenes%'
ORDER BY length DESC
LIMIT 50;

-- ************************************
-- 3.5: Joining Tables
-- ************************************

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

-- ************************************
-- 3.5 Challenge Solutions
-- ************************************

-- 1. )

SELECT		i.InvoiceId, i.InvoiceDate,  
 			concat(c.LastName, ', ', c.FirstName) 
 			AS [Customer], 
 			c.Company, c.email
FROM			invoices i
INNER JOIN	customers c
ON			c.CustomerId = i.CustomerId
WHERE		i.InvoiceDate < '2010-01-01'
ORDER BY		i.InvoiceDate;

-- 2. )

SELECT		f.title, r.rental_date, r.return_date, 
 			i.inventory_id
FROM			Sakila.film f
inner JOIN	Sakila.inventory i
ON			i.film_id = f.film_id
INNER JOIN	rental r
ON			r.inventory_id = i.inventory_id
WHERE		f.title = 'ANTITRUST TOMATOES'
OR			f.film_id = 29;

-- 3. )

SELECT		p.ProductName, c.description, 
 			s.CompanyName
FROM			Northwind.Products p
INNER JOIN	Categories c
ON			c.CategoryID = p.CategoryID
INNER JOIN	Suppliers s
ON			s.SupplierID = p.SupplierID
ORDER BY		c.description, p.ProductName;

-- 4. )

SELECT		o.OrderID, c.CompanyName, o.OrderDate, 
 			o.ShippedDate, o.Freight
FROM			Northwind.Orders o
INNER JOIN	Northwind.Shippers s
ON			s.ShipperID = o.ShipVia
INNER JOIN	Northwind.Customers c
ON			c.CustomerId = o.CustomerId
WHERE		s.CompanyName = 'Speedy Express';

-- 5. )

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

-- ************************************
-- 3.6: Defining Groups: The GROUP BY Clause
-- ************************************

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

-- ************************************
-- 3.6 Challenge Solutions
-- ************************************

-- 1. )

SELECT		TOTAL(f.replacement_cost)
FROM			inventory i
INNER JOIN	film f
ON			f.film_id = i.film_id

-- 2. )

SELECT 		p.PlaylistId, p.name, 
 			count(pt.trackID) AS [Track Count]
FROM			playlists p
INNER JOIN  	playlist_track pt
ON 			pt.PlaylistId = p.PlaylistId
GROUP BY 		p.PlaylistId, p.name
HAVING 		[Track Count] = 1
ORDER BY 		[Track Count] DESC;

-- 3. )

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

-- 4. )

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

-- 5. )

SELECT	strftime('%m-%Y', OrderDate) AS [Month], 
 		ROUND(SUM(ExtendedPrice + Freight), 2) 
 		AS [Month Total]
FROM		Invoices
GROUP BY	[Month]
ORDER BY	OrderDate;

-- ************************************
-- 3.7: Breaking it Down: Subqueries and Common Table Expressions
-- ************************************

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

-- ************************************
-- 3.7 Challenge solutions
-- ************************************

-- 1. )

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

-- 2. )

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

-- 3. )

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

-- 4. )

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

-- 5. )

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

-- ************************************
-- 3.8 Storing Queries: Creating Views
-- ************************************

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

-- ************************************	
-- 3.8 Challenge Solutions
-- ************************************

-- 1. )

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

-- 2. )

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

-- 3. )

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

-- 4. )

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

-- ************************************
-- 3.9 - Combining Queries: Unions, Intersections and Exceptions
-- ************************************

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

-- ************************************
-- 3.9 Challenge Solutions
-- ************************************

-- 1. )

SELECT 	CustomerID
FROM 	Northwind.Customers
EXCEPT
SELECT CustomerID
FROM 	Northwind.Orders;

-- 2. )

SELECT	LastName, FirstName
FROM	employees
WHERE	EmployeeId IN
 	(SELECT	EmployeeId
 	FROM		employees
 	INTERSECT
 	SELECT	SupportRepId
 	FROM		customers);

-- You only need to change the INTERSECT to EXCEPT to find non-supporting employees.

-- 3. )

SELECT 		CONCAT(FirstName, " ", LastName) AS [Customer  
 			Name], Company, Address, City, State, 
 			PostalCode, Country,"Chinook" AS [Vendor]
FROM 		Chinook.customers
UNION
SELECT 		ContactName, CompanyName, Address, City, 
 			Region, PostalCode, Country, "Northwind" AS 
 			[Vendor]
FROM 		Northwind.customers;

-- 4. )

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

-- 5. )

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

-- ************************************
-- 3.10 - Finding it Faster: Full Text Search
-- ************************************

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

-- ************************************
-- 3.10 Challenge Solutions
-- ************************************

-- 1. )

CREATE VIRTUAL TABLE fts_TrackListing 
USING FTS5(TrackID, track, album, artist, composer, minutes, perunit, CONTENT=vTrackListing, CONTENT_ROWID=TrackID);

INSERT INTO fts_TrackListing(fts_TrackListing) 
VALUES ('rebuild');

SELECT *, rank FROM fts_TrackListing 
WHERE fts_TrackListing MATCH 'rock';

SELECT *, rank 
FROM fts_TrackListing 
WHERE fts_TrackListing MATCH 'young*';

-- 2. )

SELECT * FROM fts_TrackListing 
WHERE fts_TrackListing MATCH 'wild* NOT wild';

-- 3. )

SELECT highlight(fts_TrackListing, 1, '[', ']') as Track, Album, Artist 
FROM fts_TrackListing 
WHERE fts_TrackListing MATCH 'shout';

-- 4. )

SELECT title, snippet(fts_films, 1, '[', ']', '...', 10) AS Description 
FROM fts_films 
WHERE fts_films MATCH 'scientist teacher';

-- ************************************
-- 3.11 - Analysing Data: Window Functions
-- ************************************

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

-- 3.11.15

SELECT		FirstName, LastName, Company, Phone, Fax, email, 
			ntile (4) over(order by LastName) AS [Call Group]
FROM		customers; 

-- ************************************
-- 3.11 Challenge Solutions
-- ************************************

-- 1.	)

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


-- 2.)

SELECT 	actors, COUNT(*) as Roles, 
 		dense_rank() over(order by COUNT(*) desc) AS Place
FROM		film_list
GROUP BY	actors

-- 3.)

SELECT	fl.*, f.release_year, first_value(fl.title) 
 		over(PARTITION BY actors ORDER BY release_year) AS 
 		[Introductory Role]
FROM		film_list fl
INNER JOIN film f
ON 		f.film_id = fl.FID



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

-- 4.)

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



-- 5.) 

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

-- ************************************
-- 4.1 - Revising Data: UPDATE Operations
-- ************************************

-- 4.1.1

SELECT 	LastName, FirstName, datetime(BirthDate, '+20 years'), 
 		datetime(HireDate, '+15 years') 
FROM		employees;


-- 4.1.2

UPDATE 	employees
SET		Birthdate = datetime(BirthDate, '+20 years'), 
 		HireDate = datetime(HireDate, '+15 years'); 


-- 4.1.3

UPDATE	employees
SET		Title = 'Marketing Specialist'
WHERE	EmployeeId = 4
RETURNING FirstName, LastName, Title;

-- 4.1.4

UPDATE 	film 
SET 	rental_rate = 4.99, rental_duration = 7
WHERE 	length > 180;

-- 4.1.5

UPDATE 	film 
SET 		(rental_rate, rental_duration) = (4.99,7)
WHERE 	length > 180;


-- 4.1.6

CREATE TEMPORARY TABLE ProductDetails AS
SELECT	ProductID, ProductName, CategoryID, 
 		NULL AS CategoryName, QuantityPerUnit, 
 		UnitPrice, NULL AS UnitsSold
FROM		Northwind.Products
WHERE 	Discontinued = 0;

-- 4.1.7

UPDATE 	ProductDetails AS pd
SET		CategoryName = c.CategoryName
FROM 	Northwind.Categories as c
WHERE	c.CategoryID = pd.CategoryID;

-- 4.1.8

UPDATE 	ProductDetails AS pd
SET		UnitsSold = s.UnitsSold
FROM 	(SELECT	productid, total(Quantity) as UnitsSold
 		FROM 	Northwind.[Order Details] od
 		INNER JOIN Northwind.Orders o
 		ON		o.OrderID = od.OrderID
 		WHERE	strftime('%Y', o.OrderDate) = '2018'
 		GROUP BY	ProductID) s
WHERE	s.ProductID = pd.ProductID;

-- ************************************
-- 4.1 Challenge Solutions
-- ************************************

-- 1.) 

UPDATE employees
SET LastName = 'Michaels'
WHERE EmployeeId = 8
RETURNING EmployeeID, FirstName, LastName;


-- 2.)

SELECT	FirstName, LastName,
 		concat(FirstName, '_', LastName, '@chinookcorp.org')
FROM 	employees;

UPDATE	employees
SET 		Email = concat(FirstName, '_', LastName,    
 		'@chinookcorp.org');


-- 3.)

SELECT * FROM tracks WHERE UnitPrice <> 0.99;

UPDATE	tracks
SET		UnitPrice = 0.99
WHERE	UnitPrice <> 0.99;

UPDATE	invoice_items as ii
SET		UnitPrice = t.UnitPrice
FROM		tracks t
WHERE	t.TrackId = ii.TrackId;


SELECT	InvoiceId, total(UnitPrice) as [Total]
FROM		invoice_items
GROUP BY 	InvoiceId;

SELECT	i.InvoiceID, i.[Total], ii.[Total]
FROM 	invoices i
INNER JOIN
(SELECT	InvoiceId, total(UnitPrice) as [Total]
FROM		invoice_items
GROUP BY	InvoiceId) ii
ON 		ii.InvoiceId = i.InvoiceId;

UPDATE	invoices as i
SET 		[Total] = ii.[Total]
FROM
(SELECT	InvoiceId, total(UnitPrice) as [Total]
FROM		invoice_items
GROUP BY	InvoiceId) ii
WHERE 	ii.InvoiceId = i.InvoiceId;

SELECT	InvoiceId, count(UnitPrice) AS [TrackCount]
FROM		invoice_items
GROUP BY	InvoiceId;


-- ************************************
-- 4.2 - Adding Data: INSERT Operations
-- ************************************

-- 4.2.1

INSERT INTO genres (name)
VALUES ('New Age')
RETURNING GenreId;

-- 4.2.2

INSERT INTO artists (name)
VALUES ('George Winston')
RETURNING AristID;


-- 4.2.3

INSERT into albums (Title, ArtistId)
VALUES ('Autumn', 
 	(SELECT ArtistId from artists 
 	 WHERE name = 'George Winston'))
RETURNING AlbumID;

WITH Artist as 
(SELECT ArtistId FROM artists WHERE name = 'George Winston')
INSERT INTO albums (Title, ArtistId)
SELECT 'Autumn', a.ArtistId;

-- 4.2.4

INSERT INTO tracks 
 	(Name, AlbumId, MediaTypeId, GenreId, 
 	Composer, Milliseconds, Bytes, UnitPrice)
VALUES
 	('Colors/Dance', 348, 1, 26, 
 	'George Winston', 623000, 19956736, 0.99),
 	('Woods', 348, 1, 26, 
 	'George Winston', 404000, 12944384, 0.99),
 	('Longing/Love', 348, 1, 26, 
 	'George Winston', 527000, 16885760, 0.99),
 	('Road', 348, 1, 26, 
 	'George Winston', 253000, 8116224, 0.99),
 	('Moon', 348, 1, 26, 
 	'David Poe / George Winston', 462000, 14797824, 0.99),
 	('Sea', 348, 1, 26, 
 	'George Winston', 161000, 5163008, 0.99),
 	('Stars', 348, 1, 26, 
 	'Steve Hillier / George Winston', 342000, 10961920, 0.99)
RETURNING TrackID, Name;


-- 4.2.5

INSERT INTO playlists VALUES (NULL, 'R.E.M');

-- 4.2.6

INSERT INTO playlist_track
SELECT 19, TrackId FROM tracks t
WHERE t.Composer = 'R.E.M.';

WITH playlist as
(SELECT PlaylistId FROM playlists WHERE name = 'R.E.M.')
INSERT INTO	playlist_track (PlaylistId, TrackId)
SELECT 		p.PlaylistId, t.TrackId
FROM 		tracks t, playlist p
WHERE 		t.Composer = 'R.E.M.';


-- 4.2.7

INSERT INTO Products (ProductName) 
VALUES ('Caramel Syrup');

-- 4.2.8

SELECT 	sql 
FROM 	Northwind.sqlite_master 
WHERE	type='table' AND name='Orders'; 


-- 4.2.9

SELECT	* 
FROM	sqlite_sequence;

-- 4.2.10

INSERT INTO 	Customers (CustomerId, CompanyName)
VALUES		('NORTP', 'NorthPointe Retailers');

-- 4.2.11

INSERT OR REPLACE INTO
 	Customers (CustomerID, CompanyName, ContactName,  
 			ContactTitle)
VALUES ('NORTP', 'NorthPointe Retailers', 'Anna Magnuson', 
 		'Senior Purchaser');

-- 4.2.12

INSERT INTO
 	Northwind.Customers (CustomerID, ContactName, ContactTitle)
VALUES ('NORTP', 'Anna Park', 'Chief Purchaser')
ON CONFLICT (CustomerId) DO UPDATE
SET	ContactName = excluded.ContactName,
 	ContactTitle = excluded.ContactTitle;

INSERT INTO
 	Northwind.Customers (CustomerID, ContactName, ContactTitle)
SELECT CustomerID, ContactName, ContactTitle
FROM NewCustomers WHERE True
ON CONFLICT (CustomerId) DO UPDATE
SET	ContactName = excluded.ContactName,
 	ContactTitle = excluded.ContactTitle;


-- 4.12.13

INSERT OR IGNORE INTO
Customers (CustomerID, CompanyName, ContactName, ContactTitle)
VALUES ('NORTP', 'NorthPointe Retailers', 'Thomas Mason', 
 		'Purchasing Agent');


INSERT OR REPLACE INTO
Customers (CustomerID, CompanyName, ContactName, 
 		ContactTitle, Address, City, Region, PostalCode, 
 		Country, Phone, Fax)
SELECT	CustomerID, CompanyName, ContactName, ContactTitle, 
 		Address, City, Region, PostalCode, Country, Phone, 
 		Fax 
FROM		CustomerImport
WHERE 	Region = 'North America';

-- ************************************
-- 4.2 Challenge Solutions
-- ************************************

-- 1.)

INSERT INTO Northwind.Categories
(CategoryName, Description)
VALUES
('Snacks', 'Chips, pretzels, popcorn and other packaged snack foods'),
('Herbs and Spices', 'All natural flavorings for cooking and baking'),
('Gourmet Foods', 'Premium delicacies including wines and cheeses suitable for gifting');


-- 2.)

INSERT INTO Northwind.Products
(ProductName, SupplierID, CategoryID, QuantityPerUnit, UnitPrice)
VALUES
('Petite Jalapeno Brie', 25, 11, '3-3oz. Rounds', 12.99);


PRAGMA Chinook.table_info('customers');
PRAGMA Northwind.table_info('customers');
PRAGMA Sakila.table_info('customer');


INSERT INTO Customers (FirstName, LastName, Email)
VALUES ('Thomas','Wilson','twilson@selfguidedsql.com');


INSERT INTO Northwind.Customers (CustomerId, CompanyName)
VALUES ('COMEA','Comeau Software Solutions');


SELECT country_id FROM country 
WHERE country = 'United States';


INSERT INTO city (city_id, city, country_id, last_update)
VALUES (
(SELECT max(city_id) FROM city) + 1, 
'Ocala', 103, datetime()
)
RETURNING city_id;


PRAGMA table_info('address');

INSERT INTO address 
(address_id, address, district, city_id, phone, last_update)
VALUES(
(SELECT max(address_id) FROM address) + 1,
'(Address Here)', '', 601, '', datetime()
);


INSERT INTO Customer
(customer_id, store_id, first_name, last_name, address_id, create_date, last_update)
VALUES
((SELECT max(customer_id) FROM Customer) + 1,
1, 'Thomas', 'Wilson', 606, datetime(), datetime());

-- 3.)

PRAGMA Chinook.table_info('customers');
PRAGMA Northwind.table_info('customers');
PRAGMA Sakila.table_info('customer');

INSERT INTO Customers (FirstName, LastName, Email)
VALUES ('Thomas','Wilson','twilson@selfguidedsql.com');


INSERT INTO Northwind.Customers (CustomerId, CompanyName)
VALUES ('COMEA','Comeau Software Solutions');


SELECT country_id FROM country 
WHERE country = 'United States';

INSERT INTO city (city_id, city, country_id, last_update)
VALUES (
(SELECT max(city_id) FROM city) + 1, 
'Ocala', 103, datetime()
)
RETURNING city_id;


PRAGMA table_info('address');

INSERT INTO address 
(address_id, address, district, city_id, phone, last_update)
VALUES(
(SELECT max(address_id) FROM address) + 1,
'(Address Here)', '', 601, '', datetime()
);


INSERT INTO Customer
(customer_id, store_id, first_name, last_name, address_id, create_date, last_update)
VALUES
((SELECT max(customer_id) FROM Customer) + 1,
1, 'Thomas', 'Wilson', 606, datetime(), datetime());



-- ************************************
-- 4.3 - Removing Data:  DELETE Operations
-- ************************************

-- 4.3.1

DELETE FROM Orders WHERE OrderID = 10248;

-- 4.3.2

SELECT sql FROM sqlite_master 
WHERE type='table' AND name='Order Details';


-- 4.3.3

CREATE TEMPORARY TABLE NorthwindOrders
AS
SELECT * FROM Orders;

CREATE TEMPORARY TABLE NorthwindOrderDetails
AS
SELECT * FROM [Order Details];

-- 4.3.4

DELETE FROM NorthwindOrders WHERE OrderID = 10248
RETURNING *;

-- 4.3.5

SELECT * FROM NorthwindOrders WHERE ShipCountry = 'France';
Easily becomes - 
DELETE FROM NorthwindOrders WHERE ShipCountry = 'France';

-- 4.3.6

DELETE FROM
employees
ORDER BY hiredate DESC
LIMIT 1; 

-- 4.3.7

DELETE FROM
NorthwindOrderDetails
WHERE ProductID IN
(SELECT ProductID FROM Products 
 WHERE ProductName = 'Alice Mutton');

-- 4.3.8

DROP TABLE IF EXISTS NorthwindOrderDetails;

CREATE TEMPORARY TABLE NorthwindOrderDetails AS 
SELECT * FROM [Order Details];

DELETE from NorthwindOrderDetails 
WHERE OrderID > 10248;

DELETE FROM NorthwindOrderDetails;

-- ************************************
-- 4.3 Challenge Solutions
-- ************************************

-- 1.)

SELECT MAX(EmployeeID) FROM employees;

DELETE FROM EmployeeCopy
WHERE EmployeeId = (SELECT max(EmployeeId) FROM EmployeeCopy);

-- 2.)

SELECT TrackId FROM tracks t
INNER JOIN albums a 
ON a.AlbumId = t.AlbumId
WHERE title = 'Temple of the Dog';

SELECT * FROM sqlite_master 
WHERE type='table' and sql LIKE '%tracks%';

DELETE FROM invoice_items
WHERE TrackId IN
(SELECT TrackId
FROM tracks t
INNER JOIN albums a
ON a.AlbumId = t.AlbumId
WHERE title = 'Temple of the Dog');

DELETE FROM playlist_track
WHERE TrackId IN
(SELECT TrackId
FROM tracks t
INNER JOIN albums a
ON a.AlbumId = t.AlbumId
WHERE title = 'Temple of the Dog');

DELETE FROM tracks
WHERE AlbumId IN
(SELECT AlbumId FROM albums 
WHERE title = 'Temple of the Dog');

DELETE FROM albums 
WHERE title = 'Temple of the Dog';

-- 3.)

SELECT * FROM invoices i
LEFT JOIN invoice_items ii
ON ii.InvoiceId = i.InvoiceId
WHERE ii.InvoiceId = NULL; 

SELECT i.InvoiceId, COUNT(ii.InvoiceLineId)
FROM invoices i
LEFT JOIN invoice_items ii
ON ii.InvoiceId = i.InvoiceId
GROUP BY i.InvoiceId;















