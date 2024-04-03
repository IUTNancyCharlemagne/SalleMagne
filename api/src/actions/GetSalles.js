import fs from 'fs';
import util from 'util';
import ICAL from 'ical.js';


//Récupère les salles de l'agenda et les filtre selon les paramètres donnés
export async function GetSalles(req, res) {
    try {
        //récupère les données du fichier ics
        const readFile = util.promisify(fs.readFile);
        const icsData = await readFile('./public/ADECAL.ics', 'utf8');
        const jcalData = ICAL.parse(icsData);
        const comp = new ICAL.Component(jcalData);

        //récupère les évènements et les ajoute dans un tableau
        const vevents = comp.getAllSubcomponents('vevent');
        let data = vevents.map(vevent => {
            const event = new ICAL.Event(vevent);
            //vérifie si l'évènement est dans la semaine à venir et sélectionne la salle, le résumé, la date de début et la date de fin
            if ((event.startDate.toJSDate() > new Date()) &&
                (event.startDate.toJSDate() < new Date(new Date().getTime() + 7 * 24 * 60 * 60 * 1000))) {
                return {
                    location: event.location,
                    summary: event.summary,
                    startDate: event.startDate.toString(),
                    endDate: event.endDate.toString(),
                    description: event.description
                };
            }
        });
        //filtre les évènements vides
        data = data.filter(event => event !== undefined)
        //trie les évènements par ordre chronologique
        data.sort((a, b) => {
            return new Date(a.startDate) - new Date(b.startDate);
        });
        //si un numéro de salle est passé en paramètre, filtre les évènements par salle
        if (req.query.location) data = data.filter(event => {
            return event.location.includes(req.query.location);
        });
        //si un cours est passé en paramètre, filtre les évènements par cours
        if (req.query.summary) data = data.filter(event => {
            return event.summary.toLowerCase().includes(req.query.summary.toLowerCase())
        });
        //renvoie les données
        res.json(data);
    } catch (error) {
        res.status(500).send(error.toString());
    }
}