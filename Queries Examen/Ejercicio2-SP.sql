/*La idea de este SP es que la tabla se llene con la informacion de un solo año
por lo cual tome como idea de que al momento de ejectuar el SP, si ya existe informacion
en la tabla, lo mas recomendable era primero borrar toda la informacion
de la tabla y despues realizar el insert, para asi evitar de que el usuario
tenga que eliminar todos los datos de la tabla de manera manual para despues 
volver a ejectuar el SP. Esa es la logica que he utilizado al momento de crear el SP_ADD_FACT_SUMMARY */

CREATE PROCEDURE example.SP_ADD_FACT_SUMARRY

AS 

DECLARE @existenRegistros INT = (SELECT COUNT(*) FROM example.fact_summary)

IF @existenRegistros > 0 BEGIN

    DELETE FROM example.fact_summary;

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

    INSERT INTO example.fact_summary (
        CustomerID,
        CustomerName,
        SupplierID,
        SupplierName,
        Mes,Anio,Total,
        SuperoPromedio,
        PorcentajeVentaMensual)
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
    WHERE YEAR(o.OrderDate) = (SELECT [Value] FROM example.Settings)
    GROUP BY 
        c.CustomerID,
        c.CustomerName,
        s.SupplierID,
        s.SupplierName,
        MONTH(o.OrderDate),
        YEAR(o.OrderDate),
        sp.promedio,
        v.SumaVentas
    
END ELSE BEGIN  


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

    INSERT INTO example.fact_summary(
        CustomerID,
        CustomerName,
        SupplierID,
        SupplierName,
        Mes,Anio,
        Total,
        SuperoPromedio,
        PorcentajeVentaMensual)
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
    WHERE YEAR(o.OrderDate) = (SELECT [Value] FROM example.Settings)
    GROUP BY 
        c.CustomerID,
        c.CustomerName,
        s.SupplierID,
        s.SupplierName,
        MONTH(o.OrderDate),
        YEAR(o.OrderDate),
        sp.promedio,
        v.SumaVentas
END

    SELECT * FROM example.fact_summary

GO




