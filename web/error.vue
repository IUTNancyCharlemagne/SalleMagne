<script setup>
defineProps(['error']);

</script>

<template>
  <div class="flex flex-col items-center min-h-screen justify-center  bg-gray-100 p-4">
    <h1 class="text-4xl font-bold mb-4">Erreur {{ error.statusCode }}</h1>
    <p class="text-2xl mb-4">{{ error.message }}</p>
    <NuxtLink to="/" class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">Retour à l'accueil</NuxtLink>
  </div>
</template>

<style scoped>

</style>