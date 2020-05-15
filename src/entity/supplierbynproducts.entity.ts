import {ViewEntity, ViewColumn} from "typeorm";

@ViewEntity({schema:"example", database:"BD_Ingreso_Vehiculo", name:"ViewSuppliersByNProducts"}) 

export class ViewSupplierByNProducts{
    @ViewColumn()
    SupplierID: number;
    
    @ViewColumn()
    SupplierName: string; 
    
    @ViewColumn()
    number_products: number;    
}

