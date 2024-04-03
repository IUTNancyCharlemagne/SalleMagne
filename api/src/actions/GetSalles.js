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

            //Récupère la date actuelle et la date de début de l'évènement au format AAAA-MM-JJ
            const currentDate = new Date(new Date().getFullYear(), new Date().getMonth(), new Date().getDate());
            let startDate = event.startDate.toJSDate();
            startDate = new Date(startDate.getFullYear(), startDate.getMonth(), startDate.getDate());

            //vérifie si l'évènement est dans la semaine à venir et sélectionne la salle, le résumé, la date de début et la date de fin
            if ((startDate >= currentDate) &&
                (event.startDate.toJSDate() < new Date(new Date().getTime() + 7 * 24 * 60 * 60 * 1000))) {
                const startDay = event.startDate.toJSDate().getDate();
                const startMonth = event.startDate.toJSDate().getMonth() + 1;
                const endDay = event.endDate.toJSDate().getDate();
                const endMonth = event.endDate.toJSDate().getMonth() + 1;
                const endYear = event.endDate.toJSDate().getFullYear();
                const startYear = event.startDate.toJSDate().getFullYear();
                return {
                    location: event.location,
                    summary: event.summary,
                    startDate: {
                        fullDate: event.startDate.toJSDate(),
                        date: (startDay > 9 ? startDay : ("0") + startDay) + "/"
                            + (startMonth > 9 ? startMonth : ("0") + startMonth) + "/"
                            + startYear,
                        hour: event.startDate.toJSDate().getHours() + 2 + ":" + event.startDate.toJSDate().getMinutes() + "0",
                    },
                    endDate: {
                        fullDate: event.endDate.toJSDate(),
                        date: (endDay > 9 ? endDay : ("0") + endDay) + "/"
                            + (endMonth > 9 ? endMonth : ("0") + endMonth) + "/"
                            + endYear,
                        hour: event.endDate.toJSDate().getHours() + 2 + ":" + event.endDate.toJSDate().getMinutes() + "0",
                    },
                    description: event.description
                };
            }
        });
        //filtre les évènements vides
        data = data.filter(event => event !== undefined)
        //si un numéro de salle est passé en paramètre, filtre les évènements par salle
        if (req.query.location) data = data.filter(event => {
            return event.location.includes(req.query.location);
        });
        //si un cours est passé en paramètre, filtre les évènements par cours
        if (req.query.summary) data = data.filter(event => {
            return event.summary.toLowerCase().includes(req.query.summary.toLowerCase())
        });
        //trie les évènements par ordre chronologique
        data.sort((a, b) => {
            return new Date(a.startDate.fullDate) - new Date(b.startDate.fullDate);
        });
        //renvoie les données
        res.json(data);
    } catch (error) {
        res.status(500).send(error.toString());
    }
}