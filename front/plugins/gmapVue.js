import Vue from 'vue'
import GmapVue from '~/node_modules/gmap-vue'

export default function({ $config }) {
  Vue.use(GmapVue, {
      load: {
          key: $config.API_KEY,
          libraries: 'places'
      },
      installComponents: true
  })
}
