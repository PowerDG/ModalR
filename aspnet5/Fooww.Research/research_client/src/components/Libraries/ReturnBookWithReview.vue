<template>
  <div>


        <a-icon
                    class="icon-style"
                    type="export"
                    title="归还"
                    @click="()=>onReturn(111)"
                  />

                    v-if="canReturn(item.lastModifierUserId)"
    <!-- <a-icon class="icon-style" type="book" title="借阅" /> -->

    <a-modal title="图书归还 添加书评" 
    
        :visible="createDrawerVisible"
    v-model="visible" 
    @ok="handleOk" @cancel="handleCancel">
      <a-form layout="vertical" :form="returnForm">
        <a-form-item label="评分">
          <span>
            <a-icon type="smile" />
            <a-rate
              :disabled="!partyRate"
              v-model="item.likeLevel"
              @change="() => addPartyRate(item.id,item.likeLevel)"
            />
            <span class="ant-rate-text">{{item.likeLevel.toFixed(0)}} 星</span>
            <span>{{item.likeCount}} 次打分</span>
          </span>
        </a-form-item>
        <!-- <a-form-item label='金额'>
            <a-input
              v-decorator="['金额',{
                  rules: [{
                    required: true,
                    whitespace: true,
                    type:'number',
                    transform(value) {
                      if(value>0){
                        return Number(value);
                      }
                    },
                    message: '请输入正确金额' },
                    {
                       validator: validateOperateMoney,
                    }],
              }]"
              v-model="operateMoneyShow" ></a-input>
        </a-form-item>-->


        
        <a-form-item label="书评">
          <a-input
            v-decorator="[ 'review',{ rules: [{ required: true, message: '请输备注!' },
                         {max: 250, message: '书评不能超过250个字符!'}
                        ], } ]"
            type="textarea"
            v-model="fundRecord.review"
          ></a-input>
        </a-form-item>
      </a-form>
    </a-modal>
  </div>
</template>

<script>
import { reqBookLoss } from "@/request/api";

export default {
  name: "BookLost",
  props: { formVisible: Boolean, bookId: Number },
  data() {
    return {

        
      createDrawerVisible: false,
      //form: this.$form.createForm(this),
      visible: this.formVisible,
      showStatus: true,
      showStatus2: this.formVisible
    };
  },
  computed: {
    // visible(){
    //   return showStatus2&&showStatus;
    // }
  },
  method: {

          onReturn(bookId) {
              
      this.createDrawerVisible = true;
      console.log("onReturn bookId", bookId);
    },
    handleOk() {
      console.log("lost book id ", this.bookId);
      let _this = this;
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
    handleCancel() {
      console.log(
        "lost book id ",
        typeof this.visible,
        typeof this.this.visible
      );
      this.showStatus = false;
      console.log("lost book id ", this.visible);
    }
  }
};
</script>

<style scoped>
</style>
