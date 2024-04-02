import express from "express"
import {getFavoris} from "../actions/GetFavoris.js";
import {PostFavoris} from "../actions/PostFavoris.js";
import {PostInscription} from "../actions/PostInscription.js";
import {PostConnexion} from "../actions/PostConnexion.js";

const router = express.Router()

router.get("/", (req, res) => res.send("Hello depuis la racine de l'api"))

router.get("/favoris", (req, res) => getFavoris(req, res))
router.post("/favoris", (req, res) => PostFavoris(req, res))
router.post("/inscription", (req, res) => PostInscription(req, res))
router.post("/connexion", (req, res) => PostConnexion(req, res))

export default router