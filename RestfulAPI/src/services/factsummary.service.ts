import {Request, Response} from "express";
import {getConnection} from "typeorm";
import {FactSummary} from "../entity/factsummary.entity";

export class FactSummaryService{

    public async GetFactSummary(req: Request, res:Response){
        const runSP: FactSummary[] = await getConnection().query('EXEC example.SP_ADD_FACT_SUMARRY');

        res.status(201).json(runSP);
    }

    public async FactSummaryOneCustomer(req: Request, res: Response){
        const factsummary: FactSummary[] = await getConnection().getRepository(FactSummary).find({where: {CustomerID: req.params.id}});
        res.status(200).json(factsummary);
    }
}