<template>
  <div class="p-6 bg-gray-100 min-h-screen">
    <h1 class="text-4xl font-bold mb-4">Favoris</h1>
    <h2 class="text-2xl mb-6">Trouvez ici vos salles favorites :</h2>
    <ul>
      <li v-for="favori in favoris" :key="favori.salle" class="mb-2">
        <input type="checkbox" :value="favori" v-model="selectedFavoris">
        <NuxtLink :to="`/salle/${favori.salle}`"
          class="inline-block px-6 py-2 text-lg text-white bg-blue-700 rounded hover:bg-blue-600">
          Salle {{ favori.salle }}
        </NuxtLink>
      </li>
    </ul>
    <button @click="deleteSelectedFavoris"
      class="mt-4 px-6 py-2 text-lg text-white bg-red-700 rounded hover:bg-red-600">
      Supprimer les favoris sélectionnés
    </button>
  </div>
</template>
<script>
import axios from 'axios';
import { API_FAVORIS } from '~/utils/api_const';
import authMiddleware from "~/middleware/auth";
import { getTokenUser } from "~/utils/functions/tokenUser";

definePageMeta({
  middleware: authMiddleware
})

export default {
  data() {
    return {
      favoris: [],
      selectedFavoris: [],
    };
  },
  created() {
    this.loadFavoris();
  },
  methods: {
    loadFavoris() {
      const api = axios.create({
        baseURL: API_FAVORIS,
        headers: {
          'Authorization': `Bearer ` + getTokenUser(),
        }
      });

      api.get('/')
        .then(response => {
          this.favoris = response.data.data;
          console.log(this.favoris);
        })
        .catch(error => {
          console.error(error);
        });
    },
    async deleteSelectedFavoris() {
      const api = axios.create({
        baseURL: API_FAVORIS,
        headers: {
          'Authorization': `Bearer ` + getTokenUser(),
        }
      });

      for (const favori of this.selectedFavoris) {
        await api.delete('/', { data: { salle: favori.salle } }).catch(error => {
          console.error('Error deleting favori:', error.response);
        });
      }

      this.selectedFavoris = [];
      this.loadFavoris();
    },
  },
};
</script>