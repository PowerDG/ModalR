<template>
  <div class="logout">
    <div >
      <img style="margin-top: 30px" src="../../../static/images/home/no_auth.png" height="123" width="217"/>
    </div>
    <div style="margin: 10px" >
      <span >没有权限查看当前页</span>
    </div>
  </div>
</template>

<script>
  import Bus from "@/plugins/Bus";
  export default {
    name: "NoPermissionPage",
    data(){
      return {
        backgroundStyle: { backgroundImage: 'url(' + require('../../../static/images/home/login/normal.png') + ')'},
      }
    },
    methods:{
      handleLogin(){
        console.log('handleLogin');
        Bus.$emit('login','logoutPage')
      },
      mouseEnter()
      {
        this.backgroundStyle= { backgroundImage: 'url(' + require('../../../static/images/home/login/selected.png') + ')'};
      },
      mouseLeave(){
        this.backgroundStyle= { backgroundImage: 'url(' + require('../../../static/images/home/login/normal.png') + ')'};
      },
      mouseDown(){
        this.backgroundStyle= { backgroundImage: 'url(' + require('../../../static/images/home/login/click.png') + ')'};
      }
    }
  }
</script>

<style scoped>
  .logout{
    margin-top: 100px;
    width: 440px;
    height: 280px;
    background-color: whitesmoke;
    border: 1px solid ;
    border-radius:5px;
    border-color: burlywood ;
    display: flex;
    justify-content: center;
    align-items: center;
    flex-direction: column;
  }
  .button{
    border: 0px;
    margin: 10px;
    height: 42px;
    width: 210px;
    cursor: pointer;
  }
</style>
