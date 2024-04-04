<template>
  <div>
    <h1>Favorites</h1>
  </div>
</template>

<script lang="ts" setup>
import authMiddleware from "~/middleware/auth";

definePageMeta({
  middleware: authMiddleware
})
</script>