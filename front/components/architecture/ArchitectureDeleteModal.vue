<template>
  <div>
    <v-btn icon color="error" @click="dialog = true">
      <v-icon>
        mdi-trash-can-outline
      </v-icon>
    </v-btn>
    <v-dialog
      v-model="dialog"
      persistent
      width="300"
    >
      <v-card>
        <v-card-title class="justify-center">
          <span class="primary--text">
            建築物削除の確認
          </span>
        </v-card-title>
        <v-card-text class="black--text text-center">
          <p class="primary--text">
            本当にこの建築物を削除してもよろしいですか？
          </p>
        </v-card-text>
        <v-card-actions>
          <v-btn
            block
            color="tertiary"
            @click="userArchitectureDelete"
          >
            はい
          </v-btn>
        </v-card-actions>
        <v-card-actions class="pb-4">
          <v-btn
            block
            color="grey lighten-2"
            @click="dialog = false"
          >
            いいえ
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
export default {
  data() {
    return {
      dialog: false
    }
  },
  computed: {
    ...mapGetters('architecture', [
      'architecture'
    ])
  },
  methods: {
    ...mapMutations('architecture', [
      'archiSet',
      'archiRemove'
    ]),
    async architectureDelete() {
      const response = await this.$axios
        .delete(`/api/v1/architectures/${this.architecture.id}`)
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userArchitectureDelete() {
      const res = await this.architectureDelete()
      if (!res) {
        return
      }
      this.archiSet(null)
      this.archiRemove(res.data)
      this.dialog = false
    }
  }
}
</script>