<template>
  <div>
    <a-button type="primary" @click="showDrawer" v-if="bookCreateShow">
      <a-icon type="plus" />添加新书
    </a-button>
    <a @click="showDrawer()" v-if="bookNameShow" :class="{'delete-style': bookDetail.state==2}">《{{bookDetail.name}}》</a>
    <a-icon class="icon-style" type="message" title="详情" v-if="bookIconShow" @click="showDrawer()" />
    <div>
      <a-drawer
        title="图书详情"
        :width="720"
        @close="onClose"
        :destroyOnClose="destroyOnClose"
        :visible="createDrawerVisible"
        :wrapStyle="{height: 'calc(100% - 108px)',overflow: 'auto',paddingBottom: '108px'}"
      >
        <div style="margin-bottom: 50px">
          <a-form :form="detailForm" layout="vertical" >
            <a-divider orientation="left" dashed="dashed">基本信息</a-divider>
            <div>
              <a-row :gutter="16">
                <a-col :span="12">
                  <a-form-item label="书名">
                    <a-input :disabled="!canEditPermission"
                      v-decorator="[ 'name',
                      {  initialValue:bookDetail.name,
                         rules: [{ required: true, message: '请输入书名！' },
                         {max: 60, message: '书名不能超过60个字符!'}
                        ], } ]"
                      placeholder="请输入书名"
                    />
                  </a-form-item>
                  <a-form-item label="作者">
                    <a-input :disabled="!canEditPermission"
                      v-decorator="['author', {
                        initialValue:bookDetail.author,
                        rules: [{ required: true, message: '请输入作者！' },
                        {max: 60, message: '作者不能超过60个字符!'}]}]"
                      placeholder="请输入作者"
                    />
                  </a-form-item>
                  <a-form-item label="来源">
                    <a-input :disabled="!canEditPermission"
                      v-decorator="['resource', {
                        initialValue:''+bookDetail.resource,
                        rules: [{ required: true, message: '请输入来源！' },
                         {max: 60, message: '来源不能超过60个字符!'}]}]"
                      placeholder="请输入来源"
                    />
                  </a-form-item>
                </a-col>
                <a-col :span="12" :rows="5">
                  <a-form-item label="封面图片">
                    <a-upload :disabled="!canEditPermission"
                      name="avatar"
                      listType="picture-card"
                      class="avatar-uploader"
                      :showUploadList="false"
                      :beforeUpload="beforeUpload"
                      v-decorator="[ 'picture',{ initialValue:bookDetail.photo,
                      rules: [{ required: true, message: '请选择图片!' }], } ]"
                    >
                      <img class="image-size" v-if="photoSrc" :src="photoSrc" alt="avatar" />
                      <div v-else>
                        <a-icon :type="loading ? 'loading' : 'plus'" />
                        <div class="ant-upload-text">添加图片</div>
                      </div>
                    </a-upload>
                  </a-form-item>
                </a-col>
              </a-row>
            </div>
            <a-divider orientation="left" dashed="dashed" v-if="bookNameShow||bookIconShow">阅读状态</a-divider>
            <div v-if="bookNameShow||bookIconShow">
              <a-row>
                <a-col :span="12">
                  <a-form-item label="评分">
                    <div>
                      <span>
                        <a-icon type="smile" />
                        <a-rate
                          :disabled="rateDiabled"
                          v-decorator="['resource', {
                        initialValue:bookDetail.averageScore,
                }]"
                        />
                      </span>
                    </div>
                  </a-form-item>
                </a-col>

                <a-col :span="12">
                  <a-form-item label="加入时间">
                    <div>
                      <div class="content">
                        <a-icon type="environment" />
                        [{{bookDetail.creationTime|dateFilter}}]
                      </div>
                    </div>
                  </a-form-item>
                </a-col>
              </a-row>
              <a-row>
                <a-col :span="12">
                  <a-form-item label="阅读中">
                    <div>{{bookDetail.memberName}}</div>
                  </a-form-item>
                </a-col>

                <a-col :span="12">
                  <a-form-item label="阅读过">
                    <div></div>
                  </a-form-item>
                </a-col>
              </a-row>
            </div>
            <book-review :book-id="bookDetail.id" v-if="bookNameShow||bookIconShow"></book-review>
          </a-form>
        </div>
        <div v-if="canEditPermission"
          :style="{
          position: 'absolute',
          left: 0,
          bottom: 0,
          width: '100%',
          borderTop: '1px solid #e9e9e9',
          padding: '10px 16px',
          background: '#fff',
          textAlign: 'right',
        }"
        >
          <a-button :style="{marginRight: '8px'}" @click="onClose">取消</a-button>
          <a-button @click="onCreateOrUpdateParty" type="primary">提交</a-button>
        </div>
      </a-drawer>
    </div>
  </div>
</template>
<script>
import {
  reqCreateBook,
  reqUpdateBook,
  reqUploadImage,
  reqDeleteParty,
  reqGetBookResourceType,
  reqGetReviewPaged,
  reqGetPartyComments
} from "../../request/api";
import Bus from "@/plugins/Bus";
import BookReview from "./BookReview";

function getBase64 (img, callback) {
  const reader = new FileReader()
  reader.addEventListener('load', () => callback(reader.result))
  reader.readAsDataURL(img)
}
export default {
  name: "BookEditModal",
  props: ["bookData", "showType"],
  components:{BookReview},
  data() {
    return {
      bookDetailPermission:false,
      bookCreatePermission: false,
      bookUpdatePermission: false,

      bookCreateShow: false,
      bookNameShow: false,
      bookIconShow: false,

      rateDiabled:true,
      dashed:true,
      //#region    image
      photoSrc:'',
      loading:false,
      //#endregion
      //bookDetail:this.bookData,
      bookDetail: {
        id: 0,
        name: "",
        author: "",
        photo: "",
        photoHd: "",
        resource: ""
      },
      bookEmpty: {
        id: 0,
        name: "",
        author: "",
        photo: "",
        photoHd: "",
        resource: ""
      },
      detailForm: this.$form.createForm(this),
      createDrawerVisible: false,
      destroyOnClose:true,
    };
  },
  computed:{
    canEditPermission(){
      if(this.showType=='button')
      {
        if(this.bookCreatePermission)
        {
          return true;
        }
      }else if(this.bookUpdatePermission)
      {
        return true;
      }
    },
  },
  methods: {

    //#region    抽屉与弹窗
    showDrawer() {
      console.log("showDrawer", this.bookDetail.name,this.bookDetail.photo);
      if(this.showType=='button')
      {
        this.bookDetail ={...this.bookEmpty};
        console.log(" button showDrawer", this.bookDetail.name,this.bookDetail.photo);
      }else if(!this.bookDetailPermission)
      {
        this.$message.warn('您没有权限查看图书详情！');
        return;
      }
      this.photoSrc=this.bookDetail.photo;
      this.createDrawerVisible = true;
    },
    onClose() {
      this.createDrawerVisible = false;
      //modal.destroy();
    },
    showModal() {
      this.visible = true;
    },
    //#endregion

    //#region 图书详情Edit-entityDetailForm
    onCreateOrUpdateParty(){
      let _this = this;
      _this.detailForm.validateFields((err, values) => {
        if (!err) {
          _this.bookDetail.name = _this.detailForm.getFieldValue("name");
          _this.bookDetail.author = _this.detailForm.getFieldValue("author");
          _this.bookDetail.resource = _this.detailForm.getFieldValue("resource");
          if(_this.photoSrc.indexOf("http")>-1?true:false)
          {
            console.log('not change photo',_this.bookDetail.photo);
            _this.bookDetail.photo=_this.bookDetail.photo.substring(
              this.webConfig.ImageBaseUrl.length,_this.bookDetail.photo.length)
            _this.bookDetail.photoHd=_this.bookDetail.photoHd.substring(
              this.webConfig.ImageBaseUrl.length,_this.bookDetail.photoHd.length)
            if(this.showType=='button')
            {
              _this.insertBook();
            }
            else
            {
              _this.updateBook();
            }
          }
          else {
            var image={}
            image.NeedThumb=true;
            image.Base64String=this.photoSrc;
            console.log("handleupload",image)
            reqUploadImage(image)
              .then((response)=>{
                console.log("image result: ",response);
                if(response.success)
                {
                  _this.bookDetail.photo = response.thumbUrl;
                  _this.bookDetail.photoHd = response.originalUrl;

                  if(this.showType=='button')
                  {
                    _this.insertBook();
                  }
                  else
                  {
                    _this.updateBook();
                  }
                }
              })
              .catch(function(error){
                console.info(error);
                //_this.sendOnce=false;
              });
          }
        }
      });
    },
    beforeUpload (file) {
      console.log('beforeUpload',file.type)
      const isJPG = file.type.indexOf("image")==-1?false:true;
      if (!isJPG) {
        this.$message.error('请选择图片类型文件!')
      }
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isLt2M) {
        this.$message.error('图片不能大于 2MB!')
      }
      else {
        console.log("before check")
        getBase64(file, (imageUrl) => {
          this.photoSrc = imageUrl
          console.log('photoSrc',imageUrl )
          // this.activityPhoto.loading = false
        })
      }
      return isJPG && isLt2M
    },
    insertBook(){
      let _this=this;
      console.log("_this.bookDetail", _this.bookDetail);
      reqCreateBook(_this.bookDetail)
        .then(response => {
          console.log(response.result);
          if (response.success) {
           // _this.bookDetail = _this.entityEmptyForm;
            _this.createDrawerVisible = false;
            _this.$emit('refreshBook');
          } else {
            console.log("success: false");
            console.log(response.error);
          }
        })
        .catch(function(error) {
          console.info("reqCreateOrUpdateParty catch", error);
          _this.$message.error(error.error.message);
        })
        .finally(response => {
          console.log("over", response);
        });
    },
    updateBook() {
      let _this = this;
      console.log("_this.bookDetail", _this.bookDetail);
      reqUpdateBook(_this.bookDetail)
        .then(response => {
          if (response.success) {
           // _this.bookDetail = _this.entityEmptyForm;
            console.log("--- refreshBook");
            _this.createDrawerVisible = false;
            _this.$emit('refreshBook');
          } else {
            console.log("success: false");
            console.log(response.error);
          }
        })
        .catch(function(error) {
          console.info("reqCreateOrUpdateParty catch", error);
          _this.$message.error(error.error.message);
        })
        .finally(response => {
          console.log("over", response);
        });
      // this.createDrawerVisible = false;
      // // this.$emit('refreshBook')
      // Bus.$emit('refreshBook','logoutPage')
    },

    //#endregion
    permissionInit() {
      if (
        this.$store.state.bookPermission.indexOf(
          this.Permission.Book_Create_Default
        ) > -1
      ) {
        this.bookCreatePermission = true;
      }
      if (
        this.$store.state.bookPermission.indexOf(
          this.Permission.Book_Update_Default
        ) > -1
      ) {
        this.bookUpdatePermission = true;
      }
      if (
        this.$store.state.bookPermission.indexOf(
          this.Permission.Book_Get_Default
        ) > -1
      ) {
        this.bookDetailPermission = true;
      }
    },
  },
  mounted() {
    let _this=this;
   // console.log("mounted props.......",this.showType )
    if(typeof(_this._props.bookData)!= 'undefined')
    {
      this.bookDetail = {..._this._props.bookData};
      //console.log("mounted props.......",this.bookDetail,this.showType )
    }
    if(this.showType=='button')
    {
      this.bookCreateShow= true;
    }
    else if(this.showType=='icon')
    {
     this.bookIconShow=true;
    }
    else if(this.showType=='name')
    {
      this.bookNameShow=true;
    }
    this.permissionInit();
  },
  watch:{
    bookData(newData,prevData){
      // console.log(newData,123654789)
      this.bookDetail = {...newData};
    }
  }
};
</script>
<style scoped>
  .delete-style{
    color: lightgrey;
  }
  .avatar-uploader {
    width: 158px;
    height: 128px;
  }
  .icon-style {
    height: 30px;
    width: 30px;
    font-size: 18px;
    cursor: pointer;
  }
  .image-size {
    width: 90px;
    height: 110px;
    cursor: pointer;
  }
</style>
