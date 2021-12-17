import Vue from 'vue'
import Geocoder from '@pderas/vue2-geocoder'

export default ({ $config }) => {
  Vue.use(Geocoder, {
    defaultCountryCode: null,
    defaultLanguage: null,
    defaultMode: 'address',
    googleMapsApiKey: $config.API_KEY
  })
}
