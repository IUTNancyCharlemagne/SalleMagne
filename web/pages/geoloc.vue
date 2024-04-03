<template>
    <div>
      <button @click="getLocation">Get Location</button>
      <div v-if="location">
        Latitude: {{ location.latitude }}
        Longitude: {{ location.longitude }}
      </div>
      
    </div>
  </template>
  
  <script>
  export default {
    data() {
      return {
        location: null
      };
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