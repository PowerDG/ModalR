<template>
  <div class="box">
    <a-modal :visible="visible"
             @cancel="onClose"
          :footer="null">
        <img alt="example" :src="photoSrc"  style="width: 100%;height: 100%" />
    </a-modal>
    <a-modal
      title="新增活动图片"
      :visible="uploadModalVisible"
      :destroyOnClose="destroyOnClose"
      @cancel="()=>{this.uploadModalVisible=false}"
      @ok="() => handleUpload()">
      <a-form :form="form">
        <a-form-item label='图片'>
        <a-upload
          name="avatar"
          listType="picture-card"
          class="avatar-uploader"
          :showUploadList="false"
          :beforeUpload="beforeUpload"
          v-decorator="[ '图片',{ rules: [{ required: true, message: '请选择图片!' }], } ]"
        >
          <img class="image-size" v-if="photoSrc" :src="photoSrc" alt="avatar" />
          <div v-else>
            <a-icon :type="loading ? 'loading' : 'plus'" />
            <div class="ant-upload-text">添加图片</div>
          </div>
        </a-upload>
        </a-form-item>
        <a-form-item label='描述'>
          <a-input v-decorator="[ '描述',{ rules: [{ required: true, message: '请输入描述!' },
           {max: 60, message: '描述不能超过60个字符!'}]}]"
                   v-model="description"
          ></a-input>
        </a-form-item>
      </a-form>
    </a-modal>
    <div v-for="photo in activityPhotos" class="div-card" >
      <div>
        <img  class="image-size"
              alt="example"
              :src="photo.urlPart"
              slot="cover"
              @click="showOrigin(photo.url)"/>
        <div style='width:120px;white-space:nowrap;text-overflow:ellipsis;overflow:hidden;margin-top: 5px' :title='photo.description'>{{photo.description}}</div>
      </div>
    </div>
    <div  v-if="activityPhotos.length < 3&& partyPhotoCreate"  class="div-card">
      <div style="width:100px;height:100px;border:solid 1px gray;cursor: pointer;text-align: center;margin: auto" @click="showPhotoModal">
        <a-icon style="font-size: 40px" type="plus" />
        <div >上传图片</div>
      </div>
    </div>
  </div>
</template>
<script>
  import {
    reqUploadImage,
    reqInsertPartyImg
  } from "../../request/api";

  function getBase64 (img, callback) {
    const reader = new FileReader()
    reader.addEventListener('load', () => callback(reader.result))
    reader.readAsDataURL(img)
  }
  export default {
    props:['activityPhotos','partyId'],
    data () {
      return {
        partyPhotoCreate:false,
        destroyOnClose:true,
        form: this.$form.createForm(this),
        sendOnce:false,
        visible:false,
        uploadModalVisible:false,
        activityPhoto:{
          PartyId:0
          ,url:''
          ,urlPart:''
          ,description:''
        },
        loading:false,
        photoSrc:'',
        description:'',
      }
    },
    methods: {
      showOrigin(src){
        this.visible=true;
        this.photoSrc=src;
      },
      showPhotoModal(){
        this.uploadModalVisible=true;
        this.sendOnce=false;
        this.description='';
        this.photoSrc='';
      },
      onClose(e) {
        this.visible = false
      },
      handleUpload() {
        let _this=this;
        this.form.validateFields((err, values) => {
          if (!err) {
            if(_this.sendOnce)
            {
              return ;
            }
            _this.sendOnce=true;
            var image={}
            image.NeedThumb=true;
            image.Base64String=this.photoSrc;
            console.log("handleupload",image)
            reqUploadImage(image)
              .then((response)=>{
                console.log("image result: ",response);
                if(response.success)
                {
                  var partyPhoto={}
                  console.log("this.partyId ",_this.partyId);
                  partyPhoto.partyId=_this.partyId
                  partyPhoto.Url=response.originalUrl
                  partyPhoto.UrlPart=response.thumbUrl
                  partyPhoto.Description=_this.description
                  _this.insertPartyImg(partyPhoto)
                }
              })
              .catch(function(error){
                console.info(error);
                _this.sendOnce=false;
              });
          }
        });
       },
      insertPartyImg(partyPhoto)
      {
        console.log("image record ",partyPhoto);
        let that=this;
        reqInsertPartyImg(partyPhoto)
          .then((response)=>{
            console.log("insert respose ",response);
            if( response.success)
            {
              this.uploadModalVisible=false;
              this.$emit('refreshPhoto')
            }
            else {
              console.log(response.result.error)
            }
          })
          .catch(function(error){
            console.info(error);
            that.sendOnce=false;
          });

      },
      handleChange (info) {
        console.log('handleChange ',info);
        getBase64(info.file.originFileObj, (imageUrl) => {
                this.photoSrc = imageUrl
                console.log('photoSrc',imageUrl )
               // this.activityPhoto.loading = false
              })
      },
      beforeUpload (file) {
        console.log(file)
        console.log(file.type)
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
      permissionInit(){
        if(this.$store.state.partyPermission.indexOf(this.Permission.Party_Photo_Default)>-1)
        {
          this.partyPhotoCreate=true;
        }
      }
    },
    created(){
      console.log('PartyPhotot created ');
      this.permissionInit();
    },
  }
</script>
<style scoped>
  /* you can make up upload button and sample style by using stylesheets */
  .ant-upload-select-picture-card i {
    font-size: 32px;
    color: #999;
  }
  .image-size{
    width: 150px;
    height: 150px;
    cursor:pointer;
  }
  .avatar-uploader > .ant-upload {
    width: 128px;
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

  .ant-upload-select-picture-card .ant-upload-text {
    margin-top: 8px;
    color: #666;
  }
  .box{
    display: flex;
    flex-direction: row;
    flex-wrap: wrap;
    justify-content: center ;
    align-content:center;
    vertical-align: middle;
  }
  .div-card  {
    flex-wrap: wrap;
    display: flex;
    align-content:center;
    vertical-align: middle;
    margin-right: 50px;
  }
</style>
