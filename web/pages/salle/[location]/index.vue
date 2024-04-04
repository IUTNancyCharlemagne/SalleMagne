<script>
import {searchSalleByText} from "~/utils/functions/searchSalleByText.js";
import {VueSpinner} from 'vue3-spinners';
import Calendar from "~/components/Calendar.vue";


export default {
  components: {
    Calendar,
    VueSpinner
  },
  data() {
    return {
      CoursPrevu: false,
      loading : true,
      error: false,
      Cours: [],
    };
  },
  methods: {
    async fetchEDT() {
      try {
      const location = this.$route.params.location;
      const response = await searchSalleByText(location)
        if(response===false)this.error= true;
      this.CoursPrevu = response.length > 0;
      this.Cours = response;
        console.log(response)
      } catch (error) {
        this.error = true;
        console.log(error)
      }
      this.loading = false;
    },

    async addToFav(){

    },

    async removeFromFav(){

    },


  },
  mounted() {
    this.fetchEDT();
  }

}


</script>

  <template>

    <div v-if="!loading && CoursPrevu && !error">
      <h1>
        Emploi du temps de la salle {{ $route.params.location }}
      </h1>
      <Calendar :event="Cours"/>
    </div>



    <div v-if="!CoursPrevu && !loading && !error">
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


