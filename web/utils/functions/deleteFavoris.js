import {API_FAVORIS} from "../api_const";
import {getTokenUser} from "~/utils/functions/tokenUser.ts";

export async function deleteFavoris(salle) {
  try {
    return await $fetch(API_FAVORIS, {
      method: "DELETE",
      headers: {
        'Content-Type': 'application/json',
        authorization: 'Bearer ' + getTokenUser()

      },
      body: JSON.stringify({salle})
    });
  } catch (error) {
    console.error('Error deleting favori:', error);
    return false;
  }
}