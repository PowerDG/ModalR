<template>
  <div class="research-header">
    <a-modal
      title="密码修改"
      :visible="passwordModalVisible"
      :maskClosable="false"
      @cancel="()=>{this.passwordModalVisible=false;}"
      :footer="null"
    >
      <a-form
        style="width:360px;margin: 0 auto"
        :form="passwordForm"
        @submit="handlePasswordChange"
      >
        <a-form-item
          v-bind="formItemLayout"
          label="原密码"
        >
          <a-input
            v-decorator="[ 'oldPassword',
          {
            rules: [{
              required: true, message: '请输入原密码!',
            }]
          }
        ]"
          />
        </a-form-item>
        <a-form-item
          v-bind="formItemLayout"
          label="新密码"
        >
          <a-input
            v-decorator="[
          'password',
          {
            rules: [{
              required: true, message: '请输入密码!',
            }, {
              validator: validateToNextPassword,
            }],
          }
        ]"
            type="password"
          />
        </a-form-item>
        <a-form-item
          v-bind="formItemLayout"
          label="确认密码"
        >
          <a-input
            v-decorator="[
          'confirm',
          {
            rules: [{
              required: true, message: '请确认密码!',
            }, {
              validator: compareToFirstPassword,
            }],
          }
        ]"
            type="password"
            @blur="handleConfirmBlur"
          />
        </a-form-item>
        <a-form-item v-bind="tailFormItemLayout">
          <a-button type="primary" html-type="submit" class="login-form-button">确认</a-button>
        </a-form-item>
      </a-form>
    </a-modal>
    <a-modal
      title="用户登录"
      :visible="loginModalVisible"
      :destroyOnClose="true"
      :maskClosable="false"
      @cancel="()=>{this.loginModalVisible=false;}"
      :footer="null"
      >
      <a-form
        style="width:360px;margin: 0 auto"
        :form="loginForm"
      >
        <a-form-item>
          <a-input
            v-decorator="['userName', {  rules: [{ required: true, message: '请输入用户名!' }] }
              ]"
            placeholder="用户名"
          >
            <a-icon slot="prefix" type="user" style="color: rgba(0,0,0,.25)" />
          </a-input>
        </a-form-item>
        <a-form-item>
          <a-input
            v-decorator="[ 'password',
                      {  initialValue:'',
                       rules: [{ required: true, message: '请输入密码!' },
                       {min: 1, message: '请输入密码!!'}] }
                      ]"
            type="password"
            placeholder="密码">
            <a-icon slot="prefix" type="lock" style="color: rgba(0,0,0,.25)" />
          </a-input>
        </a-form-item>
        <a-form-item>
          <a-checkbox
            v-decorator="[ 'rememberMe',{
              valuePropName: 'checked',
              initialValue: false,
            }]"
          >五天免登录</a-checkbox>
        </a-form-item>

          <a-button type="primary" @click="handleLogin" >登录</a-button>

      </a-form>
    </a-modal>
    <img style="float:left" src="../../static/images/home/logo.png" height="37" width="384"/>
    <div class="login-div"  @click="login"  v-if="!loginStatus">
      <a-avatar icon="user" :src="avatarSrc"/>
      <span style="text-align: center; font-size: 15px">登录</span>
    </div>
    <div class="float-right" v-else style="font-size: 15px;">
      <a-avatar icon="user" :src="avatarSrc"/>
      <span>{{userName}}，你好！</span>
      <div style="cursor:pointer;display: inline" @click="changePassword">
        <a-icon  type="lock"/>
        <span  >修改密码</span>
      </div>
      <div style="cursor:pointer;display: inline;margin-left: 5px" @click="logout">
        <a-icon  type="poweroff" />
        <span  >退出</span>
      </div>
    </div>

  </div>
</template>
<script>
  import {
    reqAccountLogin, reqChangePassword,
    reqGetPartyPermission,
    reqCurrentLoginInformations
  } from "@/request/api";
    import {isEmpty} from "@/fiters/common";
    import Bus from "@/plugins/Bus";
const userDict={
  9:"管理员A",
  10:"管理员B",
  14:"成员A",
  13:"成员B",
  12:"访客A",
  11:"访客B",
}
    export default {
      name: "ResearchHeader",
      inject:['reload'],
      provide () {
        return {
          login: this.login,
        }
      },
      data(){
        return {

          passwordForm: this.$form.createForm(this),
          loginForm: this.$form.createForm(this),
          formItemLayout: {
            labelCol: {
              xs: {span: 24},
              sm: {span: 8},
            },
            wrapperCol: {
              xs: { span: 24 },
              sm: { span: 16 },
            },
          },
          tailFormItemLayout: {
            wrapperCol: {
              xs: {
                span: 24,
                offset: 0,
              },
              sm: {
                span: 16,
                offset: 8,
              },
            },
          },
          loginModalVisible: false,
          passwordModalVisible: false,
          avatarSrc:'',
          userName:''
        }
      },
      computed:{
        loginStatus(){
          if(isEmpty(this.$store.state.userInfo.userName)){
            return false;
          }
          else {
            return true;
          }
        },
      },
      methods:{
        handlePasswordChange(){
          this.passwordForm.validateFields((err, values) => {
            if (err) {
              return;
            }});
          const form = this.passwordForm;
          var changed={};
          changed.currentPassword=form.getFieldValue('oldPassword');
          changed.newPassword=form.getFieldValue('password');
          console.log('password',changed)
          let _this=this;
          reqChangePassword(changed).then(response => {
            if (response.success) {
              _this.$message.success("修改成功");
            }
          })
            .catch(function(error) {
              _this.$message.error("修改失败");
            })
            .finally(response => {
              _this.passwordModalVisible=false;
            });
        },
        handleConfirmBlur  (e) {
          const value = e.target.value;
          this.confirmDirty = this.confirmDirty || !!value;
        },
        compareToFirstPassword  (rule, value, callback) {
          const form = this.passwordForm;
          if (value && value !== form.getFieldValue('password')) {
            callback('两次输入的密码不一致!');
          } else {
            callback();
          }
        },
        validateToNextPassword  (rule, value, callback) {
          const formPw = this.form;
          if (value && this.confirmDirty) {
            formPw.validateFields(['confirm'], { force: true });
          }
          callback();
        },
        login(){
          console.log("show login ");
          this.loginModalVisible =true;
        },
        changePassword(){
          this.passwordModalVisible =true;
        },
        logout(){
          let _this=this;
          this.$confirm({
            title: '确认退出当前账号?',
            cancelText:"取消",
            okText:"确定",
            onOk() {
              localStorage.removeItem("accessToken");
              localStorage.removeItem("refreshTime");
              localStorage.removeItem("expireTime");
              localStorage.removeItem("userName");
              localStorage.removeItem("userId");
              localStorage.removeItem("avatar");
              localStorage.removeItem("loginStatus");
              _this.avatarSrc='';
              _this.userName='';
              _this.$store.dispatch('changeLoginStatus', localStorage.getItem("loginStatus"));
              _this.$store.dispatch('changeUserInfo', {});
              _this.$store.dispatch('partyPermission', []);
              _this.refreshPage();
            },
            onCancel() {
              console.log('Cancel');
            },
          });
        },
        handleLogin(){
          let _this=this;
          localStorage.removeItem("accessToken");
          this.loginForm.validateFields((err, values) => {
            if (!err) {
              var loginData={};
              loginData.usernameOrEmailAddress=_this.loginForm.getFieldValue('userName');
              loginData.password=_this.loginForm.getFieldValue('password');
              loginData.rememberMe=Boolean(_this.loginForm.getFieldValue('rememberMe'));
              console.log('login data',loginData)
              reqAccountLogin(loginData).then(response => {
                console.log('reqAccountLogin',response);
                if (response.success) {
                  let result = response.result;
                  const accessToken = result.accessToken;
                  const userId = result.userId;
                  if (!isEmpty(accessToken)) {
                    localStorage.setItem("accessToken", accessToken);
                    var curTime = new Date();
                    var refreshTime = new Date(curTime.setSeconds(curTime.getSeconds() + result.expireInSeconds));
                    localStorage.refreshTime = refreshTime;
                    if(_this.loginForm.rememberMe)
                    {
                      var expireTime = new Date(curTime.setHours(curTime.getHours() + 5*24));
                      localStorage.expireTime = expireTime;
                    }
                    _this.loginModalVisible=false;
                  }
                  if (!isEmpty(userId)) {
                    var userInfo={}
                    userInfo.userId =userId;
                    userInfo.loginStatus =true;
                    if(userId>8&&userId<15)
                    {
                      userInfo.userName =userDict[userId];
                    }else
                    {
                      userInfo.userName ="AdminTest";
                    }
                    userInfo.avatar ='https://zos.alipayobjects.com/rmsportal/ODTLcjxAfvqbxHnVXCYX.png';
                    // this.$store.dispatch('changeLoginStatus', localStorage.getItem("loginStatus"));
                    _this.$store.dispatch('changeUserInfo', userInfo);
                    _this.avatarSrc=_this.$store.state.userInfo.avatar;
                    _this.userName=_this.$store.state.userInfo.userName;
                    var model={moduleName:'PartyInfo'};
                    reqGetPartyPermission(model).then(
                      (response)=>{
                        _this.$store.dispatch('partyPermission',response.result);
                        console.log('party permission--get--', _this.$store.state.partyPermission);
                        _this.refreshPage();
                      }
                    ).catch((error)=>{
                      console.log('party permission error', error)
                    }).finally();
                  }
                  // this.$router.ref({ path:this.$route.path});
                  // this.$router.go(0);
                  // this.$router.push({ path:'/Party/Fund'  })
                } else {
                  console.log("success: false");
                  console.log(response.error);
                }
              })
                .catch(function(error) {
                  console.info('login error',error);
                })
                .finally(response => {
                  console.log("over");
                });
            }
            else {
              console.log("login data error ",err);
            }
          });
        },
        refreshPage()
        {
          console.log('reload')
          //console.log('reload', this.avatarSrc=localStorage.getItem("accessToken"))
          this.reload();
        }
      },
      create(){
        console.log('Header created',this.$store.state.userInfo.loginStatus);
      },
      mounted () {
        //设置登录信息
        console.log('Header mounted loginStatus',this.$store.state.userInfo.loginStatus);
        // this.userName=localStorage.getItem("userName");
        // this.avatarSrc=localStorage.getItem("avatar");
        this.avatarSrc=this.$store.state.userInfo.avatar;
        this.userName=this.$store.state.userInfo.userName;
        Bus.$on('login', content => {
          console.log(content)
          this.login();
        });
      },
      beforeCreate () {
      },
    }
</script>

<style scoped>
.research-header
{
  max-width: 1280px;
  margin:0 auto;
/*background: darkgrey;*/
}
  .float-right
  {
    float:right
  }
.login-div
{
  float:right;
  cursor: pointer;
}
</style>
