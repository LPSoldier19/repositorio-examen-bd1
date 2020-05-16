import {Entity, Column, PrimaryColumn} from "typeorm";

@Entity({schema:"example", database:"BD_Ingreso_Vehiculo", name: "Supplier"})

export class Supplier{
    @PrimaryColumn()
    SupplierID: number;

    @Column()
    SupplierName: string;
    
    @Column()
    ContactName: string;
    
    @Column()
    Address: string;
    
    @Column()
    City: string;
    
    @Column()
    PostalCode: string;
    
    @Column()
    Country: string;
    
    @Column()
    Phone: string;
}

export interface ISupplier{
    SupplierID: number;
    SupplierName: string;
    ContactName: string;
    Address: string;
    City: string;
    PostalCode: string;
    Country: string;
    Phone: string;
}

export interface IResult{
    Successed: boolean;
    MSG: string;
}