import icsToJson from "ics-to-json-extended";

const convert = async (fileLocation) => {
  const icsRes = await fetch(fileLocation);
  const icsData = await icsRes.text();
  const data = icsToJson(icsData);
  return data;
};

window.onload = () => {
  convert('./ADECal.ics')
    .then(data => {
      const resultElement = document.getElementById('result');
      resultElement.textContent = JSON.stringify(data, null, 2);
      console.log(data);
    })
    .catch(error => console.error(error));
};