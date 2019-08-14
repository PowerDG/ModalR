<template>
  <div >Task table
    <div>   <router-link tag="a" :to="{path:'/task',query:{id:1}}">go to taskDetail</router-link></div>
  </div>
</template>

<script>
    export default {
        name: "TaskTable"
    }
</script>

<style scoped>

</style>
