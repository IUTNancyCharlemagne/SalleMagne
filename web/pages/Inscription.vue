<script setup lang="ts">
import {ref} from 'vue';
import {API_REGISTER} from "~/utils/api_const";

const email = ref('');
const password = ref('');
const confirmPassword = ref('');
const nom = ref('');
const prenom = ref('');
const err = ref('');
const validate = ref(false);

const register = (event: Event) => {
  event.preventDefault();
  if (password.value !== confirmPassword.value) {
    err.value = 'Erreur : les mots de passe ne correspondent pas';
    return;
  }
  const credentials = btoa(`${email.value}:${password.value}`);
  $fetch(API_REGISTER, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Basic ${credentials}`
    },
    body: JSON.stringify({
      nom: nom.value,
      prenom: prenom.value,
    }),
  }).then((data: any) => {
    err.value = '';
    validate.value = true;

  }).catch((error) => {
    switch (error.status) {
      case 401:
        err.value = 'Erreur : email déjà utilisé';
        break;
      case 500:
        err.value = 'Erreur : impossible de s\'inscrire';
        break;
      default:
        err.value = 'Erreur serveur';
        break;
    }
  });
}
</script>


<template>
  <div class="h-[92vh] flex items-center justify-center bg-gray-100">
    <div class="max-w-md w-full p-6 bg-white rounded-md shadow-md">
      <h1 class="text-3xl font-semibold mb-6">Page d'Inscription</h1>
      <form @submit.prevent="register" class="flex flex-col space-y-4">
        <label for="email" class="font-semibold">Email:</label>
        <input type="email" id="email" v-model="email" required
               class="border border-gray-300 px-3 py-2 rounded-md focus:outline-none focus:border-blue-500">
        <label for="password" class="font-semibold">Mot de passe:</label>
        <input type="password" id="password" v-model="password" required
               class="border border-gray-300 px-3 py-2 rounded-md focus:outline-none focus:border-blue-500">
        <label for="confirmPassword" class="font-semibold">Confirmer le mot de passe:</label>
        <input type="password" id="confirmPassword" v-model="confirmPassword" required
               class="border border-gray-300 px-3 py-2 rounded-md focus:outline-none focus:border-blue-500">
        <label for="nom" class="font-semibold">Nom :</label>
        <input type="text" id="nom" v-model="nom" required
               class="border border-gray-300 px-3 py-2 rounded-md focus:outline-none focus:border-blue-500">
        <label for="prenom" class="font-semibold">Prénom :</label>
        <input type="text" id="prenom" v-model="prenom" required
               class="border border-gray-300 px-3 py-2 rounded-md focus:outline-none focus:border-blue-500">
        <button type="submit" class="bg-blue-700 text-white py-2 rounded-md hover:bg-blue-600 transition duration-300">
          S'inscrire
        </button>
      </form>
      <p class="text-red-500 mt-4">{{ err }}</p>
      <p v-if="validate" class="text-green-700 mt-4">Vous êtes inscrit, rendez-vous sur <NuxtLink :to="'/connexion'" class="font-bold hover:text-green-500 ">la page connexion</NuxtLink></p>

    </div>
  </div>
</template>