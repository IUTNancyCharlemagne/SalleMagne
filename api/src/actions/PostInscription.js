import {db} from "../knex.js";
import {hash, genSalt, compare} from "bcrypt";
import {sanitizeName, validateEmail} from "../utils/sanitize.js";

export async function PostInscription(req, res) {
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

    if (!text.includes(":")) {
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
    if (!validateEmail(email)) {
        res.status(401)
        res.json({status: 1, error: "Email invalide"})
        return
    }
    const password = text.split(":")[1]
    if (password === "") {
        res.status(401)
        res.json({status: 1, error: "Mot de passe requis"})
        return
    }
    let nom = req.body.nom
    if (nom === undefined || nom === "") {
        res.status(401)
        res.json({status: 1, error: "Nom requis"})
        return
    }

    nom = sanitizeName(req.body.nom)

    let prenom = req.body.prenom
    if (prenom === undefined || prenom === "") {
        res.status(401)
        res.json({status: 1, error: "Prénom requis"})
        return
    }

    prenom = sanitizeName(req.body.prenom)

    const nbRow = await db("Etudiant").count("* as nb").where("email", email)

    if (nbRow[0].nb > 0) {
        res.status(401)
        res.json({status: 1, error: "Email déjà utilisé"})
        return
    }

    const passwdhash = await hash(password, await genSalt(10))

    try {
        const imp = await db("Etudiant").insert({email: email, mdp: passwdhash, prenom: prenom, nom: nom})
        res.status(201)
        res.json({status: 0, message: "Inscription Okay"})
    } catch (e) {
        res.json({status: 2, error: e})
    }
}
