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
    //Redirige la recherche de l'utilisateur en fonction des champs qu'il a rempli
    async research() {
      if (this.numSalleInput !== "" && this.coursInput === "") {
        if (isNaN(this.numSalleInput)) {
          return
        }
        const num = this.numSalleInput
        this.numSalleInput = ""
        this.$router.push(`/salle/${num}`)
      } else if (this.numSalleInput === "" && this.coursInput !== "") {
        const cours = this.coursInput
        this.coursInput = ""
        this.$router.push(`/cours/${cours}`)
      } else if (this.numSalleInput !== "" && this.coursInput !== "") {
        if (isNaN(this.numSalleInput)) {
          return
        }
        const num = this.numSalleInput
        this.numSalleInput = ""
        const cours = this.coursInput
        this.coursInput = ""
        this.$router.push(`/cours/${cours}/salles/${num}`)
      }
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
  },
  mounted() {
    document.addEventListener('keydown', (e) => {
      if (e.key === 'Enter') {
        this.research();
      }
    })
  },
}

</script>


<template>
  <div class="flex p-4">

    <div class="w-1/2 mr-5 p-4 bg-white rounded shadow">
      <h1 class="text-2xl font-bold mb-4 text-blue-800">Recherchez ici une salle ou un cours en fonction du numéro de la salle ou du nom du cours</h1>
      <div>
        <h2 class="text-xl font-bold mb-4 text-blue-800" >Numéro de salle</h2>
        <input class="shadow border-2 number-input" type="number" v-model="numSalleInput" placeholder="Exemple: 505">
      </div>
      <div>
        <h2 class="mt-4 text-xl font-bold mb-4 text-blue-800">Nom de cours</h2>
        <input class="shadow border-2" type="text" v-model="coursInput" placeholder="Exemple: anglais">
      </div>
      <div>
        <button
            :disabled="numSalleInput==null || coursInput==null"
            class="m-4 bg-blue-700 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-600 transition-colors duration-200"
            @click="research">Rechercher
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
