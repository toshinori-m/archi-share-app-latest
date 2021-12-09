<template>
  <span>{{ time }}</span>
</template>

<script>
import dayjs from 'dayjs'
export default {
  props: {
    comment: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      time: ''
    }
  },
  mounted() {
    this.time = dayjs(this.comment.created_at).fromNow()
  }
}
</script>
