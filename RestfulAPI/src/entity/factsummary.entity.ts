import {Entity, Column, PrimaryColumn} from "typeorm";

@Entity({schema:"example", database:"BD_Ingreso_Vehiculo", name:"fact_summary"})

export class FactSummary{
    @PrimaryColumn()
    CustomerID:number;
    
    @PrimaryColumn()
    CustomerName: string;
    
    @PrimaryColumn()
    SupplierID:number;

    @PrimaryColumn()
    SupplierName:string;

    @PrimaryColumn()
    Mes:number;

    @PrimaryColumn()
    Anio:number;

    @PrimaryColumn()
    Total:number;

    @PrimaryColumn()
    SuperoPromedio:number;

    @PrimaryColumn("decimal",{precision:10,scale:6})
    PorcentajeVentaMensual:number;
}

