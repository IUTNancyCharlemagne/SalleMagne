import express from "express"

const router = express.Router()

router.get("/", (req, res) => res.send("Hello depuis la racine de l'api"))

export default router
