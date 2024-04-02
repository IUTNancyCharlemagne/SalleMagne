import {db} from "../knex.js";

export async function getFavoris(req, res) {

    // Récupérer l'id du gars avec son access token
    const id = req.id;

    const fav = await db.select('salle').from('Favoris').where('id_etudiant', id)
    res.json({data: fav})
}
