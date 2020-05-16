DROP tABLE example.fact_summary

CREATE TABLE example.fact_summary(
    CustomerID int,
    CustomerName NVARCHAR(100),
    SupplierID int,
    SupplierName NVARCHAR(100),
    Mes int,
    SuperoPromedio int,
    PorcentajeVentaMensual decimal(10,10),
    SettingID int 
)


CREATE TABLE example.Settings(
    SettingID int not null PRIMARY KEY,
    Anio int  
)



