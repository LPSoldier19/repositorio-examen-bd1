import express,{Application} from "express";

import bodyParser from "body-parser";
import cors from "cors";

import {config} from "dotenv";
import {resolve} from "path";

config({"path": resolve(__dirname,"../.env")});

import {createConnection} from "typeorm";

import {MainController} from "./controller/main.controller";

import {SupplierController} from "./controller/supplier.controller";

import {FactSummaryController} from "./controller/factsummary.controller";

class App{

    public app: Application;
    public main_controller: MainController;
    public supplier_controller: SupplierController;
    public factsummary_controller : FactSummaryController;

    constructor(){
        this.app = express();
        this.setConfig();
        this.setDBConnection();
        this.main_controller = new MainController(this.app);
        this.supplier_controller = new SupplierController(this.app);
        this.factsummary_controller = new FactSummaryController(this.app);
    }

    private setConfig(){
        this.app.use(bodyParser.json({limit: "50mb"}));
        this.app.use(bodyParser.urlencoded({limit: "50mb"}));
        this.app.use(cors());
    }

    private setDBConnection(){
        createConnection().then(connection=>{
            console.log("BD Connected");
        })
    }

}

export default new App().app;

