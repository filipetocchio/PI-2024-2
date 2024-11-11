import express, { Router } from "express";
import cors from "cors";
import { corsOptions } from "../config/corsOptions";
import { logger } from "../middlewares/logEvents";
import { credentials } from "../middlewares/credentials";
import cookieParser from "cookie-parser";


import { TestRouter } from "./Teste.routers";

export const apiV1Router = Router();

apiV1Router.use(logger);
apiV1Router.use(credentials);
apiV1Router.use(cookieParser());
apiV1Router.use(cors(corsOptions));
apiV1Router.use(express.json());
apiV1Router.use(express.urlencoded({ extended: false }));

apiV1Router.use("/Teste", TestRouter);
