import {db} from "../knex.js";
import {json} from "express";

export async function DeleteFavoris(req, res) {
  //Récupérer l'id du gars avec son access token
  const id = 1;

  const salle = req.body.salle
  try {
    await db('Favoris').delete().where('id_etudiant', id).where('salle', salle)
    res.json({status: 0, message: "ligne supprimée"})
  } catch (e) {
    res.json({error: e})
  }




}
