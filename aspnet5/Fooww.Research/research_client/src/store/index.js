import Vue from 'vue'
import Vuex from 'vuex'
import createPersistedState from "vuex-persistedstate"
import state from "@/store/states";
import mutations from '@/store/mutations'
import getters from '@/store/getters'
import actions from '@/store/actions'
Vue.use(Vuex);

var store=new Vuex.Store({
  state,
  mutations,
  getters,
  actions,
  plugins: [createPersistedState({
    storage: window.sessionStorage,
  })]
})
export default store
