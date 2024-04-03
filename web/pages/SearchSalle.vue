<script>
import {searchSalleByText} from "~/utils/functions/searchSalleByText.js";
import nuxtLink from "#app/components/nuxt-link.js";

export default {
  data() {
    return {
      numSalleInput : "",
    };
  },
  methods: {
    async searchByText() {
      const num = parseInt(this.numSalleInput)
      if(isNaN(num)) {
        return
      }
        const data =  await searchSalleByText(num);
        console.log(data);
        //redirection vers la page /salle/{idSalle}
        this.$router.push({
          name: "salleByLocation",
          params: {location : num},
          props: {infoSalle: data}
        });

    }
  }
}

</script>


<template>
  <div>
    <input type="text" v-model="numSalleInput" placeholder="numéro de salle ex : 328">
    <button @click="searchByText">Rechercher</button>
  </div>

  <NuxtLink to="/SearchWithPhoto">
    Prendre une photo
  </NuxtLink>

</template>
