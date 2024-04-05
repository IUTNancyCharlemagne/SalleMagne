<script>
import {searchSalleByText} from "~/utils/functions/searchSalleByText.js";
import {VueSpinner} from 'vue3-spinners';
import Calendar from "~/components/Calendar.vue";
import {getTokenUser} from "~/utils/functions/tokenUser.ts";
import {checkFavori} from "~/utils/functions/checkFavori.js";
import {addFavoris} from "~/utils/functions/addFavoris.js";
import {deleteFavoris} from "~/utils/functions/deleteFavoris.js";
import {searchSalleByTextAndDate} from "~/utils/functions/searchSalleByTextAndDate.js";
import {createEventId} from "~/utils/createEventId.js";
import {dateFormatToCalendar} from "~/utils/functions/dateFormatToCalendar.js";
import calendar from "~/components/Calendar.vue";


export default {
  computed: {
    calendar() {
      return calendar
    }
  },
  components: {
    Calendar,
    VueSpinner
  },
  data() {
    return {
      CoursPrevu: false,
      loading: true,
      error: false,
      Cours: [],
      userConnected: false,
      salleFav: false,
      userLoad: false,
      calendarOptions: {event: []},

    };
  },
  methods: {

    getMonday(actualMonday){
      const januaryFirst = new Date(actualMonday.getFullYear(), 0, 1);
      const diff = actualMonday.getTime() - januaryFirst.getTime();
      let res = Math.ceil((diff / (1000 * 60 * 60 * 24) + januaryFirst.getDay() + 1) / 7);
      if (januaryFirst.getDay() !== 1) {
        res = res + 1
      }
      return res
    },

    async handleChangeView(info) {
      const calendarApi = info.view.calendar
      calendarApi.removeAllEvents()
      const monday = this.getMonday(info.start)

      const response = await searchSalleByTextAndDate(this.$route.params.location, monday)
      if (response === false) this.error = true;
      this.calendarOptions.event = []
      response.forEach((cours) => {
        calendarApi.addEvent({
        id: createEventId(),
        title: cours.summary,
        start: dateFormatToCalendar(cours.startDate),
        end: dateFormatToCalendar(cours.endDate),
      })
      })

    },

    async initUserData() {
      this.userConnected = getTokenUser() !== null;
      if (this.userConnected) {
        this.salleFav = await checkFavori(this.$route.params.location)
      }
      this.userLoad = true;
    },


    async fetchEDT() {
      try {
        const location = this.$route.params.location;
        const response = await searchSalleByText(location)
        if (response === false) this.error = true;
        this.CoursPrevu = response.length > 0;
        this.Cours = response;
      } catch (error) {
        this.error = true;
      }
      this.loading = false;
    },

    async addToFav() {
      const response = await addFavoris(this.$route.params.location)
      if (response) {
        this.salleFav = true;
      }
    },

    async removeFromFav() {
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

  <div v-if="!loading && CoursPrevu && !error" class="text-center mt-4">
    <div class="flex items-center justify-center gap-2">
      <h1 class="text-3xl font-bold mb-4">
        Emploi du temps de la salle {{ $route.params.location }}
      </h1>
      <div v-if="userLoad && userConnected" class="mb-4">
        <div v-if="!salleFav">
          <button @click="addToFav" class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
            Ajouter aux favoris
          </button>
        </div>
        <div v-if="salleFav">
          <button @click="removeFromFav" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
            Retirer des favoris
          </button>
        </div>
      </div>
    </div>
    <Calendar :event="Cours" :options="calendarOptions" @handleChangeView="handleChangeView"/>
  </div>


  <!-- Div pour l'affichage lorsqu'aucun cours n'est prévu -->
  <div class="flex justify-center items-center h-[20vh]">
    <div v-if="!CoursPrevu && !loading && !error" class="w-full sm:w-1/2 p-4 bg-white rounded-lg shadow mx-2 ">
      <p class="text-lg text-gray-700 mb-4">Aucun cours n'est prévu dans cette salle pour le moment</p>
      <NuxtLink to="/searchSalle"
                class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">
        Rechercher une autre salle
      </NuxtLink>
    </div>
  </div>


  <!-- Div pour l'affichage en cas d'erreur -->
  <div class="flex justify-center items-center h-[20vh]">
    <div v-if="error && !loading" class="w-full sm:w-1/2 p-4 bg-white rounded-lg shadow mx-2">
      <p class="text-lg text-gray-700 mb-4">Une erreur est survenue lors de la recherche de la salle</p>
      <NuxtLink to="/searchSalle"
                class="bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200">
        Rechercher une autre salle
      </NuxtLink>
    </div>
  </div>


  <!-- Div pour l'affichage pendant le chargement -->
  <div class="flex justify-center items-center h-[20vh]">
    <div v-if="loading"
         class="flex flex-col items-center justify-center w-full sm:w-1/2 p-4 bg-white rounded-lg shadow mx-2">
      <VueSpinner class="mb-2" size="100" color="lightBlue"/>
      <label class="mb-4">Chargement...</label>
    </div>
  </div>


</template>


