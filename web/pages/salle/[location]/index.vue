<script>
import {searchSalleByText} from "~/utils/functions/searchSalleByText.js";
import {VueSpinner} from 'vue3-spinners';

export default {
  components: {
    VueSpinner
  },
  data() {
    return {
      CoursPrevu: false,
      loading : true,
      error: false,
    };
  },
  methods: {
    async fetchEDT() {
      try {
      const location = this.$route.params.location;
      const response = await searchSalleByText(location)
        console.log(response)
      this.CoursPrevu = response.length > 0;
      } catch (error) {
        this.error = true;
        console.log(error)
      }
      this.loading = false;
    }


  },
  mounted() {
    this.fetchEDT();
  }

}


</script>

  <template>
    <h1>
      Emploi du temps de la salle {{ $route.params.location }}
    </h1>


    <div v-if="!CoursPrevu && !loading">
      Aucun cours n'est prévu dans cette salle pour le moment
      <NuxtLink to="/SearchSalle">
        Rechercher une autre salle
      </NuxtLink>
    </div>

    <div v-if="error && !loading">
      Une erreur est survenue lors de la recherche de la salle
      <NuxtLink to="/SearchSalle">
        Rechercher une autre salle
      </NuxtLink>
    </div>

    <div v-if="loading">
      <VueSpinner class="" size="100" color="Grey"/>
      <label>Chargement...</label>
    </div>


  </template>


