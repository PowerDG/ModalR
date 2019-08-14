<template>
    <div class="navigationtitle" :style="backgroundstyle">

    </div>
</template>

<script>
    export default {
        name: "NavigationTitle",
      data () {
        return {
          img: Img,
          backgroundstyle:{
            backgroundImage: 'url(' + require('../../static/images/home/Navigation/normal.png') + ')'
          }
        }
      }
    }
</script>

<style scoped>
.navigationtitle{

}
  .normal{
    background-image: /static/images/home/Navigation/默认.png;
  }



</style>
