<template>
    <div class="navigation-bar">
      <div  v-for="page in pageleft" class="left">
        <router-link tag="span" :to="page.router" class="navigation-title" :style="page.backgroundstyle"
                     @mousedown="select_changed(page.backgroundstyle)"
        >{{ page.text }}</router-link>
      </div>
      <div id="middle" class="middletitle" @mouseenter="enter()" @mouseleave="leave()" >
        <div v-if="xiafoucus">
          <img  src="../../static/images/home/xia_focus.png" height="117" width="117"/>
        </div>
        <div v-else>
          <img src="../../static/images/home/xia.png" height="117" width="117"/>
        </div>
      </div >
      <div v-for="page in pageright"  class="left">
            <router-link tag="span" :to="page.router" class="navigation-title" :style="page.backgroundstyle"
            @mousedown="select_changed()"
            >{{ page.text }}</router-link>
          </div>
    </div>

</template>

<script>
  function getbackgroundImage() {
    return {
      backgroundImage: 'url(' + require('../../static/images/home/Navigation/normal.png') + ')'
    };
  }
  export default {
    name: "NavigationBar",
    components:[],
      data(){
        return {
          pageleft: [
            {text: '聚义厅',
              router:  {name:'HomePage'},
              backgroundstyle:{
                backgroundImage: 'url(' + require('../../static/images/home/Navigation/selected.png') + ')'
              }},
            {text: '白虎堂',router: {path: '/Mission'},
              backgroundstyle:{backgroundImage:'url(' + require('../../static/images/home/Navigation/normal.png') + ')'}},
            {text: '琅琊榜',router: {name: 'RankPage'},
              backgroundstyle:{backgroundImage:'url(' + require('../../static/images/home/Navigation/normal.png') + ')'}}
          ],
          pageright: [
            {text: '快活林', router: {path: '/Party'},
              backgroundstyle:{backgroundImage:'url(' + require('../../static/images/home/Navigation/normal.png') + ')'}},
            {text: '撷英阁', router:  {name:'LibraryPage'},
              backgroundstyle:{backgroundImage:'url(' + require('../../static/images/home/Navigation/normal.png') + ')'}},
            {text: '玄机谱',router:  {name:'AchievementPage'},
              backgroundstyle:{
                backgroundImage: 'url(' + require('../../static/images/home/Navigation/normal.png') + ')'
              }}
          ],
          xiafoucus: false
        }
      },
    methods:{
      enter(){
        this.xiafoucus = true;
      },
      leave(){
        this.xiafoucus = false;
      },
      select_changed(backgroundstyle)
      {
        backgroundstyle={
          backgroundImage: 'url(' + require('../../static/images/home/Navigation/selected.png') + ')'
        }
      }
    }
    }
</script>

<style scoped>

  /*#left, #middle, #right{*/
    /*display: inline-block;*/
  /*}*/
.navigation-title{
  width: 129px;
  height: 41px;
  display:inline-block;
  text-align: center;
  /*margin-top: 47px;*/
  line-height: 40px;
  cursor: pointer;
}

.navigation-bar{
  max-width: 1200px;
  /*background: aliceblue;*/
  horiz-align: center;
  vertical-align: middle;
  min-height: 117px;
  margin:0 auto;
  display: flex;
  flex-wrap: wrap;
}
  .left{
    width: 130px;
    height: 117px;
    line-height: 117px;
    float:left;
    flex: 1;
    position: center;
  }
  .middletitle{
    float:left;
    text-align: center;
    vertical-align: center;
    width: 120px;
    height: 117px;
    flex: 1;
  }
</style>
