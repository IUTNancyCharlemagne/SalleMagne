import {db} from "../knex.js";
import {hash, genSalt, compare} from "bcrypt";
import {encode} from "../services/JWTService.js";

export async function PostInscription(req, res) {
    const headers = req.headers
    const auth = headers["Authorization"]
    const b64 = auth.split(" ")[1]
    const text = atob(b64)
    const email = text.split(":")[0]
    const password = text.split(":")[1]
    const nom = req.body.nom
    const prenom = req.body.prenom

    const nbRow = await db("Etudiant").count("* as nb").where("email", email)

    if(nbRow[0].nb > 0){
        res.status(401)
        res.json({error: "Email déjà utilisé"})
        return
    }

    const passwdhash = await hash(password, await genSalt(10))

    try {
        const imp = await db("Etudiant").insert({email: email, mdp: passwdhash, prenom: prenom, nom: nom})
        res.status(201)
        res.json({status: 0, message: "ligne insérée"})
    } catch (e) {
        res.json({error: e})
    }
}
