<template>
  <div v-if="currentUser.id == post.user.id">
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
        <v-list-item @click="editDialog = true">
          <v-list-item-icon>
            <v-icon>
              mdi-note-edit-outline
            </v-icon>
          </v-list-item-icon>
          <v-list-item-title>編集</v-list-item-title>
        </v-list-item>
        <v-list-item @click="deleteDialog = true">
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
      v-if="editDialog == true"
      v-model="editDialog"
      persistent
      width="500px"
    >
      <post-edit-modal @close="closeEditDialog" />
    </v-dialog>
    <v-dialog
      v-model="deleteDialog"
      persistent
      width="300px"
      height="400px"
    >
      <post-delete-modal @close="closeDeleteDialog" />
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import PostEditModal from '~/components/post/PostEditModal.vue'
import PostDeleteModal from '~/components/post/PostDeleteModal.vue'
export default {
  components: {
    PostEditModal,
    PostDeleteModal
  },
  data() {
    return {
      editDialog: false,
      deleteDialog: false
    }
  },
  computed: {
    ...mapGetters({
      post: 'post/post',
      currentUser: 'authentication/currentUser'
    })
  },
  methods: {
    closeEditDialog(bool) {
      this.editDialog = bool
    },
    closeDeleteDialog(bool) {
      this.deleteDialog = bool
    }
  }
}
</script>
