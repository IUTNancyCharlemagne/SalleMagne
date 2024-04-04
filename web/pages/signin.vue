<script setup lang="ts">
import {ref} from 'vue';
import {API_LOGIN} from "~/utils/api_const";

const email = ref('');
const password = ref('');
const err = ref('');

const login = (event: Event) => {
  event.preventDefault();

  const credentials = btoa(`${email.value}:${password.value}`);

  $fetch(API_LOGIN, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Basic ${credentials}`
        }
      },
  ).then((data: any) => {
    const token = useCookie('token');
    token.value = data.token;
    navigateTo('/')
  }).catch((error) => {
    switch (error.status) {
      case 401:
        err.value = 'Erreur : mot de passe ou login incorrect';
        break;
      case 500:
        err.value = 'Erreur : impossible de se connecter';
        break;
      default:
        err.value = 'Erreur serveur';
        break;
    }
  });
}
</script>

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
      <p class="text-red-500 mt-4">{{ err }}</p>
    </div>
  </div>
</template>
