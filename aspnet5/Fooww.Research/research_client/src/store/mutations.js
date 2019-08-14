export default {

  changeUserInfo(state,payload){
    state.userInfo = payload;
  },
  changeLoginStatus(state,payload){
    state.loginStatus = payload;
  },
  partyPermission(state,payload){
    state.partyPermission = payload;
  },
  bookPermission(state,payload){
    state.bookPermission = payload;
  },
}
