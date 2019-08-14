<template>
  <div class="activity-detail">
    <div class="div-margin">
      <div class="div-margin">
        <label class="lable">事项</label>
        <a-input placeholder="" class="input"/>
      </div>
      <div class="div-margin">
        <label class="lable">类型</label>
        <a-select class="subinput" defaultValue="请选择"  @change="handleOperation" >
          <a-select-option value="0">支出</a-select-option>
          <a-select-option value="1">入账</a-select-option>
        </a-select>
        <label class="lable">金额</label>
        <a-input placeholder=""  class="subinput"/>
      </div>
      <div class="div-margin">
        <label class="lable">备注</label>
        <a-textarea class="input" placeholder="请输入备注" :autosize="{ minRows: 6, maxRows: 8 }" />
      </div>
    </div>
    <!--<div >-->
      <!--<a-button type="primary" style="float: right">保存</a-button>-->
    <!--</div>-->
  </div>

</template>

<script>
  const CollectionCreateForm = {
    props: ['visible'],
    beforeCreate () {
      this.form = this.$form.createForm(this);
    },
    template: `
    <a-modal
      :visible="visible"
      title='Create a new collection'
      okText='Create'
      @cancel="() => { $emit('cancel') }"
      @ok="() => { $emit('create') }"
    >
      <a-form layout='vertical' :form="form">
        <a-form-item label='Title'>
          <a-input
            v-decorator="[
              'title',
              {
                rules: [{ required: true, message: 'Please input the title of collection!' }],
              }
            ]"
          />
        </a-form-item>
        <a-form-item label='Description'>
          <a-input
            type='textarea'
            v-decorator="['description']"
          />
        </a-form-item>
        <a-form-item class='collection-create-form_last-form-item'>
          <a-radio-group
            v-decorator="[
              'modifier',
              {
                initialValue: 'private',
              }
            ]"
          >
              <a-radio value='public'>Public</a-radio>
              <a-radio value='private'>Private</a-radio>
            </a-radio-group>
        </a-form-item>
      </a-form>
    </a-modal>
  `,
  };

  export default {
    name: "ActivityDetail",
    data () {
      return {
        itemName:'',
        operateMoney:0,
        description:'',
        checkNick: false,
        form: this.$form.createForm(this),
      };
    },
    methods: {
      operateType: {
        get: function(){
          if(this.operateMoney<0)
          {
            return "入账";
          }
          else
            return "支出";
        },
        set:function(newValue){}
      },
      Money(){
        return math.abs(operateMoney);
      },
      check  () {
        this.form.validateFields(
          (err) => {
            if (!err) {
              console.info('success');
            }
          },
        );
      },
      handleChange  (e) {
        this.checkNick = e.target.checked;
        this.$nextTick(() => {
          this.form.validateFields(['nickname'], { force: true });
        });
      },
    },
  };
</script>

<style scoped>
.activity-detail
{
  width: 590px;
  height: 460px;
  background: lightgray;
}
.div-margin{
  margin: 10px;
  float: left;
}
  .input{
    width: 300px;
    float: left;
    float: left;
  }
.lable{
  width: 110px;
  margin-right: 10px;
  text-align: right;
  float: left;
}
.subinput{
  width: 150px;
  float: left;
}
</style>
