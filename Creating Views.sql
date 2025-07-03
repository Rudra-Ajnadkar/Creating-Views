CREATE VIEW CustomerOrderSummary AS
SELECT c.CustomerID, c.Name, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Name;


-- Use the View Like a Table

SELECT * FROM CustomerOrderSummary
WHERE TotalOrders > 1;

-- Create a View for Product Sales

CREATE VIEW ProductSales AS
SELECT p.ProductID, p.Product, SUM(od.Quantity * od.Price) AS TotalRevenue
FROM Products p
JOIN OrderDetail od ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.Product;


-- Create a View with a Nested Query

CREATE VIEW HighValueCustomers AS
SELECT c.CustomerID, c.Name
FROM Customers c
WHERE c.CustomerID IN (
    SELECT o.CustomerID
    FROM Orders o
    JOIN OrderDetail od ON o.OrderID = od.OrderID
    GROUP BY o.CustomerID
    HAVING SUM(od.Quantity * od.Price) > 10000
);

