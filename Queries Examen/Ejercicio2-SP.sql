CREATE PROCEDURE example.SP_ADD_FACT_SUMARRY
    @CustomerID INT,
    @CustomerName NVARCHAR(100),
    @SupplierID INT,
    @SupplierName NVARCHAR(100),
    @Mes INT,
    @SuperoPromedio INT,
    @PorcentajeVentaMensual decimal (10,10),
    @SettingID INT
AS 

INSERT INTO example.fact_summary VALUES()

GO