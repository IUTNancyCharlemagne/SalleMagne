<script>
import {searchSalleByText} from "~/utils/functions/searchSalleByText.js";
import {VueSpinner} from 'vue3-spinners';
import Calendar from "~/components/Calendar.vue";
import {getTokenUser} from "~/utils/functions/tokenUser.ts";
import {checkFavori} from "~/utils/functions/checkFavori.js";
import {addFavoris} from "~/utils/functions/addFavoris.js";
import {deleteFavoris} from "~/utils/functions/deleteFavoris.js";


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
      userConnected: false,
      salleFav: false,
      userLoad : false

    };
  },
  methods: {

    async initUserData(){
      this.userConnected = getTokenUser()!==null;
      if(this.userConnected) {
        this.salleFav = await checkFavori(this.$route.params.location)
      }
      this.userLoad = true;
    },



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
     const response =  await addFavoris(this.$route.params.location)
      if (response) {
        this.salleFav = true;
      }
    },

    async removeFromFav(){
      const response = await deleteFavoris(this.$route.params.location)
      if (response) {
        this.salleFav = false;
      }

    },


  },
  mounted() {
    this.fetchEDT();
    this.initUserData();
  }

}


</script>

  <template>

    <div v-if="!loading && CoursPrevu && !error">
      <h1>
        Emploi du temps de la salle {{ $route.params.location }}
      </h1>
      <div v-if="userLoad && userConnected">
        <div v-if="!salleFav">
        <button @click="addToFav">Ajouter aux favoris</button>
        </div>
        <div v-if="salleFav">
        <button @click="removeFromFav">Retirer des favoris</button>
          </div>
      </div>



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
      <VueSpinner class="" size="100" color="lightBlue"/>
      <label>Chargement...</label>
    </div>


  </template>


