import {createWorker} from 'tesseract.js';

export async function searchSalleByPicture(pictureLink) {
    const worker = await createWorker('fra');
    const ret = await worker.recognize(pictureLink);
    await worker.terminate();
    return ret.data.text;
}