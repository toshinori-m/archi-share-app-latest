import Vue from 'vue'
import * as VueGoogleMaps from '~/node_modules/vue2-google-maps/src/main'

export default function({ $config }) {
  Vue.use(VueGoogleMaps, {
    load: {
      key: $config.API_KEY,
      libraries: 'places'
    }
  })
}
