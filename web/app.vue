<template>
  <div>
    <nav class="bg-gray-800">
      <div class="max-w-7xl mx-auto px-2 sm:px-6 lg:px-8">
        <div class="relative flex items-center justify-between h-16">
          <div class="flex items-center px-2 lg:px-0">
            <NuxtLink to="/"
                      class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">
              Accueil
            </NuxtLink>
            <div v-if="token === '' || token === null">
              <NuxtLink to="/signin"
                        class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">
                Se connecter
              </NuxtLink>
              <NuxtLink to="/signup"
                        class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">
                S'inscrire
              </NuxtLink>
            </div>
            <div v-else class="flex items-center space-x-4">
              <NuxtLink to="/geoloc"
                        class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">
                Où est l'iut charlemagne ?
              </NuxtLink>
              <button @click="logoutAndRedirect"
                      class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">
                Déconnexion
              </button>
            </div>
          </div>
        </div>
      </div>
    </nav>
    <NuxtPage/>
  </div>
</template>

<script setup>
import {delTokenUser, getTokenUser} from "~/utils/functions/tokenUser";

const token = ref(getTokenUser());

const logoutAndRedirect = () => {
  delTokenUser();
};
</script>
