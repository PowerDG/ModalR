<template>
  <div class="detail">
    <div class="div-css" >
      <span>{{title}}</span>    <a-icon class="edit-icon" type="edit" @click="() => edit(id)" tag="编辑"/>
      <a-popconfirm title="Sure to delete?" @confirm="() => onDelete(id)">
        <a-icon class="edit-icon" type="delete"  tag="删除"/>
      </a-popconfirm>
    </div>
    <div class="content">
       {{place}} {{address}}
    </div>
    <div class="content">
      {{tel}}
    </div>
    <div class="content">{{costformat}}</div>
    <div class="content">
      <span>
        <a-rate v-model='likeLevel'/>
        <span class="ant-rate-text">{{likeLevel}} 星</span>
        <span> {{likeCount}} 次打分</span>
      </span>
    </div>
    <div class="content">
      <a-icon class="edit-icon" type="edit" @click="() => addComment(id)" tag="添加评论"/>
    </div>
  </div>
</template>
<script>
  function getBase64 (img, callback) {
    const reader = new FileReader()
    reader.addEventListener('load', () => callback(reader.result))
    reader.readAsDataURL(img)
  }
  const sourceName=["团队经费","捐赠","其他"]
  export default {
    name: "ActivityShow",
    data () {
      return {
        id:0,
        title:'欢迎黄劲入职',
        startTime:  "2019-02-02 12:12:12",
        endTime:  "2019-02-02 12:12:12",
        place:'自由港ktv',
        address:'东川路123',
        tel:'1234123',
        cost: 120,
        number: 12,
        source:0,
        likeLevel:3,
        likeCount: 4,
        comments:['213','123','123']
      }
    },
    computed:{
      costformat: function () {
        return this.cost/this.number+'大洋/'+this.number+'人 - '+sourceName[this.source];
      }
    },
    methods: {
      addComment(id){

      },
      edit(id){

      },
      onDelete(id){

      }
    },
  }
</script>
<style>

  .detail{
    display: flex;
    flex-direction: column;
    margin:0 auto;
    width: 450px;
  }

  .div-css{
    margin: 10px;
    font-size: 20px;
  }
  .content{
    margin: 10px;
  }

  .avatar-uploader {
    width: 158px;
    height: 128px;
  }
  .ant-upload-select-picture-card i {
    font-size: 32px;
    color: #999;
  }

  .ant-upload-select-picture-card .ant-upload-text {
    margin-top: 8px;
    color: #666;
  }
  .edit-icon
  {
    height: 25px;
    width: 25px;
    cursor: pointer;
  }
</style>

