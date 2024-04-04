<template>
  <div class="flex p-4 ">
    <div class="w-1/2 p-4 bg-white rounded shadow">
      <h1 class="text-2xl font-bold mb-4 text-blue-600">Où est l'Iut Charlemagne ?</h1>
      <img src="../assets/logo_iut.png" alt="Iut Charlemagne" class="mb-4 h-16 w-16">
      <p class="mb-4 text-lg text-gray-700">Iut Charlemagne : 2Ter Bd Charlemagne, 54000 Nancy</p>
      <h2 class="text-xl font-bold mb-4 text-blue-600">Votre Position:</h2>
      <button class="mb-4 px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600" @click="getLocation">Obtenir</button>
      <div v-if="location" class="mb-4 text-lg">
        Latitude: <span class="font-bold">{{ location.latitude }}</span>
        Longitude: <span class="font-bold">{{ location.longitude }}</span>
      </div>
    </div>
    <div class="w-1/2 p-4 bg-white rounded shadow">
      <h2 class="text-xl font-bold mb-4 text-blue-600">Carte:</h2>
      <LMap
        ref="map"
        :zoom="zoom"
        :center="location ? [location.latitude, location.longitude] : [48.68301483239705, 6.16099446607644]"
        class="rounded shadow h-full w-full"
      >
        <LTileLayer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          attribution="&amp;copy; <a href=&quot;https://www.openstreetmap.org/&quot;>OpenStreetMap</a> contributors"
          layer-type="base"
          name="OpenStreetMap"
        />
        <l-marker v-if="location" :lat-lng="[location.latitude, location.longitude]"></l-marker>
        <l-marker :lat-lng="[48.68301483239705, 6.16099446607644]">
          <l-icon
            :icon-size="dynamicSize"
            :icon-anchor="dynamicAnchor">
            <img src="../assets/logo_iut.png" alt="Iut Charlemagne" class="mb-4 h-8 w-8  shadow">
          </l-icon>     
        </l-marker> <!-- Iut Charlemagne -->
      </LMap>
      <a :href="googleMapsUrl" target="_blank" class="block mt-4 text-blue-500 hover:text-blue-600">Ouvrir dans Google Maps</a>
    </div>
  </div>
</template>
  <script>

  import { ref } from 'vue';
  
  export default {
   
 
    setup() {
      const zoom = ref(10);
      return { zoom };
    },
    data() {
      return {
        location: null,
      };
    },
    computed: {
      googleMapsUrl() {
        if (this.location) {
          return `https://www.google.fr/maps/dir/${this.location.latitude},${this.location.longitude}/Institut+Universitaire+de+Technologie+Nancy-Charlemagne,+2Ter+Bd+Charlemagne,+54000+Nancy`;
        } else {
          return "https://www.google.fr/maps/dir/''/Institut+Universitaire+de+Technologie+Nancy-Charlemagne,+2Ter+Bd+Charlemagne,+54000+Nancy";
        }
      }
    },
    methods: {
      getLocation() {
        if (navigator.geolocation) {
          navigator.geolocation.getCurrentPosition((position) => {
            this.location = {
              latitude: position.coords.latitude,
              longitude: position.coords.longitude
            };
          }, (error) => {
            console.error(error);
          });
        } else {
          console.error('Acceptez la geo-localisation pour utiliser cette fonctionnalité');
        }
      }
    }
  };
  </script>