import {db} from "../knex.js";
import {hash, genSalt, compare} from "bcrypt";
import {encode} from "../services/JWTService.js";

export async function PostConnexion(req, res) {

    const auth = req.get("Authorization")
    if (auth === undefined) {
        res.status(401)
        res.json({status: 1, error: "Authentification requise"})
        return
    }
    if (!auth.startsWith("Basic ")) {
        res.status(401)
        res.json({status: 1, error: "Authentification mal formée"})
        return
    }
    let text = ""
    try {
        const b64 = auth.split(" ")[1]
        text = atob(b64)
    } catch (e) {
        res.status(401)
        res.json({status: 1, error: "Encodage mal fait"})
        return
    }
    const email = text.split(":")[0]
    if (email === "") {
        res.status(401)
        res.json({status: 1, error: "Email requis"})
        return
    }
    const password = text.split(":")[1]
    if (password === "") {
        res.status(401)
        res.json({status: 1, error: "Mot de passe requis"})
        return
    }

    try {
        const etu = await db("Etudiant").select("*").where("email", email)
        const resCompare = await compare(password, etu[0].mdp)
        if (resCompare) {
            res.status(202)
            const token = encode({id: etu[0].id})
            res.json({token: token})
        } else {
            res.status(401)
            res.json({error: "Mot de passe ou login incorrecte"})
        }
    } catch (e) {
        res.status(401)
        res.json({error: "Mot de passe ou login incorrecte"})
    }


}
