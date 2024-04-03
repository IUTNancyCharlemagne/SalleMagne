import express from "express";
import { createServer } from "http";
import apiRouter from "./routes/apiRouter.js";
import catch404errors from "./middlewares/catch404errors.js";
import catchAllError from "./middlewares/catchAllError.js";
import {startCron} from "./auto/scheduler.js";
import {readFileSync} from "fs";
import * as https from "https";
import cors from "cors";

const privateKey = readFileSync('./certs/privkey.key', 'utf8');
const certificate = readFileSync('./certs/cert.cer', 'utf8');

const credentials = {key: privateKey, cert: certificate}
const app = express();
const httpServer = createServer(app);
const httpsServer = https.createServer(credentials, app);

startCron()

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cors());
app.use(express.static('public'))
app.get("/", (req, res) => res.send("Hello depuis la racine"))
app.use("/api", apiRouter)

app.use(catch404errors)
app.use(catchAllError)
export {httpServer, httpsServer}
