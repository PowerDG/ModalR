<template>
  <div>
    <a-modal
      title="书籍丢失处理"
      v-model="visible"
      @ok="handleOk"
      @cancel="handleCancel"
    >
      <a-form layout='vertical' :form="form">
        <a-form-item label='原因'>
          <a-input v-decorator="[ 'reason',{ rules: [{ required: true, message: '请输入原因!' },
                         {max: 250, message: '内容不能超过250个字符!'}
                        ], } ]"
                   type='textarea'
          ></a-input>
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script>
    import {reqBookLoss} from "@/request/api";

    export default {
      name: "BookLost",
      props:  ['formVisible','bookId'],//{ formVisible:Boolean, bookId:Number},
      data(){
        return{
          form: this.$form.createForm(this),
          visible:this.formVisible,
          showStatus:true,
          showStatus2:this.formVisible,
        }
      },
      computed:{
        // visible(){
        //   return showStatus2&&showStatus;
        // }
      },
      method:{
        handleOk(){
          console.log('lost book id ', this.bookId);
          let _this=this;
          // this.fundForm.validateFields((err, values) => {
          //   if (!err) {
          //     reqBookLoss({id:this.bookId})
          //       .then((response)=>{
          //         console.log('success',response);
          //         _this.$message.success("添加成功");
          //       })
          //       .catch(function(error){
          //         console.info('handleOk  error',error);
          //         _this.$message.error("添加失败");
          //       })
          //       .finally((response)=>{
          //         console.info('submit f',response);
          //       });
          //     _this.formVisible=false;
          //   }
          // });
        },
        handleCancel(){
          console.log('lost book id ', typeof(this.visible), typeof (this.this.visible));
           this.showStatus=false;
          console.log('lost book id ', this.visible);
        }
      }
    }
</script>

<style scoped>

</style>
