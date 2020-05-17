CREATE TABLE example.fact_summary(
    CustomerID int,
    CustomerName NVARCHAR(100),
    SupplierID int,
    SupplierName NVARCHAR(100),
    Mes int,
    Anio int,
    Total int,
    SuperoPromedio int,
    PorcentajeVentaMensual DECIMAL (10,6)
)


CREATE TABLE example.Settings(
    [key] NVARCHAR(100),
    [Value] int  
)

INSERT INTO example.Settings([key],[Value]) VALUES ('Anio',1996)



