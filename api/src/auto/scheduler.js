import fs from 'fs';
import axios from 'axios';
import cron from 'node-cron';
import {existsSync, openSync} from "fs";
import path from 'path';

// Fonction pour télécharger et sauvegarder le fichier localement
async function downloadAndSaveFile(url, filePath) {
    const response = await axios.get(url, { responseType: 'stream' });
    const writer = fs.createWriteStream(filePath);
    response.data.pipe(writer);
    return new Promise((resolve, reject) => {
        writer.on('finish', resolve);
        writer.on('error', reject);
    });
}

// Obtenir la date actuelle
const currentDate = new Date();

// Obtenir la date dans 7 jours
const nextWeekDate = new Date();
nextWeekDate.setDate(nextWeekDate.getDate() + 7);

// Formater les dates au format YYYY-MM-DD
const formattedCurrentDate = currentDate.toISOString().split('T')[0];
const formattedNextWeekDate = nextWeekDate.toISOString().split('T')[0];


// Définir l'URL du fichier à télécharger
const fileUrl = `https://adeical.univ-lorraine.fr/jsp/custom/modules/plannings/anonymous_cal.jsp?resources=131380,52562,16927,24214,17412,17387,17373,17362,17361,17360,17339,17338,32311,50398,17419,17418,17417,17416,17415,17414,85934,85933,17413,17410,17409,17408,17407,17400,17399,17398,17397,17396,17395,17394,17393,17392,17391,17390,17389,80990,17406,590,542,17404,17403,17402,17401,17359,17341,17386,17385,17384,17382,17381,17380,17379,17378,17377,17376,17375,17374,331416,17372,17371,17370,17369,17368,17367,17366,17365,17364,17363,65304,17358,17357,17356,17355,17354,17353,17350,17340,17337,17336,17333,80989,59249,186464,131379,50702,50699,50696,50693,50690,147060,52561,147062,97508,52563,401482,51517,131381,50701,50698,50695,50692,50380,50373,50368,50364,50339&projectId=11&calType=ical&firstDate=${formattedCurrentDate}&lastDate=${formattedNextWeekDate}`;
// Définir le chemin absolu du répertoire public où le fichier sera sauvegardé
const publicFolderPath = path.join(new URL('./../../public/', import.meta.url).pathname);
// Assurez-vous que le répertoire public existe
if (!fs.existsSync(publicFolderPath)) {
    fs.mkdirSync(publicFolderPath);
}

const filePath = path.join(publicFolderPath, 'file.ics');

// Planifier l'exécution de la fonction toutes les 12 heures (à midi et minuit)
export function startCron(){
    cron.schedule('0 */12 * * *', async () => {
        try {
            if (!existsSync(filePath)) {
                openSync(filePath, "w");
            }
            await downloadAndSaveFile(fileUrl, filePath);
            console.log('Téléchargement et sauvegarde du fichier terminés.');
        } catch (error) {
            console.error('Une erreur est survenue lors du téléchargement et de la sauvegarde du fichier :', error);
        }
    });
}
