import {getTokenUser} from "~/utils/functions/tokenUser.ts";

export const checkFavori = async (id) => {
    try {
        const res = await fetch(`https://docketu.iutnc.univ-lorraine.fr:32499/api/favoris`, {
            method: 'GET',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${getTokenUser()}`
            }
        });

        if (res.ok) {
            const data = await res.json();
            return data.data.some(item => item.salle === parseInt(id));
        } else {
            return false;
        }
    } catch (e) {
        return false;
    }
}
