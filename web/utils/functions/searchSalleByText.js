import {API_SALLE} from "~/utils/api_const.js";

export async function searchSalleByText(numSalle) {
  try {
    return await $fetch(API_SALLE + "?location=" + numSalle)
  } catch (error) {
    return false;
  }
}