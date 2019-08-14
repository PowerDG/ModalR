<template>
  <div class="research-footer" >
    <div style="">
      Copyright © 2017- {{currentYear}} 梵讯研究院版权所有
    </div>
  </div>
</template>

<script>
    export default {
        name: "ResearchFooter",
        data(){
           return {
             currentYear:  new Date().getFullYear()
           }
        }
    }
</script>

<style scoped>
.research-footer{
  height:30px;
  text-align:center;
  font-size:14px;
  padding-top:5px;
}
</style>
