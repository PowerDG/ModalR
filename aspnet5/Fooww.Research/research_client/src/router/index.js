import Vue from 'vue'
import Router from 'vue-router'

import HomePage from "@/views/HomePage";
import Login from "@/views/Account/Login";
import AccountLogin from "@/views/Account/AccountLogin";
import LibraryPage from "@/views/LibraryPage";
import BookList from "@/components/Libraries/BookList";


import RankPage from "@/views/RankPage";
import MissionPage from "@/views/MissionPage";
import AchievementPage from "@/views/AchievementPage";
import TaskBoard from "@/components/Mission/TaskBoard";
import TaskMember from "@/components/Mission/TaskMember";
import PlanTable from "@/components/Mission/PlanTable";
import TaskTable from "@/components/Mission/TaskTable";
import MemberDetail from "@/components/MemberDetail";


import PartyList from "@/components/party/PartyList";
import ActivityList from "@/components/party/ActivityList";
import Activity from "@/components/party/Activity";
import Fund from "@/components/party/Fund";
import test from "@/components/party/test";
import PartyPage from "@/views/PartyPage";

import PlanDetail from "@/components/Mission/PlanDetail";
import TaskDetail from "@/components/Mission/TaskDetail";
import ActivityDetail from "@/components/party/ActivityDetail";

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      redirect:'Home'
    },
    {
      path: '/Home',
      name: 'HomePage',
      component: HomePage
    },{
      path: '/Login',
      name: 'LoginPage',
      component: Login
    },{
      path: '/AccountLogin',
      name: 'AccountLoginPage',
      component: AccountLogin
    },
    // {
    //   path: '/BookList',
    //   name: 'BookList',
    //   component: BookList
    // },
    {
      path: '/Member',
      name: 'MemberDetail',
      component: MemberDetail
    },
    {
      path: '/Mission',
      name: 'MissionPage',
      component: MissionPage,
      children:[
        {
          path: '',
          redirect:'TaskBoard'
        },
        {
          path: 'TaskBoard',
          name: 'TaskBoard',
          component: TaskBoard
        },
        {
          path: 'Task',
          name: 'TaskTable',
          component: TaskTable
        },
        {
          path: 'Plan',
          name: 'PlanTable',
          component: PlanTable
        },
        {
          path: 'TaskMember',
          name: 'TaskMember',
          component: TaskMember
        }
      ]
    },
    {
      path: '/Plan',
      name: 'PlanDetail',
      component: PlanDetail
    },
    {
      path: '/Task',
      name: 'TaskDetail',
      component: TaskDetail
    },
    {
      path: '/Rank',
      name: 'RankPage',
      component: RankPage
    },
    {
      path: '/Party',
      name: 'PartyPage',
      component: PartyPage,
      children:[
        {
          path: '',
          redirect:'PartyList'
        },{
          path: 'ActivityList',
          name: 'ActivityList',
          component: ActivityList
        }, {
          path: 'PartyList',
          name: 'PartyList',
          component: PartyList
        },
        {
          path: 'Activity',
          name: 'Activity',
          component: Activity
        },
        {
          path: 'Fund',
          name: 'Fund',
          component: Fund
        }
      ]
    },
    {
      path: '/Library',
      name: 'LibraryPage',
      component: LibraryPage,
      children:[ {
          path: 'BookList',
          name: 'BookList',
          component: BookList
        }
      ]
    },
    {
      path: '/Achievement',
      name: 'AchievementPage',
      component: AchievementPage
    },
    {
      path: '/test',
      name: 'test',
      component: test
    },
    {
      path: '/create',
      name: 'create',
      component: ActivityDetail
    }
  ]
})


// router.beforeEach((to, from, next) => {
//   //用你的方式获取登录的用户信息
//   const userinfo = localStorage.userinfo
//   // if(userInfo || to.name === 'AccountLogin'){

//   if(to.name === 'AccountLogin'){
//       //如果存在用户信息，或者进入的页面是登录页面，则直接进入
//       next()
//   }else {
//       //不存在用户信息则说明用户未登录，跳转到登录页面，带上当前的页面地址，登录完成后做回跳，
//       //如未登录用户进入用户中心的页面地址，检测到未登录，
//       //自动跳转到登录页面，并且带上用户中心的页面地址，登录完成后重新跳到个人中心页面。
//       next({
//         name: 'AccountLogin',
//         query: {
//           redirect: to.path
//         }
//       })
//   }
// })

