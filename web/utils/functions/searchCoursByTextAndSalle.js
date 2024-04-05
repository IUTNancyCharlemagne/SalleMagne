import {API_SALLE} from "~/utils/api_const.js";

export async function searchCoursByTextAndSalle(cours, salle) {
    try {
        return await $fetch(API_SALLE + "?summary=" + cours + "&location=" + salle)
    } catch (error) {
        return false;
    }
}