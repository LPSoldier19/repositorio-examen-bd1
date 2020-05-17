import {Application} from "express";
import {FactSummaryService} from "../services/factsummary.service";

export class FactSummaryController{

    fact_summary_service : FactSummaryService;
    constructor(private app: Application){
        this.fact_summary_service = new FactSummaryService();
        this.routes();
    }

    private routes(){
        this.app.route("/factsummary").get(this.fact_summary_service.GetFactSummary);

        this.app.route("/factsummary/:id").get(this.fact_summary_service.FactSummaryOneCustomer);
    }
}