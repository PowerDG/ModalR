<template>
  <div id="app">
    <a-locale-provider :locale="zh_CN">

      <a-layout id="components-layout-demo-basic">
      <a-layout-header> <research-header></research-header></a-layout-header>
      <a-layout-content :style="{backgroundImage:'url('+require('../static/images/home/background.png')+')'}">
        <navigation-bar ></navigation-bar>
        <div class="middle">
          <router-view v-if="isRouterAlive"></router-view>
          <!--<router-view/>-->
        </div>
        <research-footer></research-footer>
      </a-layout-content>
      <!--<a-layout-footer>Footer</a-layout-footer>-->
    </a-layout>
    </a-locale-provider>

  </div>
</template>

<script>

import ResearchFooter from "@/components/ResearchFooter";
import ResearchHeader from "@/components/ResearchHeader";
import NavigationBar from "@/components/NavigationBar";
import zh_CN from 'ant-design-vue/lib/locale-provider/zh_CN';
export default {
  name: 'App',
  components: {ResearchFooter, ResearchHeader, NavigationBar},
  provide () {
    return {
      reload: this.reload,
    }
  },
  data(){
    return {
      zh_CN,
      isRouterAlive: true
    }
  },
  methods: {
    reload () {
      this.isRouterAlive = false
      this.$nextTick(function () {
        this.isRouterAlive = true
      })
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#components-layout-demo-basic {
  text-align: center;
}
#components-layout-demo-basic .ant-layout-header,
#components-layout-demo-basic .ant-layout-footer {
  background: whitesmoke;
  height:40px;
  line-height:40px;
  /*color: #ffffff;*/
}
#components-layout-demo-basic .ant-layout-content {
  min-height: 700px;
}

.middle{
  min-height: 600px;
  max-width: 1280px;
  /*text-align: center;*/
  margin: 0 auto;
}
.float-right {
  float: right;
}
.float-left {
  float: left;
}
.bottom{
  background-color: darkcyan;
  float: bottom;
  padding-top: 5px;
  position: relative;
  height: 30px;
  width:auto;
  text-align: center;
}
</style>
