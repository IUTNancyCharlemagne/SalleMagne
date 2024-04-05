<script>
export default {
  data() {
    return {
      methodePhoto: false,
      isStreaming: false,
      imageUrl: null
    };
  },
  methods: {
    async takePhoto() {
      const video = this.$refs.video;
      const canvas = this.$refs.canvas;

      if (!this.isStreaming) return;

      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;
      canvas.getContext('2d').drawImage(video, 0, 0, canvas.width, canvas.height);

      this.imageUrl = canvas.toDataURL('image/jpeg');
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
  mounted() {
    this.startCamera();
  },
  beforeDestroy() {
    this.stopCamera();
  }
};
</script>


<template>


  <div>
    <button @click="takePhoto" :disabled="!isStreaming">Prendre une photo</button>
    <video ref="video" autoplay></video>
    <canvas ref="canvas" style="display: none;"></canvas>
    <div v-if="imageUrl">
      <img :src="imageUrl" alt="Photo">
    </div>
  </div>
</template>
