<template>
  <div>
    <nav class="bg-white h-[8vh] shadow flex ">
      <div class="max-w-7xl mx-auto px-2 sm:px-6 lg:px-8">
        <div class="relative flex items-center justify-between h-16">
          <div class="flex items-center space-x-4 px-2 lg:px-0">
            <NuxtLink to="/"
              class="flex items-center space-x-4 text-blue-900 hover:text-blue-600 transition-colors duration-200 px-2">
              <img src="./assets/logo_iut.png" alt="Iut Charlemagne" class="h-8 w-8 mr-2">
              <h1>Salle'Magne</h1>
            </NuxtLink>
            <NuxtLink to="/recherche"
                      class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">
              Rechercher une salle ou un cours
            </NuxtLink>
            <NuxtLink to="/geolocalisation"
              class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">
              Où est l'iut charlemagne ?
            </NuxtLink>
            <div v-if="token === '' || token === null">
              <div class="flex items-end space-x-4">
                <NuxtLink to="/connexion"
                  class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">
                  Se connecter
                </NuxtLink>
                <NuxtLink to="/inscription"
                  class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">
                  S'inscrire
                </NuxtLink>
              </div>
            </div>
            <div v-else class="flex items-center space-x-4">
              <NuxtLink to="/Favoris"
                class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">
                Mes Favoris
              </NuxtLink>
              <button @click="logoutAndRedirect"
                class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">
                Déconnexion
              </button>
            </div>
          </div>
        </div>
      </div>
    </nav>
    <div class="h-[92vh]">
    <NuxtPage/>
    </div>
  </div>
</template>

<script setup>
import { delTokenUser, getTokenUser } from "~/utils/functions/tokenUser";

const token = getTokenUser();
const logoutAndRedirect = () => {
  delTokenUser();
  reloadNuxtApp();
};
  useHead({
    title: 'Salle\'Magne',
  });

</script>
