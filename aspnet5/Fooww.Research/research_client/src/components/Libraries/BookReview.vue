<template>
  <div >
    <a-divider orientation="left" dashed="dashed" >评论详情 ({{pagination.total}})</a-divider>
    <a-list size="large"
            :grid="{ gutter: 16, xs: 1, sm: 1, md: 2, lg: 3, xl: 1, xxl: 1 }"
            :pagination="pagination"
            :dataSource="reviewData"
    >
      <a-list-item   key="item.title" slot="renderItem" slot-scope="item, index" >
        <div :class="{'moveOn': item.moveonStatus}"
             @mouseenter="enter(index)"
             @mouseleave="leave(index)">
          <div class="review-list-item">
            <div class="review-list-col" style="width:80px">
              <div >{{item.memberName}}</div>
            </div>
            <div class="review-list-col" style=" width:80px">
              <span>
              {{item.lastModificationTime.toString().substr(0,10)}}
            </span>
            </div>
            <div class="review-list-col" style="width:150px">
              <a-rate  :disabled="rateDiabled" v-model="item.score" />
            </div>
          </div>
          <div class="review-list-item" style="width: 500px" >
            <div class="list-col-text-review"  :title='item.review'>{{item.review}}</div>
          </div>
        </div>
      </a-list-item>
    </a-list>
  </div>
</template>

<script>
  import {reqGetReviewPaged} from "@/request/api";

  export default {
    props:['bookId'],
    name: "BookReview",
    data(){
      return {
        id:this.bookId,
        dashed:true,
        rateDiabled:true,
        reviewData: [ ],
        pagination: {
          pageSizeOptions: ["1", "3"],
          defaultCurrent: 1,
          current: 1,
          showSizeChanger: true,
          pageSize: 3,
          total: 0,
          showQuickJumper: true,
          position: "bottom",
          onChange: (page, pageSize) => this.changePage(page, pageSize),
          showTotal: total => "共 " + total + " 条",
          onShowSizeChange: (current, pageSize) =>
            this.onShowSizeChange(current, pageSize)
        },
      }
    },
    methods:{
      changePage(page, pageSize) {
        console.log('get changePage ',page, pageSize )
        this.pagination.current = page;
        this.pagination.pageSize = pageSize;
        this.getData(this.pagination.current, this.pagination.pageSize);
      },
      onShowSizeChange(current, pageSize) {
        console.log('get onShowSizeChange ',page, pageSize )
        this.pagination.pageSize = pageSize;
        this.getData(current, this.pagination.pageSize);
      },
      getData(page, pageSize) {
        console.log('get data ',page, pageSize,this.bookId,this.id )
        let _this=this;
        reqGetReviewPaged({
          maxResultCount: pageSize,
          skipCount: pageSize * (page - 1),
          bookId: this.id
        })
          .then(response => {
            var items = response.result.items;
            console.log("in response", items);
            for (let i = 0; i < items.length; i++) {
              items.moveonStatus=false;
            }
            _this.reviewData = items;
            console.log("in entitylistData", _this.reviewData);
            _this.pagination.total = response.result.totalCount;
          })
          .catch(function(error) {
            console.info(error);
            _this.reviewData=[];
            _this.pagination.total = 0;
          });
      },
      enter(index) {
        console.log('enter',index)
        var data=this.reviewData[index];
        data.moveonStatus=true;
        this.reviewData.splice(index,1,data);

        console.log('enter',this.reviewData[index].moveonStatus)
      },
      leave(index) {
        console.log('leave',index)
        var data=this.reviewData[index];
        data.moveonStatus=false;
        this.reviewData.splice(index,1,data);
        console.log('leave',this.reviewData[index].moveonStatus)
      },
    },
    mounted(){
      console.log('review mounted bookid,id',this.bookDetail,this.id);
      this.getData(this.pagination.current, this.pagination.pageSize);
    },
    watch: {
      // bookData(newData, prevData) {
      //   console.log(newData, 123654789)
      //   // this.bookDetail = {...newData};
      // }
    }
  }
</script>

<style scoped>
  .moveOn{
    background-color: #f2f2f2;
  }
  .review-style{
    display: flex;
    flex-direction: column;
    /*justify-content: space-around;*/
    align-items: center;
  }
  .review-list-item {
    display: flex;
    flex-direction: row;
    /*background-color: antiquewhite;*/
  }
  .review-list-col {
    margin-left: 20px;
    display: flex;
    align-items:center;
    /*background-color: lightgray;*/
    height: 30px;
  }
  .list-col-text-review {
    /*margin: 0 auto;*/
    margin-left: 20px;
    margin-top: 10px;
    /*background-color: antiquewhite;*/
    align-items:center;
    flex-wrap: wrap;
    height: 43px;
    width: 500px;
    display: flex;
    text-align: left;
    justify-content: left;
    white-space:pre-wrap;
    text-overflow:ellipsis;
    overflow:hidden;
  }
</style>
