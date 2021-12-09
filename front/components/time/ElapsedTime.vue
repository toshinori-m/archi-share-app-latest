<template>
  <span>{{ time }}</span>
</template>

<script>
import dayjs from 'dayjs'
export default {
  props: {
    content: {
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
    this.time = dayjs(this.content.created_at).fromNow()
  }
}
</script>
