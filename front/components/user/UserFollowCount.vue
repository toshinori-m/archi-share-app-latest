<template>
  <div class="d-flex">
    <v-btn large text>
      フォロー<br />
      {{ followings.length }}
    </v-btn>
    <v-btn large text>
      フォロワー<br />
      {{ followers.length }}
    </v-btn>
  </div>
</template>

<script>
export default {
  props: {
    followings: {
      type: Array,
      required: true
    },
    followers: {
      type: Array,
      required: true
    }
  }
}
</script>
