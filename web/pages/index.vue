<template>
  <div class="flex flex-col items-center  h-[92vh] justify-center  bg-gray-100 p-4">
    <h1 class="text-4xl font-bold mb-4">Bienvenue sur Salle'Magne</h1>
    <div class="flex flex-col items-center justify-center mb-4">
      <input type="text" v-model="salle" placeholder="Entrez le numéro de salle" class="mb-2 px-4 py-2 border rounded w-full">
      <div class="flex items-center space-x-4">
        <nuxt-link  :to="salle !== '' ? `/salle/${salle}` : null" class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">Rechercher</nuxt-link>
        <nuxt-link to="/recherche" class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">Prenez une photo de la plaque de la salle</nuxt-link>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      salle: '',
    };
  },
};
</script>