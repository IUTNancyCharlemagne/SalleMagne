<script>
import {searchSalleByPicture} from '../utils/functions/searchSalleByPicture.js';

export default {
  data() {
    return {
      numSalleInput: "",
      coursInput: "",
      isStreaming: false,
      imageUrl: null,
    };
  },
  methods: {
    async searchSalleByText() {
      const num = parseInt(this.numSalleInput)
      if (isNaN(num)) {
        return
      }
      this.$router.push(`/salle/${num}`)
    },
    async searchCoursByText() {
      const cours = this.coursInput
      this.$router.push(`/cours/${cours}`)
    },
    async takePhoto() {
      const video = this.$refs.video;
      const canvas = this.$refs.canvas;

      if (!this.isStreaming) return;

      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;
      canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);

      this.imageUrl = canvas.toDataURL('image/jpeg');
      searchSalleByPicture(this.imageUrl).then((numSalle) => {
        this.$router.push(`/salle/${numSalle}`)
      });
    },
    async startCamera() {
      try {
        const stream = await navigator.mediaDevices.getUserMedia({video: true});
        const video = this.$refs.video;
        video.srcObject = stream;
        video.play();
        this.isStreaming = true;
      } catch (error) {
        console.error('Error accessing camera:', error);
      }
    },
    stopCamera() {
      const video = this.$refs.video;
      const stream = video.srcObject;
      const tracks = stream.getTracks();
      tracks.forEach(track => track.stop());
      video.srcObject = null;
      this.isStreaming = false;
    },

  },
  beforeDestroy() {
    this.stopCamera();
  }
}

</script>


<template>
  <div class="flex p-4">

    <div class="w-1/2 mr-5 p-4 bg-white rounded shadow">
      <div>
        <h1 class="text-2xl font-bold mb-4 text-blue-800">Rechercher une salle par numéro</h1>
        <input class="shadow border-2 number-input" type="number" v-model="numSalleInput" placeholder="Exemple: 505">
        <button
            class="ml-4 bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200"
            @click="searchSalleByText">Rechercher
        </button>
      </div>
      <div>
        <h1 class="mt-4 text-2xl font-bold mb-4 text-blue-800">Rechercher un cours par matière</h1>
        <input class="shadow border-2" type="text" v-model="coursInput" placeholder="Exemple: anglais">
        <button
            class="ml-4 bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200"
            @click="searchSalleByText">Rechercher
        </button>
      </div>


    </div>

    <div class="w-1/2 ml-5 p-4 bg-white rounded shadow">
      <h1 class="text-2xl font-bold mb-4 text-blue-800">Rechercher une salle par photo </h1>
      <p class="italic">Prenez en photo un numéro de salle, de manière claire et sans autre forme de texte visible sur
        la photo</p>
      <div class="flex items-center justify-center">
        <Button
            class="ml-4 bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200"
            v-if="!isStreaming" @click="startCamera">
          Cliquer ici pour autoriser l'utilisation de votre caméra <br>
        </Button>
      </div>

      <video ref="video" autoplay></video>
      <canvas ref="canvas" style="display: none;"></canvas>
      <div class="flex items-center justify-center">
        <Button
            class="m-4 bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200"
            @click="takePhoto" v-if="isStreaming" :disabled="!isStreaming">Prendre une photo
        </Button>
      </div>
    </div>
  </div>

</template>
