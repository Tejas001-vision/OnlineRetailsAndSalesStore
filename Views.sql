--View: Daily Sales Summary
CREATE VIEW vw_DailySalesSummary AS
SELECT 
    CAST(O.OrderDate AS DATE) AS OrderDate,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalSales,
    COUNT(DISTINCT O.OrderID) AS TotalOrders
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY CAST(O.OrderDate AS DATE);

--View: Customer Purchase Summary
CREATE VIEW vw_CustomerPurchaseSummary AS
SELECT 
    C.CustomerID,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    COUNT(O.OrderID) AS TotalOrders,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
GROUP BY C.CustomerID, C.FirstName, C.LastName;

--View: Top Selling Products
CREATE VIEW vw_TopSellingProducts AS
SELECT 
    P.ProductID,
    P.ProductName,
    SUM(OD.Quantity) AS TotalQuantitySold,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalRevenue
FROM Products P
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY P.ProductID, P.ProductName;

--View: Category Revenue Report
CREATE VIEW vw_CategoryRevenue AS
SELECT 
    PC.CategoryName,
    SUM(OD.Quantity * OD.UnitPrice) AS TotalRevenue
FROM Products P
JOIN ProductCategories PC ON P.CategoryID = PC.CategoryID
JOIN OrderDetails OD ON P.ProductID = OD.ProductID
GROUP BY PC.CategoryName;

--View: Payment Status Report
CREATE VIEW vw_PaymentStatusReport AS
SELECT 
    P.PaymentID,
    O.OrderCode,
    C.FirstName + ' ' + C.LastName AS CustomerName,
    P.PaymentMode,
    P.PaymentStatus,
    P.PaymentAmount,
    P.PaymentDate
FROM Payments P
JOIN Orders O ON P.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID;
