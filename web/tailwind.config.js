/** @type {import('tailwindcss').Config} */
export default {
    content: [
        "./components/**/*.{js,vue,ts}",
        "./layouts/**/*.vue",
        "./pages/**/*.vue",
        "./plugins/**/*.{js,ts}",
        "./app.vue",
        "./error.vue",
    ],
    theme: {
        extend: {},
    },
    plugins: [function ({addUtilities}) {
        const newUtilities = {
            '.number-input::-webkit-inner-spin-button': {
                '-webkit-appearance': 'none',
                'margin': '0',
            },
            '.number-input::-webkit-outer-spin-button': {
                '-webkit-appearance': 'none',
                'margin': '0',
            },
            '.number-input': {
                '-moz-appearance': 'textfield',
            },
        }
        addUtilities(newUtilities, ['responsive', 'hover'])
    }],
}

