<template>
  <div>
    <a-menu
      @click="handleClick"
      v-model="current"
      mode="horizontal"
    >
      <a-menu-item key="TaskBoard">
        <a-icon type="mail" />看板视图
      </a-menu-item>
      <a-menu-item key="TaskTable" >
        <a-icon type="appstore" />任务视图
      </a-menu-item>
      <a-menu-item key="PlanTable">
        <a-icon type="setting" />计划视图
      </a-menu-item>
      <a-menu-item key="TaskMember">
       <a-icon type="appstore" />成员视图
      </a-menu-item>
    </a-menu>
    <div style="min-height: 500px">
      <router-view></router-view>
    </div>
  </div>
</template>
<script>
  export default {
    name: "MissionPage",
    data () {
      return {
        current: ['TaskBoard'],
      }
    },
    methods: {
      handleClick (e) {
        console.log('click', e.key)
        this.$router.push({name:e.key})
      },
      titleClick (e) {
        console.log('titleClick', e)
      },
    }
  }
</script>

