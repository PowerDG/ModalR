<template>
  <div class="party">
    <div v-if="loginStatus">
      <a-menu class="pary-menu" @click="handleClick" v-model="current" mode="horizontal">
        <a-menu-item key="PartyList" v-if="PartyList">
          <a-icon type="mail" />成员活动
        </a-menu-item>
        <a-menu-item key="Fund" v-if="PartyFund">
          <a-icon type="appstore" />活动经费
        </a-menu-item>
      </a-menu>
      <div style="min-height: 500px">
        <router-view></router-view>
      </div>
    </div>
    <div class="no-auth" v-else>
      <LogoutPage></LogoutPage>
    </div>
  </div>
</template>

<script>
import LogoutPage from "@/views/Account/LogoutPage";
import { reqAllUserBrief, reqGetPartyPermission } from "@/request/api";
export default {
  name: "PartyPage",
  components: { LogoutPage },
  data() {
    return {
      current: [],
      PartyFund: false,
      PartyList: false
    };
  },
  computed: {
    loginStatus() {
      return this.$store.state.userInfo.loginStatus;
    }
    // PartyFund()
    // {
    //   console.log('Fund_GetAll_Default',this.Permission.Fund_GetAll_Default);
    //   if(this.$store.state.partyPermission.contains(this.Permission.Fund_GetAll_Default))
    //   {
    //     return true;
    //   }
    //   return false;
    // },
    // PartyList()
    // {
    //   console.log('Party_GetAll_Default',this.Permission.Party_GetAll_Default);
    //   if(this.$store.state.partyPermission.contains(this.Permission.Party_GetAll_Default))
    //   {
    //     return true;
    //   }
    //   return false;
    // }
  },
  methods: {
    handleClick(e) {
      console.log("click", e);
      console.log("click", e.key);
      console.log("click current", this.current);
      this.current = e.key;
      this.$router.push({ name: e.key });
    },
    permissionInit() {
      let _this = this;
      var model = { moduleName: "PartyInfo" };
      reqGetPartyPermission(model)
        .then(response => {
          console.log("party permission--set--", response.result);
          _this.$store.dispatch("partyPermission", response.result);
          console.log(
            "party permission--get--",
            _this.$store.state.partyPermission
          );
          if (
            _this.$store.state.partyPermission.indexOf(
              _this.Permission.Fund_GetAll_Default
            ) > -1
          ) {
            console.log("PartyFund true");
            _this.PartyFund = true;
          }
          if (
            _this.$store.state.partyPermission.indexOf(
              _this.Permission.Party_GetAll_Default
            ) > -1
          ) {
            console.log("PartyList true");
            _this.PartyList = true;
          }
        })
        .catch(error => {
          console.log("party permission error", error);
        })
        .finally();
      // this.$store.dispatch('partyPermission',hero)
      // console.log('current page permission',this.$store.state.partyPermission);
      // console.log('current page permission',this.Permission.Fund_GetAll_Default);
    }
  },
  created() {
    console.log("PartyPage Created ",this.loginStatus);
    if (!this.$store.state.userInfo.loginStatus) {
      return;
    }
    this.permissionInit();
  },
  mounted() {
    console.log("partypage mounted",this.$store.state.userInfo.loginStatus);
    var url = this.$route.path;
    if (url === "/Party/Fund") {
      this.current = ["Fund"];
    } else if (url === "/Party/PartyList") {
      this.current = ["PartyList"];
    }

    //   var url=this.$route.path;
    //   console.log('url')
    //   if(url === '/Party/Fund'){
    //     this.current=['Fund']
    //   }else if(url === '/Party/PartyList'){
    //     this.current=['PartyList']
    //   }
  }
};
</script>

<style scoped>
.party {
  min-height: 700px;
  max-width: 1280px;
  margin: 0 auto;
}
.pary-menu {
  max-width: 1280px;
  margin: 0 auto;
  display: flex;
  background: none;
}
.no-auth {
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>
