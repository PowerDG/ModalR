<template>
  <div style="width:380px;margin: 0 auto">
    <div style="background:orange">
      <div>
        <template>
          <div>
            <a-switch defaultChecked @change="onChange" />
          </div>
        </template>
      </div>

      <a-form
        style="width:360px;margin: 0 auto"
        id="components-form-demo-normal-login"
        :form="form"
        class="login-form"
        @submit="handleSubmit"
      >
        <a-form-item>
          <a-input
            v-model="loginForm.usernameOrEmailAddress"
            v-decorator="[
          'userName',
          { rules: [{ required: true, message: 'Please input your username!' }] }
        ]"
            placeholder="Username"
          >
            <a-icon slot="prefix" type="user" style="color: rgba(0,0,0,.25)" />
          </a-input>
        </a-form-item>
        <a-form-item>
          <a-input
            v-model="loginForm.password"
            v-decorator="[
          'password',
          { rules: [{ required: true, message: 'Please input your Password!' }] }
        ]"
            type="password"
            placeholder="Password"
          >
            <a-icon slot="prefix" type="lock" style="color: rgba(0,0,0,.25)" />
          </a-input>
        </a-form-item>
        <a-form-item>
          <a-checkbox
            v-decorator="[
          'remember',
          {
            valuePropName: 'checked',
            initialValue: true,
          }
        ]"
          >Remember me</a-checkbox>
          <a class="login-form-forgot" href>Forgot password</a>
          <a-button type="primary" html-type="submit" class="login-form-button">Log in</a-button>Or
          <a href>register now!</a>
        </a-form-item>
      </a-form>
    </div>
  </div>
</template>


 

<script>
/****
 * 存入id     toekn       权限列表   导航列表    个人信息    管理员权限分配树
 *
 *
 *
 */
// import {
//     reqAccountLogin
// } from "../../api/index.js";
import {
  reqAccountLogin,
  reqAllUserBrief,
  reqCurrentLoginInformations,
  reqGrantedCurrentPermissionsAsync,
  reqGrantedAllPermissionsAsync,
  reqGrantedPermissionsAsync,
  reqAssignedPermissionsAsync
} from "../../request/api";

import { isEmpty } from "../../fiters/common";
let config1 = {
  showLoading: false
};

export default {
  data() {
    return {
      disabled: true,
      loginForm: {
        usernameOrEmailAddress: "wsx2019",
        password: "123456",
        rememberMe: true,
        returnUrl: "",
        returnUrlHash: ""
      },
      checkPermissions: {
        userId: 1,
        permissionName: "Pages.DNA"
      }
    };
  },
  beforeCreate() {
    this.form = this.$form.createForm(this);
  },
  methods: {
    onChange(checked) {
      console.log(`a-switch to ${checked}`);
      // reqAssignedPermissionsAsync(this.checkPermissions)
      reqGrantedAllPermissionsAsync("")
      .then(response => { 
        console.log("IN-reqAllUserBrief");
        console.log(response);
        console.log(response.result);
        console.log("---");
        if (response.success) {
          console.log("INsuccess-reqAllUserBrief");
        } 
      });
    },

    handleSubmit(e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          console.log("Received values of form: ", values); 
          reqAccountLogin(this.loginForm)
            .then(response => {
              console.log(response);
              console.log(response.result);
              console.log("---");
              if (response.success) {
                console.log(response.success);
                let result = response.result;
                const accessToken = result.accessToken;
                const userId = result.userId;

                if (!isEmpty(accessToken)) {
                  localStorage.setItem("accessToken", accessToken);
                }
                if (!isEmpty(userId)) {
                  localStorage.setItem("userId", userId);
                }
                console.log(accessToken, "【is you new Token】");
                console.log(userId);

                this.$router.push({ path:'/Party/Fund'  })  
              } else {
                console.log("success: false");
                console.log(response.error);
              }
            })
            .catch(function(error) {
              console.info(error);
            })
            .finally(response => {
              console.log("over");
            }); 

        }
      });
    }
  }
};
</script>
<style>
#components-form-demo-normal-login .login-form {
  max-width: 300px;
}
#components-form-demo-normal-login .login-form-forgot {
  float: right;
}
#components-form-demo-normal-login .login-form-button {
  width: 100%;
}
</style>