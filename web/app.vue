<template>
  <div class="flex flex-col justify-center items-center min-h-screen bg-stone-50">
    <div class="relative flex items-center justify-between h-16 shadow rounded p-4 w-full">
      <div class="flex space-x-6 items-center">
        <NuxtLink to="/"
          class="flex items-center space-x-4 text-blue-900 hover:text-blue-600 transition-colors duration-200">
          <img src="./assets/logo_iut.png" alt="Iut Charlemagne" class="h-14 w-14">
          <h1 class="text-2xl font-bold">Salle'Magne</h1>
        </NuxtLink>
        <NuxtLink to="/geoloc">
          <a href="#"
            class="bg-blue-900 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-700 transition-colors duration-200">Où
            est l'iut charlemagne ?</a>
        </NuxtLink>
        <NuxtLink to="/salles">
          <a href="#"
            class="bg-blue-900 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-700 transition-colors duration-200">
            Salles</a>
        </NuxtLink>
        <div class="relative">
          <input type="text" class="bg-white h-10 px-5 pr-10 rounded-full text-sm focus:outline-none"
            placeholder="Recherche...">
          <button type="submit" class="absolute right-0 top-0 mt-3 mr-4">
            <svg class="h-4 w-4 fill-current" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 56.966 56.966">
              <path
                d="M55.146,51.887L41.588,37.786c3.486-4.144,5.396-9.358,5.396-14.786c0-12.682-10.318-23-23-23s-23,10.318-23,23 s10.318,23,23,23c4.761,0,9.298-1.436,13.177-4.162l13.661,14.208c0.571,0.593,1.339,0.881,2.162,0.881s1.59-0.288,2.162-0.881 C56.231,54.786,56.293,53.08,55.146,51.887z M23.984,6c9.374,0,17,7.626,17,17s-7.626,17-17,17s-17-7.626-17-17S14.61,6,23.984,6z" />
            </svg>
          </button>
        </div>
      </div>
      <div class="flex space-x-6 items-center">
        <NuxtLink to="/Connexion">
          <a href="#"
            class="bg-blue-900 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-700 transition-colors duration-200">
            Connexion</a>
        </NuxtLink>
        <NuxtLink to="/Connexion">
          <a href="#"
            class="bg-blue-900 text-white px-3 py-2 rounded-md text-sm font-medium hover:bg-blue-700 transition-colors duration-200">
            Inscription</a>
        </NuxtLink>
        
      </div>
    </div>
    <NuxtPage />
  </div>
</template>