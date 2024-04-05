<template>
  <div v-if="loading" class="flex justify-center items-center h-[20vh] mt-[10vh]">
    <div class="flex flex-col items-center justify-center w-full sm:w-1/2 p-4 bg-white rounded-lg shadow mx-2">
      <VueSpinner class="mb-2" size="100" color="lightBlue"/>
      <label class="mb-4">Chargement...</label>
    </div>
  </div>
  <div v-if="!loading" class="p-6 bg-gray-100 min-h-screen">
    <h1 class="text-3xl font-bold mb-4">Cours recherché : {{ $route.params.cours }}</h1>
    <ul class="space-y-4">
      <li v-for="cour in cours" :key="cour.summary" class="p-4 bg-white rounded shadow">
        <NuxtLink :to="`/salle/${cour.location.split('_').pop()}`"
                  class="text-lg text-blue-700 hover:text-blue-900 transition-colors duration-200">
          {{ cour.summary }} {{ cour.location }}
        </NuxtLink>
      </li>
    </ul>
  </div>
</template>

<script>
import {searchCoursByText} from "~/utils/functions/searchCoursByText.js";
import {VueSpinner} from "vue3-spinners";

export default {
  components: {
    VueSpinner
  },
  data() {
    return {
      cours: [],
      loading: true,
    };
  },
  async created() {
    this.cours = await searchCoursByText(this.$route.params.cours);
    this.loading = false;
  },
};
</script>