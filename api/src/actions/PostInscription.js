import {db} from "../knex.js";
import {hash, genSalt, compare} from "bcrypt";

export async function PostInscription(req, res) {
    const auth = req.get("Authorization")
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
        res.json({status: 0, message: "Inscription Okay"})
    } catch (e) {
        res.json({error: e})
    }
}
