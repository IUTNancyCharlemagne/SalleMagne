<template>
  <div class="min-h-screen flex items-center justify-center bg-gray-100">
    <div class="max-w-md w-full p-6 bg-white rounded-md shadow-md">
      <h1 class="text-3xl font-semibold mb-6">Page de connexion</h1>
      <form @submit.prevent="login" class="flex flex-col space-y-4">
        <label for="email" class="font-semibold">Email:</label>
        <input type="email" id="email" v-model="email" required
               class="border border-gray-300 px-3 py-2 rounded-md focus:outline-none focus:border-blue-500">
        <label for="password" class="font-semibold">Mot de passe:</label>
        <input type="password" id="password" v-model="password" required
               class="border border-gray-300 px-3 py-2 rounded-md focus:outline-none focus:border-blue-500">
        <button type="submit" class="bg-blue-500 text-white py-2 rounded-md hover:bg-blue-600 transition duration-300">
          Se connecter
        </button>
      </form>
      <p class="text-red-500 mt-4">{{ error }}</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import {ref} from 'vue';
import {API_LOGIN} from "~/utils/api_const";

const email = ref('');
const password = ref('');
const error = ref('');

const login = (event: Event) => {
  event.preventDefault();

  $fetch(API_LOGIN, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: {
      login: email.value,
      password: password.value,
    },
  }).then((data) => {
    switch (data.statusCode) {
      case 401:
        error.value = 'Erreur : mot de passe incorrect';
        break;
      case 404:
        error.value = 'Erreur : aucun utilisateur avec ce login';
        break;
      case 500:
        error.value = 'Erreur : impossible de se connecter';
        break;
      default:
        update({user: data.user});
        navigateTo('/log');
        break;
    }
  }).catch((error) => {
    console.error(error);
  });
}
</script>
