<template>
  <div>
    首页
    <div>
      <router-link tag="a" :to="{path:'/member',query:{id:1}}">go to member </router-link>
    </div>

  </div>
</template>
<script>

  export default {
    data () {
      return {

      }
    },
    methods: {

    },
  }
</script>
