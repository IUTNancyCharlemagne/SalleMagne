export const getHeureFormatee = (dateHeureStr) => {
  try {
    // Découper la chaîne en parties date et heure
    const [date, heure] = dateHeureStr.split('T');

    // Extraire l'heure et les minutes
    const [heures, minutes] = heure.split(':');

    // Formater l'heure avec deux chiffres
    const heureFormatee = heures.padStart(2, '0') + 'h' + minutes.padStart(2, '0');

    // Retourner l'heure formatée
    return heureFormatee;
  }
  catch (e) {
    return  ""
  }
}

