import {db} from "../knex.js";
import {hash, genSalt, compare} from "bcrypt";
import {encode} from "../services/JWTService.js";

export async function PostConnexion(req, res) {

    try{
        const auth = req.get("Authorization")
        const b64 = auth.split(" ")[1]
        const text = atob(b64)
        const email = text.split(":")[0]
        const password = text.split(":")[1]

        const etu = await db("Etudiant").select("*").where("email", email)
        const resCompare = await compare(password, etu[0].mdp)
        if(resCompare){
            res.status(202)
            const token = encode({id: etu[0].id})
            res.json({token: token})
        } else {
            res.status(401)
            res.json({error: "Mot de passe ou login incorrecte"})
        }
    } catch (e) {
        res.status(500)
        res.json({error: e})
    }

}
