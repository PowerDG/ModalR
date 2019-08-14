<template>
  <div >plan table
    <div>
      <router-link tag="a" :to="{path:'/plan',query:{id:1}}">go to planDetail</router-link>
    </div>

  </div>
</template>

<script>
    export default {
        name: "PlanTable"
    }
</script>

<style scoped>

</style>
