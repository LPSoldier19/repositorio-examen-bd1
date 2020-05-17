WITH 
    Promedio AS (
        SELECT 
            s.SupplierID as SupplierID,
            MONTH(o.OrderDate) as mes,
            AVG(od.QUantity * p.Price) as promedio
        FROM example.Customers as c
        INNER JOIN example.[Order] as o 
        ON c.CustomerID = o.CustumerID
        INNER JOIN example.OrderDetail as od 
        ON o.OrderID = od.OrderID
        INNER JOIN example.product as p 
        ON od.ProductID = p.ProductoID
        INNER JOIN example.Supplier as s 
        ON p.SupplierID = s.SupplierID
        GROUP BY 
            s.SupplierID,
            MONTH(o.OrderDate)),

    VentaMensual AS (
        SELECT 
            c.CustomerID as CustomerID,
            SUM(od.QUantity * p.Price) as SumaVentas
        FROM example.Customers as c
        INNER JOIN example.[Order] as o 
        ON c.CustomerID = o.CustumerID
        INNER JOIN example.OrderDetail as od 
        ON o.OrderID = od.OrderID
        INNER JOIN example.product as p 
        ON od.ProductID = p.ProductoID
        INNER JOIN example.Supplier as s 
        ON p.SupplierID = s.SupplierID
        GROUP BY 
            c.CustomerID
    )

SELECT 
    c.CustomerID,
    c.CustomerName,
    s.SupplierID,
    s.SupplierName,
    MONTH(o.OrderDate) as mes,
    YEAR(o.OrderDate) as anio,
    SUM(od.QUantity * p.Price) as total,
    CASE
        WHEN SUM(od.QUantity * p.Price) < sp.promedio THEN 0
        ELSE 1
    END AS SuperoPromedio,
    CONVERT(DECIMAL(10,6),SUM(od.QUantity * p.Price)/v.SumaVentas) as PorcentajeVentaMensual
FROM example.Customers as c
INNER JOIN example.[Order] as o 
ON c.CustomerID = o.CustumerID
INNER JOIN example.OrderDetail as od 
ON o.OrderID = od.OrderID
INNER JOIN example.product as p 
ON od.ProductID = p.ProductoID
INNER JOIN example.Supplier as s 
ON p.SupplierID = s.SupplierID
INNER JOIN Promedio as sp
ON sp.SupplierID = s.SupplierID and sp.mes = MONTH(o.OrderDate)
INNER JOIN VentaMensual as v 
ON v.CustomerID = c.CustomerID
GROUP BY 
    c.CustomerID,
    c.CustomerName,
    s.SupplierID,
    s.SupplierName,
    MONTH(o.OrderDate),
    YEAR(o.OrderDate),
    sp.promedio,
    v.SumaVentas


