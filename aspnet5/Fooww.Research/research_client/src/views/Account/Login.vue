<template>
  <div style="background:orange">
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
          'usernameOrEmailAddress',
          { rules: [{ required: true, message: 'Please input your username!' }] }
        ]"
          placeholder="usernameOrEmailAddress"
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
          'rememberMe',
          {
            valuePropName: 'checked',
            initialValue: true,
          }
        ]"
        >Remember me</a-checkbox>
        <a class="login-form-forgot" href>Forgot password</a>
        <a-button type="primary" html-type="submit" class="login-form-button">Log in</a-button>
        <!-- <a href="">
        register now!
        </a>-->
      </a-form-item>
    </a-form>

<div style="background:red">

<a-form
    layout="inline"
    :form="form2"
    @submit="handleSubmit2"
  >
    <a-form-item
      :validate-status="userNameError() ? 'error' : ''"
      :help="userNameError() || ''"
    >
      <a-input
        v-decorator="[
          'userName',
          {rules: [{ required: true, message: 'Please input your username!' }]}
        ]"
        placeholder="Username"
      >
        <a-icon
          slot="prefix"
          type="user"
          style="color:rgba(0,0,0,.25)"
        />
      </a-input>
    </a-form-item>
    <a-form-item
      :validate-status="passwordError() ? 'error' : ''"
      :help="passwordError() || ''"
    >
      <a-input
        v-decorator="[
          'password',
          {rules: [{ required: true, message: 'Please input your Password!' }]}
        ]"
        type="password"
        placeholder="Password"
      >
        <a-icon
          slot="prefix"
          type="lock"
          style="color:rgba(0,0,0,.25)"
        />
      </a-input>
    </a-form-item>
    <a-form-item>
      <a-button
        type="primary"
        html-type="submit"
        :disabled="hasErrors(form.getFieldsError())"
      >
        Log in
      </a-button>
    </a-form-item>
  </a-form>

  
</div>



  </div>


</template>

<script>
let config1 = {
  showLoading: false
};
export default {
     data(){ 
          return {
                loginForm: {
                    usernameOrEmailAddress:"wsx2019"
                    ,password:"123456"
                    ,rememberMe: true
                    ,returnUrl:""
                    ,returnUrlHash:""
                } 
            }
        },
  beforeCreate () {
    this.form = this.$form.createForm(this);
  },
  methods: {
ajax(url, data = {}, type = 'GET', config = { showLoading: true }) {
  return new Promise(function (resolve, reject) {

    let promise
    if (type === 'GET') {
      // 准备url query参数数据
      let dataStr = '' //数据拼接字符串
      Object.keys(data).forEach(key => {
       
        if (data[key] || data[key]=="0") {

          dataStr += key + '=' + data[key] + '&'
        }

      })
      if (dataStr !== '') {
        dataStr = dataStr.substring(0, dataStr.lastIndexOf('&'))
        url = url + '?' + dataStr
      }

      // 发送get请求
      promise = axios.get(url, config)
    } else if (type === 'PUT') {
      promise = axios.put(url, data, config)
    } else if (type === 'DELETE') {
      let dataStr = ''
      Object.keys(data).forEach(key => {
        dataStr += key + '=' + data[key] + '&'
      })
      if (dataStr !== '') {
        dataStr = dataStr.substring(0, dataStr.lastIndexOf('&'))
        url = url + '?' + dataStr
      }
      promise = axios.delete(url, data, config)
    }
    else {
      // 发送post请求
      promise = axios.post(url, data, config)
    }
    promise.then(function (response) {
      // 成功了调用resolve()
      resolve(response.data)
    }).catch(function (error) {
      //失败了调用reject()
      reject(error)
    })
  })
}
,


    handleSubmit (e) {
      e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          console.log('Received values of form: ', values);
          
          this.$axios.post("Login",this.loginForm)    
          .then((response)=>{
              console.log(response.data);
              if( response.data.success)
              {
                this.visible = false;
                if(this.current==1)
                {
                  this.getData(this.current,this.pagination.pageSize);
                }
              }
              else {
                console.log(response.data.result.error)
              }
            })
            .catch(function(error){
              console.info(error);
            })
            .finally((response)=>{
              console.info(response.data);
            });
            // let res1 =ajax('http://192.168.1.165:5001/api/LoginWithAuthenticate',JSON.stringify(this.loginForm),'POST',config1)
       
        // let res1 =ajax('http://192.168.1.102:8957/Login',JSON.stringify(this.loginForm),'POST',config1)
        // //   let res1 = this.$axios.post(`http://192.168.1.102:8957/Login`, JSON.stringify(this.loginForm),{
        // headers: {
        //     'Content-Type': 'application/json-patch+json'
        // }
    // });
          // let res1=this.$axios.post("api/LoginWithAuthenticate",this.loginForm)
            // let res1 = await reqUserLogin(JSON.stringify(this.ruleForm),config1)
            
          console.log('set Login', res1)
        }
      });
    },
  },
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