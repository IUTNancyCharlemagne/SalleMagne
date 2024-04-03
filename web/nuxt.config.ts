// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  devtools: { enabled: true },
  css: ['~/assets/css/main.css'],
  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },
  // @ts-ignore
  router: [
    {
        path: '/salle/:location',
        component: '~/pages/salle/_location/index.vue',
        name: 'salleByLocation'

    }
  ]

})
