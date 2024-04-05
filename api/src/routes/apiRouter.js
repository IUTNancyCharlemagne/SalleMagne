import express from "express"
import {getFavoris} from "../actions/GetFavoris.js";
import {PostFavoris} from "../actions/PostFavoris.js";
import {PostInscription} from "../actions/PostInscription.js";
import {PostConnexion} from "../actions/PostConnexion.js";
import {DeleteFavoris} from "../actions/DeleteFavoris.js";
import {GetSalles} from "../actions/GetSalles.js";
import checkToken from "../middlewares/checkToken.js";
import {GetSallesByWeek} from "../actions/GetSallesByWeek.js";

const router = express.Router()

router.get("/", (req, res) => res.send("Hello depuis la racine de l'api"))

router.get("/favoris", checkToken, (req, res) => getFavoris(req, res))
router.post("/favoris", checkToken, (req, res) => PostFavoris(req, res))
router.delete("/favoris", checkToken,(req, res) => DeleteFavoris(req, res))
router.post("/inscription", (req, res) => PostInscription(req, res))
router.post("/connexion", (req, res) => PostConnexion(req, res))
router.get("/salles",(res,req)=>GetSalles(res,req))
router.get("/salles/:week",(res,req)=>GetSallesByWeek(res,req))
export default router
