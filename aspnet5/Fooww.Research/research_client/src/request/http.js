import axios from 'axios';
import QS from 'qs';
import {isEmpty} from "@/fiters/common";
import store from '../store/index'

// 环境的切换
if (process.env.NODE_ENV == 'development') {
	axios.defaults.baseURL = 'http://192.168.1.102:8957';}
else if (process.env.NODE_ENV == 'debug') {
	axios.defaults.baseURL = 'http://192.168.1.102:8957';;
}
else if (process.env.NODE_ENV == 'production') {
	axios.defaults.baseURL = 'http://192.168.1.102:8957';;
}
axios.defaults.timeout = 3600;
// 请求拦截器

axios.interceptors.request.use(
    config => {
        // 每次发送请求之前判断vuex中是否存在token
        // 如果存在，则统一在http请求的header都加上token，这样后台根据token判断你的登录情况
        // 即使本地存在token，也有可能token是过期的，所以在响应拦截器中要对返回状态进行判断
        // console.log('befor req ',localStorage)
       //console.log('befor req ',store.state.userInfo.loginStatus)
        // if (!isEmpty(localStorage.accessToken)) {
        if (localStorage.accessToken) {
          // console.log('befor req with token',localStorage)
          let token= "Bearer " + localStorage.getItem("accessToken");
          //todo 获取用户信息
          // reqUserInfo()
          config.headers.Authorization=token;
          console.log('befor req add token ',config.headers.Authorization)
        }
        else{
          console.log('befor req no token ')
          config.headers.Authorization="";
        }
        return config;
    },
    error => {
        return Promise.error(error);
})

// 响应拦截器
axios.interceptors.response.use(
    response => {
        // 如果返回的状态码为200，说明接口请求成功，可以正常拿到数据
        // 否则的话抛出错误
        if (response.status === 200) {
            return Promise.resolve(response);
        } else {
            return Promise.reject(response);
        }
    },
    // 服务器状态码不是2开头的的情况
    // 这里可以跟你们的后台开发人员协商好统一的错误状态码
    // 然后根据返回的状态码进行一些操作，例如登录过期提示，错误提示等等
    // 下面列举几个常见的操作，其他需求可自行扩展
    error => {
      error =error.response;
        if (error.status) {
            switch (error.status) {
              // 401: 未登录
              // 未登录则跳转登录页面，并携带当前页面的路径
              // 在登录成功后返回当前页面，这一步需要在登录页操作。
              case 401:
                console.log("401 to login",store);
                store.dispatch('changeUserInfo', {});
                store.dispatch('partyPermission', []);
                if(typeof(localStorage.getItem("accessToken"))!='undefined')
                {
                  localStorage.removeItem("accessToken");
                }
                console.log("401 to login",store);
                //location.hash="#/AccountLogin"
                    // router.replace({
                    //     path: '/AccountLogin',
                    //     query: {
                    //         redirect: router.currentRoute.fullPath
                    //     }
                    // });
                    break;
              // 403 token过期
              // 登录过期对用户进行提示
              // 清除本地token和清空vuex中token对象
              // 跳转登录页面
              case 403:
                Toast({
                  message: '登录过期，请重新登录',
                  duration: 1000,
                  forbidClick: true
                });
                // 清除token
                localStorage.removeItem('token');
                store.commit('loginSuccess', null);
                // 跳转登录页面，并将要浏览的页面fullPath传过去，登录成功后跳转需要访问的页面
                setTimeout(() => {
                  router.replace({
                    path: '/login',
                    query: {
                      redirect: router.currentRoute.fullPath
                    }
                  });
                }, 1000);
                break;

              // 404请求不存在
              case 404:
                console.log("404 post-response--",error.data.message);

                break;
              // 其他错误，直接抛出错误提示
              default:
                console.log("default post-response--",error);
            }
            return Promise.reject(error);
        }
    }
);


/**
* get方法，对应get请求
* @param {String} url [请求的url地址]
* @param {Object} params [请求时携带的参数]
*/
export function get(url, params){
  console.log('get --',url,params)
  return new Promise((resolve, reject) =>{
      axios.get(url, {
          params: params
      }).then(res => {
          resolve(res.data);
      }).catch(err =>{
          reject(err.data)
  })
});}

/**
  * post方法，对应post请求
  * @param {String} url [请求的url地址]
  * @param {Object} params [请求时携带的参数]
  */
 export function post(url, params) {
    return new Promise((resolve, reject) => {
          axios.post(url, params)
        .then(res => {
            resolve(res.data);
        })
        .catch(err =>{
            reject(err.data)
        })
    });
}


export function postify(url, params) {

    console.log("postify-response--");
    return new Promise((resolve, reject) => {
          axios.post(url, QS.stringify(params))
        .then(res => {
            resolve(res.data);
        })
        .catch(err =>{
            reject(err.data)
        })
    });
}


export function del (url, params){

    console.log("delete-response--");
    return new Promise((resolve, reject) => {
        // console.log(QS.stringify(params));
          axios.delete(url, params)
        .then(res => {
            resolve(res.data);
        })
        .catch(err =>{
            reject(err.data)
        })
    });
}


export function put (url, params){

    console.log("put-response--");
    return new Promise((resolve, reject) => {
        // console.log(QS.stringify(params));
          axios.put(url, params)
        .then(res => {
            resolve(res.data);
        })
        .catch(err =>{
            reject(err.data)
        })
    });
}


export function putify (url, params){

    console.log("putify-response--");
    return new Promise((resolve, reject) => {
          axios.put(url, QS.stringify(params))
        .then(res => {
            resolve(res.data);
        })
        .catch(err =>{
            reject(err.data)
        })
    });
}
