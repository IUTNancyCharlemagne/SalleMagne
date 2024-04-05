import {API_SALLE} from "~/utils/api_const.js";

export async function searchCoursByText(cours) {
  try {
    return await $fetch(API_SALLE + "?summary=" + cours)
  } catch (error) {
    return false;
  }
}