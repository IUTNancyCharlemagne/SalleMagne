import express from "express";
import { createServer } from "http";
import apiRouter from "./routes/apiRouter.js";
import catch404errors from "./middlewares/catch404errors.js";
import catchAllError from "./middlewares/catchAllError.js";
import {startCron} from "./auto/scheduler.js";
import cors from "cors";

const app = express();
const httpServer = createServer(app);

startCron()

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(express.static('public'))
app.get("/", (req, res) => res.send("Hello depuis la racine"))
app.use("/api", apiRouter)

app.use(catch404errors)
app.use(catchAllError)
export {httpServer}
