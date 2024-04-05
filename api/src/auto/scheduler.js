import fs from 'fs';
import axios from 'axios';
import cron from 'node-cron';
import path from 'path';

const PUBLIC_FOLDER_PATH = path.join(new URL('./../../public/', import.meta.url).pathname);

function setFilePath(fileName){
    return path.join(PUBLIC_FOLDER_PATH, fileName);
}

async function downloadAndSaveFile(url, filePath) {
    const response = await axios.get(url, { responseType: 'stream' });
    const writer = fs.createWriteStream(filePath);
    response.data.pipe(writer);
    return new Promise((resolve, reject) => {
        writer.on('finish', resolve);
        writer.on('error', reject);
    });
}


function getFileUrl(debut, fin){
    console.log(debut)
    console.log(fin)
    return `https://adeical.univ-lorraine.fr/jsp/custom/modules/plannings/anonymous_cal.jsp?resources=131380,52562,16927,24214,17412,17387,17373,17362,17361,17360,17339,17338,32311,50398,17419,17418,17417,17416,17415,17414,85934,85933,17413,17410,17409,17408,17407,17400,17399,17398,17397,17396,17395,17394,17393,17392,17391,17390,17389,80990,17406,590,542,17404,17403,17402,17401,17359,17341,17386,17385,17384,17382,17381,17380,17379,17378,17377,17376,17375,17374,331416,17372,17371,17370,17369,17368,17367,17366,17365,17364,17363,65304,17358,17357,17356,17355,17354,17353,17350,17340,17337,17336,17333,80989,59249,186464,131379,50702,50699,50696,50693,50690,147060,52561,147062,97508,52563,401482,51517,131381,50701,50698,50695,50692,50380,50373,50368,50364,50339&projectId=11&calType=ical&firstDate=${debut.toISOString().split('T')[0]}&lastDate=${fin.toISOString().split('T')[0]}`;
}


export function startCron(){
    if (!fs.existsSync(PUBLIC_FOLDER_PATH)) {
        fs.mkdirSync(PUBLIC_FOLDER_PATH);
    }
    cron.schedule('* 3 * * *', async () => {
        try {
            await dlClassicWay();
            await dlAllYear();
            console.log('Téléchargement et sauvegarde des fichier terminés.');
        } catch (error) {
            console.error('Une erreur est survenue lors du téléchargement et de la sauvegarde du fichier :', error);
        }
    });
}

export async function dlAllYear(){
    const date = new Date();
    const annee =  date.getFullYear();
    const premierJanvier = new Date(annee, 0, 1);
    const jourDeLaSemaine = premierJanvier.getDay();

    if (jourDeLaSemaine !== 1) {
        premierJanvier.setDate(premierJanvier.getDate() + (1 - jourDeLaSemaine));
    }

    let it = 0;

    while (premierJanvier.getFullYear() === annee) {
        it += 1;
        let dateFin = new Date(premierJanvier);
        dateFin.setDate(dateFin.getDate() + 6);
        await downloadAndSaveFile(getFileUrl(premierJanvier, dateFin), setFilePath(it + '.ics'));
        console.log(`Téléchargement et sauvegarde du fichier ${it} terminés.`);
        premierJanvier.setDate(premierJanvier.getDate() + 7);


    }
}

export async function dlClassicWay(){
    const currentDate = new Date();
    currentDate.setDate(currentDate.getDate() - 15);

    const nextWeekDate = new Date();
    nextWeekDate.setDate(nextWeekDate.getDate() + 30);

    await downloadAndSaveFile(getFileUrl(currentDate, nextWeekDate), setFilePath('ADECAL.ics'))
}
