--Total Revenue Per Month
SELECT 
    FORMAT(O.OrderDate, 'yyyy-MM') AS Month,
    SUM(OD.Quantity * OD.UnitPrice) AS MonthlyRevenue
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY FORMAT(O.OrderDate, 'yyyy-MM')
ORDER BY Month;

--Best Customers (Top 5 by Total Spent)
SELECT TOP 5
    C.CustomerID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY TotalSpent DESC;

--Most Sold Category
SELECT TOP 1
    PC.CategoryName,
    SUM(OD.Quantity) AS TotalUnitsSold
FROM ProductCategories PC
JOIN Products P ON PC.CategoryID = P.CategoryID
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY PC.CategoryName
ORDER BY TotalUnitsSold DESC;

--Orders With Pending Payments
SELECT 
    O.OrderID,
    O.OrderCode,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    P.PaymentStatus,
    P.PaymentAmount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.PaymentStatus = 'Pending';

--Average Order Value per Customer
SELECT 
    C.CustomerID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    AVG(OrderTotal.TotalAmount) AS AverageOrderValue
FROM Customers C
JOIN (
    SELECT O.CustomerID, SUM(OD.Quantity * OD.UnitPrice) AS TotalAmount
    FROM Orders O
    JOIN OrderDetails OD ON O.OrderID = OD.OrderID
    GROUP BY O.OrderID, O.CustomerID
) AS OrderTotal ON C.CustomerID = OrderTotal.CustomerID
GROUP BY C.CustomerID, C.FirstName, C.LastName
ORDER BY AverageOrderValue DESC;
