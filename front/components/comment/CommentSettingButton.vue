<template>
  <div v-if="currentUser.id == comment.user.id">
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
      v-model="deleteDialog"
      persistent
      width="300px"
      height="400px"
    >
      <comment-delete-modal :comment="comment" @close="closeDeleteDialog" />
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import CommentDeleteModal from '~/components/comment/CommentDeleteModal.vue'
export default {
  components: {
    CommentDeleteModal
  },
  props: {
    comment: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      deleteDialog: false
    }
  },
  computed: {
    ...mapGetters('authentication', [
      'currentUser'
    ])
  },
  methods: {
    closeDeleteDialog() {
      this.deleteDialog = false
    }
  }
}
</script>
