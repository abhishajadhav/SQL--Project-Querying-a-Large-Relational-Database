USE AdventureWorks2012;

1) -- Get all the details from the person table including email ID, phone number and phone number type

SELECT         
    EmailAddress.EmailAddress,        -- Email address from the EmailAddress table
    PersonPhone.PhoneNumber,          -- Phone number from the PersonPhone table
    PersonPhone.PhoneNumberTypeID      -- Phone number type from the PersonPhone table
FROM 
    Person.EmailAddress              -- EmailAddress table
LEFT JOIN 
    Person.PersonPhone               -- PersonPhone table to get phone details
    ON EmailAddress.BusinessEntityID = PersonPhone.BusinessEntityID;  -- Join on BusinessEntityID

2)-- Get the details of the sales header order made in May 2011
SELECT 
    SalesOrderID,              -- Sales Order ID
    OrderDate,                 -- Order Date
    TotalDue,                  -- Total amount due 
    CustomerID,                -- Customer ID 
    Status                     -- Status of the order 
FROM 
    Sales.SalesOrderHeader     -- Sales order header table
WHERE 
    OrderDate >= '2011-05-01' AND 
    OrderDate < '2011-06-01';  -- Filter for May 2011

3)--Get the details of the sales details order made in the month of May 2011


SELECT 
    SalesOrderDetail.SalesOrderID,     -- Sales Order ID from SalesOrderDetail
    SalesOrderDetail.SalesOrderDetailID,  -- Sales Order Detail ID
    SalesOrderDetail.ProductID,         -- Product ID from SalesOrderDetail
    SalesOrderDetail.OrderQty,          -- Order quantity from SalesOrderDetail
    SalesOrderDetail.LineTotal,         -- Line total for the item 
    SalesOrderHeader.OrderDate,         -- Order date from SalesOrderHeader 
    SalesOrderHeader.Status             -- Status of the order from SalesOrderHeader 
FROM 
    Sales.SalesOrderDetail              -- Sales Order Detail table 
INNER JOIN 
    Sales.SalesOrderHeader              -- Sales Order Header table 
    ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID  -- Join on SalesOrderID
WHERE 
    SalesOrderHeader.OrderDate >= '2011-05-01' AND 
    SalesOrderHeader.OrderDate < '2011-06-01';  

4) ---. Get the total sales made in May 2011

SELECT 
    SUM(SalesOrderDetail.LineTotal) AS TotalSales  -- Sum of all line totals for May 2011
FROM 
    Sales.SalesOrderDetail                      -- Sales Order Detail table 
INNER JOIN 
    Sales.SalesOrderHeader                      -- Sales Order Header table 
    ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID  -- Join on SalesOrderID
WHERE 
    SalesOrderHeader.OrderDate >= '2011-05-01' AND 
    SalesOrderHeader.OrderDate < '2011-06-01';  -- Filter for May 2011

5)-- Get the total sales made in the year 2011 by month order by 

SELECT 
    MONTH(OrderDate) AS SalesMonth, 
    SUM(LineTotal) AS TotalSales
FROM 
    Sales.SalesOrderDetail
JOIN 
    Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
WHERE 
    OrderDate BETWEEN '2011-01-01' AND '2011-12-31'
GROUP BY 
    MONTH(OrderDate)
ORDER BY 
    TotalSales ASC;

6) --- Get the total sales made to the customer with FirstName='Gustavo'  and LastName ='Achong'

SELECT 
    SUM(SalesOrderDetail.LineTotal) AS TotalSales  -- Sum of line totals
FROM 
    Sales.SalesOrderDetail
JOIN 
    Sales.SalesOrderHeader ON Sales.SalesOrderDetail.SalesOrderID = Sales.SalesOrderHeader.SalesOrderID
JOIN 
    Sales.Customer ON Sales.SalesOrderHeader.CustomerID = Sales.Customer.CustomerID
JOIN 
    Person.Person ON Sales.Customer.PersonID = Person.Person.BusinessEntityID  -- Link to the Person table
WHERE 
    Person.Person.FirstName = 'Gustavo' AND 
    Person.Person.LastName = 'Achong';