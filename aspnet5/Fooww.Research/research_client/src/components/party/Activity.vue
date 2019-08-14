<template>
<div class="activity">
  <div class="float-left">
      <a-radio-group class="radio-button" id="filter" defaultValue="all" buttonStyle="solid" @change="activityFilter">
        <a-radio-button class="radio-button" value="all">所有活动</a-radio-button>
        <a-radio-button class="radio-button" value="high">评价最高</a-radio-button>
        <a-radio-button class="radio-button" value="most">去的最多</a-radio-button>
      </a-radio-group>
      <a-input-search
        placeholder="活动名称或场所关键字"
        style="width: 250px"
        @search="onSearch"
        enterButton="搜索"
      />
  </div>
  <div style="float: right" class="radio-button">
    <a-button  class="radio-button" type="primary">新增团建</a-button>
  </div>
  <div class="float-left">
    <div class="flex-lay" v-for="activity in Activities">
      <activity-show></activity-show>
      <activity-photo></activity-photo>
    </div>
    <a-pagination
      :pageSizeOptions="pageSizeOptions"
      :total="total"
      showSizeChanger
      :pageSize="pageSize"
      v-model="current"
      @showSizeChange="onShowSizeChange"
    >
      <template slot='buildOptionText' slot-scope='props'>
        <span v-if="props.value!=='50'">{{props.value}}条/页</span>
        <span v-if="props.value==='50'">全部</span>
      </template>
    </a-pagination>
  </div>

</div>
</template>

<script>
    import ActivityPhoto from "@/components/party/ActivityPhoto";
    import ActivityShow from "@/components/party/ActivityShow";

    export default {
      name: "Activity",
      components:{ActivityShow,ActivityPhoto},
      data(){
          return {
            Activities:[1,2,3],
            selected:"primary"
          }
      },
      methods: {
        onSearch(value) {
            console.log(value);
           this.filterType="all";
          },
        activityFilter(e){
          console.log(e.target.value)
        }
      }
    }
</script>

<style scoped>
  .activity
  {
    max-width: 1280px;
    min-height: 300px;
    text-align: left;
  }
  .float-left
  {
    float:left;

  }
  .flex-lay {
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center ;
  }
  .float-right
  {
    float:right;
  }
  .radio-button
  {
    margin-top:10px;
    margin-right: 10px;
  }
</style>
