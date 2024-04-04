<script>

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
      this.$router.push(`/salle/${num}`)
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
