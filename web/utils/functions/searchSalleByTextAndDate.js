import {API_SALLE} from "~/utils/api_const.js";

export async function searchSalleByTextAndDate(numSalle, numWeek ) {
  try {
    return await $fetch(API_SALLE +"/"+numWeek + "?location=" + numSalle)
  } catch (error) {
    return false;
  }
}