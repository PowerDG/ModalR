// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import store from './store'
import Antd from 'ant-design-vue'
import 'ant-design-vue/dist/antd.css'
import permissionConfig from './config/permissionConfig'
import webConfig from './config/webConfig'
// import "@/plugins/axios";

import Axios from 'axios'
import * as filters from './fiters/common'

import VueAMap from 'vue-amap';
Vue.use(VueAMap);
VueAMap.initAMapApiLoader({
    key:"36aadd39b435e4309ecfe81cb1ee867b",
    plugin:[
      'AMap.Autocomplete' //输入提示插件
    , "AMap.Geolocation" //定位控件，用来获取和展示用户主机所在的经纬度位置
    , 'AMap.Geocoder'
    , 'AMap.PlaceSearch' //POI搜索插件
    , 'AMap.Scale'//右下角缩略图插件 比例尺
    , 'AMap.OverView' //地图鹰眼插件
    , 'AMap.ToolBar' //地图工具条
    , 'AMap.MapType' //类别切换控件，实现默认图层与卫星图、实施交通图层之间切换的控制
    , 'AMap.PolyEditor'//编辑 折线多，边形
    , 'AMap.CircleEditor'
  ],   //插件
    v:"1.4.12"  //版本号，默认高德sdk版本为1.4.4，可自行修改
})

Vue.prototype.$axios = Axios;
// Axios.defaults.baseURL = 'http://192.168.1.165:5001';
// Axios.defaults.baseURL = 'http://192.168.1.102:8957';
// Axios.defaults.headers.post['Content-Type'] = 'application/json';
Axios.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded';
Axios.defaults.headers.common['Authorization'] ='Bearer ' +localStorage.getItem("accessToken");
// Axios.defaults.withCredentials=tue;// Check cross-site Access-Controls

Vue.config.productionTip = false
Vue.use(Antd)

Vue.prototype.Permission=permissionConfig;
Vue.prototype.webConfig=webConfig;
Object.keys(filters).forEach(key => {
  Vue.filter(key, filters[key])
})

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: { App },
  template: '<App/>'
})
