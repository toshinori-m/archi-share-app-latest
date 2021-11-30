<template>
  <div>
    <v-menu left>
      <template #activator="{ on, attrs }">
        <v-btn
          icon
          large
          v-bind="attrs"
          v-on="on"
        >
          •••
        </v-btn>
      </template>
      <v-list class="py-0">
        <v-list-item>
          <v-list-item-icon>
            <v-icon>
              mdi-note-edit-outline
            </v-icon>
          </v-list-item-icon>
          <v-list-item-title>編集</v-list-item-title>
        </v-list-item>
        <v-list-item @click="closeDialog(true)">
          <v-list-item-icon>
            <v-icon color="red">
              mdi-trash-can-outline
            </v-icon>
          </v-list-item-icon>
          <v-list-item-content>
            <v-list-item-title class="red--text">
              削除
            </v-list-item-title>
          </v-list-item-content>
        </v-list-item>
      </v-list>
    </v-menu>
    <v-dialog
      v-model="deleteDialog"
      persistent
      width="300px"
      height="400px"
    >
      <post-delete-modal @close="closeDialog" />
    </v-dialog>
  </div>
</template>

<script>
import PostDeleteModal from '~/components/post/PostDeleteModal.vue'
export default {
  components: {
    PostDeleteModal
  },
  data() {
    return {
      deleteDialog: false
    }
  },
  methods: {
    closeDialog(bool) {
      this.deleteDialog = bool
    }
  }
}
</script>
