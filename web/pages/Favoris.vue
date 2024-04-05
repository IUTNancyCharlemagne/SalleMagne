<template>
  <div class="p-6 bg-gray-100 h-[8vh]">
    <div class="pb-7">
    <h1 class="text-4xl font-bold mb-4">Favoris</h1>
    <h2 class="text-2xl mb-6">Trouvez ici vos salles favorites :</h2>
    <button @click="selectAll"  class=" px-1 py-1 text-lg text-white bg-gray-700 rounded hover:bg-gray-600">
    Tout sélectionner
  </button>
    <button @click="deleteSelectedFavoris"
      class=" mx-1 px-1 py-1 text-lg text-white bg-red-700 rounded hover:bg-red-600">
      Supprimer
    </button>
    <p v-if="error !== ''" class="text-red-500 text-xl py-5">{{ error }}</p>
    <ul>
      <li v-for="favori in favoris" :key="favori.salle" class="mb-2">
        <input type="checkbox" :value="favori" v-model="selectedFavoris" class="mr-2">
        <NuxtLink :to="`/salle/${favori.salle}`"
          class="inline-block px-6 py-2 text-lg text-white bg-blue-700 rounded hover:bg-blue-600">
          Salle {{ favori.salle }}
        </NuxtLink>
      </li>
    </ul>
    </div>
  </div>
</template>
<script>
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
      error : '',
    };
  },
  created() {
    this.loadFavoris();
  },
  methods: {
    selectAll() {
  if (this.selectedFavoris.length === this.favoris.length) {
    this.selectedFavoris = [];
  } else {
    this.selectedFavoris = this.favoris.slice();
  }
},
    loadFavoris() {
      this.error = "";
      fetch(API_FAVORIS, {
        method: 'GET',
        headers: {
          'Authorization': `Bearer ${getTokenUser()}`,
        }
      })
          .then(response => {
            if (!response.ok) {
              this.error = 'Veuillez vous reconnecter';
            }
            return response.json();
          })
          .then(data => {
            this.favoris = data.data;
          })
          .catch(error => {
            this.error = 'Veuillez vous reconnecter';
            console.error('Erreur :', error);
          });
    },
    async deleteSelectedFavoris() {
      for (const favori of this.selectedFavoris) {
        try {
          await fetch(API_FAVORIS, {
            method: 'DELETE',
            headers: {
              'Authorization': `Bearer ${getTokenUser()}`,
              'Content-Type': 'application/json'
            },
            body: JSON.stringify({
              salle: favori.salle
            })
          });

          console.log('Favori supprimé :', favori);
        } catch (error) {
          console.error('Erreur lors de la suppression du favori :', error);
        }
      }
      this.selectedFavoris = [];
      this.loadFavoris();
    },
  },
};
</script>