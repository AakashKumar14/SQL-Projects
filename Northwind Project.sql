

-- 1.	Which Shippers do we have in the dataset?
select * 
from dbo.Shippers;




-- 2. Write a query to show the count of shippers in the dataset
Select 
count (ShipperID) as Shippers_Count
from Shippers




-- 3.	Write a query to show CategoryName and Description columns from the Categories Table. How many records do you see?
select CategoryName,Description 
from Categories




-- 4.	Show the Full Name of all employees with the title ‘Sales Representative’ from the Employees table. Full Name is derived by using concatenation between First Name and Last Name. How many employee records do you see?

select 
concat([firstName], [LastName]) as SalesRepresenrtative
from employees;




-- 5. From Question 4 above, show the Full Name and Hiring Date of Employees hired after 1st January 2011. How many records do you see?

select 
concat([firstName], [LastName]) as SalesRepresenrtative
from employees
where HireDate > '2011-01-01 00:00:00.000';




-- 6.	Write a query to show the count of Employees based in London

select count(city) as EmployeesInLondon
from Employees
where City = 'London';




-- 7.	In the Suppliers table, show the SupplierID, ContactName, and ContactTitle for those Suppliers whose ContactTitle is not Marketing Manager.

select SupplierID, ContactName, ContactTitle 
from Suppliers
where ContactTitle <> 'Marketing Manager';





-- 8.	Using the Orders table, count the number of orders placed by the employee have EmployeeID equal to 5. How many records do you see?

select 
count(employeeID) as Employee5 from Orders
where EmployeeID = 5;





--9.In the products table, show the ProductID and ProductName for those products where the ProductName includes the string “queso”. How many records do you see?

select ProductID, ProductName
from Products
where ProductName like '%queso%';





-- 10.	Using the Orders table, there’s a field called ShipCountry. Write a query that shows the OrderID, CustomerID, and ShipCountry for the orders where the ShipCountry is either France or Belgium.

select OrderID,CustomerID, ShipCountry from Orders
where ShipCountry = 'France' or ShipCountry = 'Belgium';





-- 11.	Repeat Question 10 for ShipCountry either Brazil, Argentina, Mexico or Venezuela. How many records do you see?

select OrderID,CustomerID, ShipCountry from Orders
where ShipCountry in ( 'Brazil', 'Argentina', 'Mexico', 'Venezuela');





-- 12.	For all the employees in the Employees table, show the FirstName, LastName, Title, and BirthDate. Order the results by BirthDate, so we have the record for the oldest employees first.

select FirstName,LastName,Title,BirthDate
from Employees
order by BirthDate





--  13.	In the OrderDetails table, we have the fields UnitPrice and Quantity. Create a new field, TotalPrice, that multiplies these two together. The output should show the OrderID, ProductID, UnitPrice, Quantity and Total Price.

select 
OrderID, 
ProductID, 
UnitPrice, 
Quantity,
sum(UnitPrice * Quantity) as TotalPrice from [Order Details]
Group BY
OrderID, 
ProductID, 
UnitPrice, 
Quantity;




-- 14.	How many customers do we have in the Customers table? Show the result as CustomerCount using aliasing

select 
count(customerID) as CustomerCount 
from Customers;




-- 15.	Show the date of the first order ever made in the Orders table. Show the result as FirstOrder using aliasing

select * from Orders;

select top (1)
orderDate,
min(orderID) as FirstOrder from Orders
Group By
orderDate
order by 
orderDate





-- 16.	Write a query to show the list of countries where the Northwind company has customers using the Customers table

select distinct Country
from Customers;




-- 17.	Write a query to show the count of customers in each country using the Customers table. How many records do you see?

select  Country,  
count(customerID) as CustomerCount 
from Customers
group by Country;




-- 18.	Write a query to show list of all the different values in the Customers table for ContactTitles. Also include a count for each ContactTitle. How many records do you see?

select ContactTitle, 
Count(ContactTitle) as TitleCount 
from Customers
group by
ContactTitle




-- 19.	Write a query to show the count of companies from the Customers table where the Region is specified as NULL. How many records do you see?

Select * from Customers

select Count(distinct CompanyName) as NullRecords
from Customers
where Region is null;




-- 20.	Write a query to give a count of Orders placed between 1st January, 1996 and 31st December 1996 using the Orders table.

select count(orderID) as ID_Count , OrderDate from Orders
group by OrderDate
Having OrderDate between '1996-07-04 00:00:00.000' and '1996-12-31 00:00:00.000';




-- 21.	Using the Orders table, give a sum of Freight charges on Orders placed by each Employee. Your output should show EmployeeID and TotalFreight. Sort the result in descending order

select EmployeeID, sum( freight) as TotalFreight from Orders
group by EmployeeID
Order by EmployeeID DESC;