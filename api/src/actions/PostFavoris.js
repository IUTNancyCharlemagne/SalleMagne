import {db} from "../knex.js";
import {json} from "express";

export async function PostFavoris(req, res) {
    //Récupérer l'id du gars avec son access token
    const id = req.id;

    const salle = req.body.salle
    try {
        await db('Favoris').insert({id_etudiant: id, salle: salle})
        const fav = await db.select('salle').from('Favoris').where('id_etudiant', id).where('salle', salle)
        res.json({status: 0, message: "ligne insérée", data: fav[0]})
    } catch (e) {
        res.json({error: e})
    }




}
