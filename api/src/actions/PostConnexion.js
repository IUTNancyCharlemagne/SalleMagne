import {db} from "../knex.js";
import {hash, genSalt, compare} from "bcrypt";
import {encode} from "../services/JWTService.js";

export async function PostConnexion(req, res) {

    const headers = req.headers
    const auth = headers["Authorization"]
    const b64 = auth.split(" ")[1]
    const text = atob(b64)
    const email = text.split(":")[0]
    const password = text.split(":")[1]

    const etu = await db("Etudiant").select("*").where("email", email).first
    const resCompare = await compare(password, etu.mdp)
    if(resCompare){
        res.status(202)
        const token = encode({id: etu.id})
        res.json({token: token})
    } else {
        res.status(401)
        res.json({error: "Mot de passe ou login incorrecte"})
    }

    // Récupérer l'id du gars avec son access token
    const id = 1;

    const fav = await db.select('salle').from('Favoris').where('id_etudiant', id)
    res.json({data: fav})
}
