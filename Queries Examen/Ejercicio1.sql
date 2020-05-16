SELECT 
    c.CustomerID,
    c.CustomerName,
    s.SupplierID,
    s.SupplierName,
    MONTH(o.OrderDate) as mes,
    YEAR (o.OrderDate) as anio,
    SUM(od.QUantity * p.Price) as total
FROM example.Customers as c
INNER JOIN example.[Order] as o 
ON c.CustomerID = o.CustumerID
INNEr JOIN example.OrderDetail as od 
ON o.OrderID = od.OrderID
INNER JOIN example.product as p 
ON od.ProductID = p.ProductoID
INNER JOIN example.Supplier as s 
ON p.SupplierID = s.SupplierID
GROUP BY 
    c.CustomerID,
    c.CustomerName,
    s.SupplierID,
    s.SupplierName,
    MONTH(o.OrderDate),
    YEAR(o.OrderDate)

