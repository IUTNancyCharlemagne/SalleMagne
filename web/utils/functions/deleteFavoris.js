import { API_FAVORIS } from "../api_const";

export async function deleteFavoris(salle) {
    try {
        return await $fetch(API_FAVORIS, {
            method: "DELETE",
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ salle })
        });
    } catch (error) {
        console.error('Error deleting favori:', error);
        return false;
    }
}