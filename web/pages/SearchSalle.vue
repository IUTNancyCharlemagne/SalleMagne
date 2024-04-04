<script>
import {searchSalleByPicture} from '../utils/functions/searchSalleByPicture.js';

export default {
  data() {
    return {
      numSalleInput: "",
      methodePhoto: false,
      isStreaming: false,
      imageUrl: null,
    };
  },
  methods: {
    async searchByText() {
      const num = parseInt(this.numSalleInput)
      if (isNaN(num)) {
        return
      }
      this.$router.push(`/salle/${num}`)
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
  <div>
    <input type="text" v-model="numSalleInput"  placeholder="numéro de salle ex : 328">
    <button @click="searchByText">Rechercher</button>
  </div>

  <div>
    <Button @click="startCamera">
      Utiliser l'appareil photo <br>
    </Button>
  </div>

  <div>
    <video ref="video" autoplay></video>
    <canvas ref="canvas" style="display: none;"></canvas>
    <Button @click="takePhoto" v-if="isStreaming" :disabled="!isStreaming">Prendre une photo</Button>
  </div>

</template>
