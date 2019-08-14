<template>
    <div class="middle">
      <div v-if="loginStatus">
        <div v-if="bookPage">
          <book-list></book-list>
        </div>
        <div class="no-auth" v-else>
          <no-permission-page></no-permission-page>
        </div>
      </div>
      <div class="no-auth" v-else>
        <LogoutPage></LogoutPage>
      </div>
      <!--<a-menu class="pary-menu"-->
        <!--@click="handleClick"-->
        <!--v-model="current"-->
        <!--mode="horizontal"-->
      <!--&gt;-->
        <!--<a-menu-item key="Activity">-->
          <!--<a-icon type="menu-unfold" />藏云经阁-->
        <!--</a-menu-item>-->
        <!--<a-menu-item key="Fund" >-->
          <!--<a-icon type="interation" />百家讲坛-->
        <!--</a-menu-item>-->
      <!--</a-menu>-->
      <!--<div style="min-height: 500px">-->
        <!--<router-view></router-view>-->
      <!--</div>-->
    </div>

</template>

<script>

  import { reqGetPartyPermission } from "@/request/api";
  import BookList from "@/components/Libraries/BookList";
  import LogoutPage from "@/views/Account/LogoutPage";
  import NoPermissionPage from "@/views/Account/NoPermissionPage";

    export default {
      name: "PartyPage",
      components:{ BookList,LogoutPage,NoPermissionPage},
      data () {
        return {
          current: ['activity'],
          bookPage:false,
        }
      },
      computed:{
        loginStatus() {
          return this.$store.state.userInfo.loginStatus;
        }
      },
      methods: {
        handleClick (e) {
          console.log('click', e)
          console.log('click', e.key)
          this.$router.push({name:e.key})
        },
        permissionInit(){
          let _this = this;
          var model = { moduleName: "BookInfo" };
          reqGetPartyPermission(model)
            .then(response => {
              console.log("book permission--set--", response.result);
              _this.$store.dispatch("bookPermission", response.result);
              if (_this.$store.state.bookPermission.indexOf(
                  _this.Permission.BookInfo_GetPages_Default
                ) > -1
              ) {
                _this.bookPage = true;
              }
            })
            .catch(error => {
              console.log("book permission error", error);
            })
        }

      },
      created() {
        console.log("Library Created ",this.loginStatus);
        if (!this.$store.state.userInfo.loginStatus) {
          return;
        }
        this.permissionInit();
      },
    }
</script>

<style scoped>
.party{
 min-height: 700px;
  max-width: 1280px;
  margin:0 auto;
}
  .pary-menu
  {
    max-width: 1280px;
    margin:0 auto;
    display: flex;
    background: none;
  }
.no-auth {
  display: flex;
  justify-content: center;
  align-items: center;
}
</style>


