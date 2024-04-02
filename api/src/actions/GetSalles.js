import fs from 'fs';
import util from 'util';
import ICAL from 'ical.js';

const readFile = util.promisify(fs.readFile);

export async function GetSalles(req, res) {
  try {
    const icsData = await readFile('./public/ADECAL.ics', 'utf8');
    const jcalData = ICAL.parse(icsData);
    const comp = new ICAL.Component(jcalData);
    const vevents = comp.getAllSubcomponents('vevent');
    const data = vevents.map(vevent => {
      const event = new ICAL.Event(vevent);
      return {
        location: event.location,
        summary: event.summary,
        startDate: event.startDate.toString(),
        endDate: event.endDate.toString(),
        description: event.description
      };
    });
    res.json(data);
  } catch (error) {
    res.status(500).send(error.toString());
  }
}