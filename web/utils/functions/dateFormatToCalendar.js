//Passer un objet de type {date:"JJ/MM/AAAA", hour:"HH:MM"} en paramètre
export const dateFormatToCalendar = (objet) => {

    const dateArray = objet.date.split('/');
    const hourArray = objet.hour.split(':');

    const year = dateArray[2];
    const month = dateArray[0].padStart(2, '0');
    const day = dateArray[1].padStart(2, '0');

    const hour = hourArray[0].padStart(2, '0');
    const minute = hourArray[1].padStart(2, '0');

    return `${year}-${month}-${day}T${hour}:${minute}:00`;
}
