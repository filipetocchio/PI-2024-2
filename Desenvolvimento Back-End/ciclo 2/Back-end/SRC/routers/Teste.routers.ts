import express from "express";
import TesteController from "../controllers/Teste/Teste.Controller";


export const TestRouter = express.Router();

TestRouter.post("/", (req, res) => TesteController.createTest(req, res));
