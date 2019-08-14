export default {
  changeUserInfo(context,payload){
    context.commit("changeUserInfo", payload)
  },
  changeLoginStatus(context,payload){
    context.commit("changeLoginStatus", payload)
  },
  partyPermission(context,payload){
    context.commit("partyPermission", payload)
  },
  bookPermission(context,payload){
    context.commit("bookPermission", payload)
  },
}
