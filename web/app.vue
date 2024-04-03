<template>
  <div>
    <nav class="bg-gray-800">
      <div class="max-w-7xl mx-auto px-2 sm:px-6 lg:px-8">
        <div class="relative flex items-center justify-between h-16">
          <div class="flex items-center px-2 lg:px-0">
          
            <div class="hidden lg:block lg:ml-6">
              <div class="flex space-x-4">
                <a href="#" class="bg-gray-900 text-white px-3 py-2 rounded-md text-sm font-medium">Home</a>
                <a href="#" class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">About</a>
                <NuxtLink to="/geoloc">
                  <a href="#" class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium">Où est l'iut charlemagne ?</a>
                </NuxtLink>
                
              </div>
            </div>
          </div>
        </div>
      </div>
    </nav>
    <NuxtPage />
  </div>
</template>