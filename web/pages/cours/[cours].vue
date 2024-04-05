<template>
    <div class="p-6 bg-gray-100 min-h-screen">
      <h1 class="text-3xl font-bold mb-4">Cours recherché : {{ $route.params.cours }}</h1>
      <ul class="space-y-4">
        <li v-for="cour in cours" :key="cour.summary" class="p-4 bg-white rounded shadow">
          <NuxtLink :to="`/salle/${cour.salle}`"
            class="text-lg text-blue-700 hover:text-blue-900 transition-colors duration-200">
            {{ cour.summary }}
          </NuxtLink>
        </li>
      </ul>
    </div>
  </template>
  
  <script>
  import {searchCoursByText} from "~/utils/functions/searchCoursByText.js";
  
  export default {
    data() {
      return {
        cours: [],
      };
    },
    async created() {
      this.cours = await searchCoursByText(this.$route.params.cours);
    },
  };
  </script>