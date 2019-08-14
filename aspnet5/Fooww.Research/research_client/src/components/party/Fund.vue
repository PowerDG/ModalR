<template>
<div>
  <div>
    <div style="text-align: left;height: 70px">
      <a-radio-group class="fund-option"  defaultValue="all" buttonStyle="solid"  @change="fundscope" :value="queryType">
        <a-radio-button class="radio-button"  value="all">所有数据</a-radio-button>
        <a-radio-button  class="radio-button"  value="CurrentYear">今年数据</a-radio-button>
      </a-radio-group>
      <div style="float: right">
        <a-button class="fund-create" type="primary" @click="createFund" v-if="fundCreate">新增事项</a-button>
      <a-modal
        :visible="visible"
        :title="formTitle"
        :destroyOnClose=true
        @cancel="() => {this.visible=false }"
        @ok="() => submit()"
      >
        <a-form layout='vertical' :form="fundForm">
          <a-form-item label='事项'>
            <a-input v-decorator="[ '事项',{ rules: [{ required: true, message: '请输入事项标题!' },
                    {max: 60, message: '事项不能超过60个字符!'}], } ]"
                     v-model="fundRecord.ItemName"
            ></a-input>
          </a-form-item>
          <a-form-item class='collection-create-form_last-form-item' label="类型">
            <a-radio-group v-model="operateType"
                           v-decorator="[ 'operateType',{ rules: [{ required: true, message: '请选择类型!' }], } ]"
                           @change="operateTypeChange" >
              <a-radio value='expend'>支出</a-radio>
              <a-radio value='income'>入账</a-radio>
            </a-radio-group>
          </a-form-item>
          <a-form-item label='金额'>
            <a-input
              v-decorator="['金额',{               rules: [{
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
          </a-form-item>
          <a-form-item label='备注'>
            <a-input v-decorator="[ '备注',{ rules: [{ required: true, message: '请输备注!' },
                         {max: 250, message: '备注不能超过250个字符!'}
                        ], } ]"
                     type='textarea'  v-model="fundRecord.Description"
            ></a-input>
          </a-form-item>
        </a-form>
      </a-modal>
      <span  class="fund-create" >当前可用经费：<span v-bind:style="{'color': color }"><span v-show="remain>0"></span>{{remain}}</span>元</span>
      </div>
    </div>
  </div>

  <div>
    <a-table :columns="columns" :dataSource="fundData" :pagination="pagination" bordered >
       <!--<span slot="index"  slot-scope="index" >-->
      <span slot="operateMoney"  slot-scope="operateMoney" :class="{'red':operateMoney<0,'green':operateMoney>=0}" >
        <span v-show="operateMoney>0">+</span>{{operateMoney}}</span>
      <span slot="remainMoney"  slot-scope="remainMoney" :class="{'red':remainMoney<0,'green':remainMoney>=0}" >
        <span v-show="remainMoney>0">+</span>{{remainMoney}}</span>
      <template slot="insertTime" slot-scope="insertTime">
        {{insertTime | dateFilter}}
      </template>
      <template v-for="col in [ 'itemName','description']" :slot="col" slot-scope="text, record, index">
        <div :key="col">
          <a-input
            v-if="record.editable"
            style="margin: -5px 0"
            :value="text"
            @change="e => handleChange(e.target.value, record.id, col)"
          />
          <template v-else>{{text}}</template>
        </div>
      </template>
      <template slot="operation" slot-scope="text, record, index">
        <div class='editable-row-operations'  v-if="fundChange">
          <span v-if="record.editable">
          <!--<a @click="() => save(record.key)">Save</a>-->
          <a-icon class="icon-point-style" type="save" @click="() => save(record.id)" title="保存"/>
          <a-popconfirm title='确定要放弃修改?' @confirm="() => cancel(record.id)">
            <!--<a>Cancel</a>-->
            <a-icon class="icon-point-style" type="undo" title="取消"/>
          </a-popconfirm>
        </span>
          <span v-else>
            <a-popconfirm title="确定要删除这条记录?" @confirm="() => onDelete(record.id)">
              <a-icon class="icon-point-style" type="delete"  title="删除"/>
            </a-popconfirm>
            <!--<a @click="() => edit(record.key)">Edit</a>-->
            <a-icon class="icon-point-style" type="edit" @click="() => edit(record.id)" title="编辑"/>
        </span>
        </div>
      </template>
    </a-table>
  </div>
</div>
</template>
<script>

import {
  reqCreateFund,
  reqRemainMoney,
  reqTotalFunds,
  reqUpdateFund,
  reqDeleteFund,
} from "../../request/api";

  const columnsAdmin = [
  {
    title: '编号',
    dataIndex: 'order',
    width: '5%',
    key:'order',
    scopedSlots: { customRender: 'order' },
  },
  {
    title: '入账日期',
    dataIndex: 'insertTime',
    width: '15%',
    scopedSlots: { customRender: 'insertTime' },
  },
  {
    title: '事项',
    dataIndex: 'itemName',
    width: '25%',
    scopedSlots: { customRender: 'itemName' },
  },
  {
    title: '金额',
    dataIndex: 'operateMoney',
    width: '5%',
    scopedSlots: { customRender: 'operateMoney' },
  },
  {
    title: '余额',
    dataIndex: 'remainMoney',
    width: '5%',
    scopedSlots: { customRender: 'remainMoney' },
  },
  {
    title: '操作人',
    dataIndex: 'memberName',
    width: '10%',
    scopedSlots: { customRender: 'memberName' },
  },
  {
    title: '备注',
    dataIndex: 'description',
    width: '25%',
    scopedSlots: { customRender: 'description' },
  },
    {
      title: '操作',
      dataIndex: 'operation',
      scopedSlots: { customRender: 'operation' },
      width: '10%',
    }
]
  const columnsHero=[
    {
      title: '编号',
      dataIndex: 'order',
      width: '5%',
      key:'order',
      scopedSlots: { customRender: 'order' },
    },
    {
      title: '入账日期',
      dataIndex: 'insertTime',
      width: '15%',
      scopedSlots: { customRender: 'insertTime' },
    },
    {
      title: '事项',
      dataIndex: 'itemName',
      width: '25%',
      scopedSlots: { customRender: 'itemName' },
    },
    {
      title: '金额',
      dataIndex: 'operateMoney',
      width: '5%',
      scopedSlots: { customRender: 'operateMoney' },
    },
    {
      title: '余额',
      dataIndex: 'remainMoney',
      width: '5%',
      scopedSlots: { customRender: 'remainMoney' },
    },
    {
      title: '操作人',
      dataIndex: 'memberName',
      width: '10%',
      scopedSlots: { customRender: 'memberName' },
    },
    {
      title: '备注',
      dataIndex: 'description',
      width: '25%',
      scopedSlots: { customRender: 'description' },
    }
  ]
  export default {
      name: "fund",
      data(){
        // this.cacheData = this.fundData.map(item => ({ ...item }))
        return {
            fundCreate:false,
            fundUpdate:false,
            fundDelete:false,
            fundForm:this.$form.createForm(this),
            visible: false,
            operateType:'',
            fundRecord:{
              InsertTime :new Date(),
              ItemName :'',
              OperateMoney:0,
              Description:''
            },
            formTitle:"添加事项",
            queryType:'all',
            columns:[],
            current:1,
            fundData:[],
            cacheData:[],
            remain: 0,
            pagination:{
              pageSizeOptions: ['10', '20', '30', '40', '50'],
              defaultCurrent:1,
              current: this.pageCurrent,
              showSizeChanger:true,
              pageSize:10,
              total: 0,
              showQuickJumper:true,
              onChange:(page,pageSize)=>this.changePage(page,pageSize),
              showTotal:(total)=>"共 "+total+" 条",
              onShowSizeChange: (current,pageSize)=>this.onShowSizeChange(current,pageSize),
            }
          }
        },
      computed: {
        color: function () {
          return this.remain < 0 ? 'red' : 'green';
        },
        operateMoneyShow: {
          get: function () {
            if (this.fundRecord.OperateMoney < 0) {
              return 0 - this.fundRecord.OperateMoney;
            } else {
              return this.fundRecord.OperateMoney;
            }
          },
          //setter
          set: function (money) {
            console.log('set money', money)
            if(!isNaN(money))
            {
              if (this.operateType === 'expend') {
                this.fundRecord.OperateMoney = -money;
              } else {
                this.fundRecord.OperateMoney = money;
              }
              console.log("money changed ", this.fundRecord.OperateMoney)
            }
          }
        },
        pageCurrent(){ return this.current},
        fundChange(){
          return this.fundUpdate&this.fundDelete;
        }
      },
      methods: {
        validateOperateMoney  (rule, value, callback) {
          const form = this.fundForm;
          if (value<-1000000.00|| value>+1000000.00) {
            callback('金额超出范围（-1000000.00，1000000.00）!');
          } else {
            callback();
          }
        },
        success (msg) {
          this.$message.success(msg);
        },
        error (msg) {
          this.$message.error(msg);
        },
        fundscope(e){
          console.log(e.target.value)
          if(e.target.value==='CurrentYear')
          {
           this.queryType="CurrentYear";
          }
          else {
            this.queryType='all'
          }
          this.getData(this.current, this.pagination.pageSize);
          console.log('QueryType',this.queryType);
        },
        createFund(){
          this.fundRecord.InsertTime = new Date();
          this.fundRecord.ItemName='';
          this.fundRecord.OperateMoney=0;
          this.fundRecord.Description='';
          this.formTitle='添加事项';
          this.visible = true;
          console.log(this.visible)
        },
        operateTypeChange(e)
        {
            console.log('operatetypechanged',e.target.value);
            this.operateType= e.target.value;
          if (this.operateType == 'expend') {
            if (this.fundRecord.OperateMoney > 0) {
              this.fundRecord.OperateMoney = -this.fundRecord.OperateMoney;
            }
          }
          else {
            if (this.fundRecord.OperateMoney < 0) {
              this.fundRecord.OperateMoney = -this.fundRecord.OperateMoney;
            }
          }
          console.log('operatetypechanged money', this.fundRecord.OperateMoney);
        },
        submit(){
          // this.$axios.post("PartyService.Host/Fund/CreateFund",this.fundRecord)
          let _this=this;
          this.fundForm.validateFields((err, values) => {
            if (!err) {
              reqCreateFund(this.fundRecord)
                .then((response)=>{
                  console.log('success',response);
                  if( response.success)
                  {
                    this.visible = false;
                    _this.success("添加成功");
                    if(this.current==1)
                    {
                      _this.getData(this.current,this.pagination.pageSize);
                    }
                    _this.getRemainMoney();
                  }
                  else {
                    console.log(response.result.error)
                  }
                })
                .catch(function(error){
                  console.info('submit cache',error);
                  _this.error("添加失败");
                })
                .finally((response)=>{
                  console.info('submit f',response);
                });
            }
          });
        },
        getRemainMoney(){
          // this.$axios.get("PartyService.Host/Fund/GetRemainMoney")
          reqRemainMoney("")
            .then((response)=>{

             console.log("--",response)
              this.remain =response.result;
             console.log('remain',response )
            })
            .catch(function(error){
              console.info(error);
            });
        },
        getData(page,pageSize){
          // this.$axios.get("PartyService.Host/Fund/GetTotalFunds",
          reqTotalFunds({
              MaxResultCount:pageSize,
              SkipCount:pageSize*(page-1),
              QueryType:this.queryType,
            })
            .then((response)=>{
             console.log("--",response)
              var items = response.result.items;
              for (let i = 0; i < items.length; i++) {
                items[i].order=pageSize*(page-1)+i+1;
              }
              this.fundData= items;
              this.pagination.total=response.result.totalCount;
            })
            .catch(function(error){
              console.info(error);
            });
        },
        changePage(page,pageSize){
          console.log('page: ', page);
          console.log('pageSize: ', pageSize);
          this.current= page;
          this.pagination.current=page;
          this.pagination.pageSize=pageSize
          this.getData(this.current, this.pagination.pageSize);
        },
        onShowSizeChange(current, pageSize) {
          this.pagination.pageSize = pageSize;
        //  this.current=current;
          console.log('onShowSizeChange: ', current, pageSize);
          this.getData(this.current, this.pagination.pageSize);
        },
        onChange(pageNumber){
          console.log('current: ', pageNumber.current);
          this.pagination.current= pageNumber.current;
          console.log('pagezie: ', this.pagination.pageSize);
          console.log('skip: ', this.pagination.pageSize*(this.pagination.current-1));
        },
        handleChange(value, key, column) {
          console.log("handleChange",value)
          console.log("handleChange",key)
          console.log("handleChange",column)
          const newData = [...this.fundData]
          const target = newData.filter(item => key === item.id)[0]
          if (target) {
            target[column] = value
            this.data = newData
          }
        },
        edit(key) {
          const newData = [...this.fundData];
          console.log("edit", newData);
          const target = newData.filter(item => key === item.id)[0]
          console.info("edit key",key)
          console.info("target",target)
           if (target) {
             target.editable = true
             this.fundData = newData
             this.cacheData = this.fundData.map(item => ({ ...item }))
           }
        },
        save(key) {
          console.log("save key",key)
          const newData = [...this.fundData]
          const target = newData.filter(item => key === item.id)[0]
          if (target) {
            delete target.editable
            this.fundData = newData
           //to do save to server
            var editRecord={}
            editRecord.Id=target.id;
            editRecord.ItemName=target.itemName;
            editRecord.Description=target.description;
            console.log("save record",editRecord)
            let _this=this;
            // this.$axios.post("PartyService.Host/Fund/UpdateFund",editRecord)
            reqUpdateFund(editRecord)
              .then((response)=>{
                console.log(response);
                if( response.success)
                {

                  this.success("修改成功");
                }
                else {
                  console.log(response.result.error)
                }
              })
              .catch(function(error){
                console.info('edit save catch ',error);
                _this.error("修改失败");
              })
              .finally((response)=>{
                this.getData(this.current,this.pagination.pageSize);
              });
          }
        },
        cancel(key) {
          console.log("cancel key",key)
           const newData = [...this.fundData]
           const target = newData.filter(item => key === item.id)[0]
          if (target) {
            Object.assign(target, this.cacheData.filter(item => key === item.id)[0])
            delete target.editable
            this.fundData = newData
          }
        },
        onDelete(key) {
          var record = this.fundData.filter(item => item.id == key)
          let _this=this;
          reqDeleteFund(
          {params:{
              fundId:key
            }})
            .then((response)=>{
              console.log(response);
              if( response.success)
              {
                this.getData(this.current,this.pagination.pageSize);
                this.getRemainMoney();
                this.success("删除成功");
              }
              else {
                console.log(response.result.error)
              }
            })
            .catch(function(error){
              console.info(error);
              _this.error("删除失败");
            })
            .finally((response)=>{
              console.info(response);
            });
          // this.getData(this.current, this.pagination.pageSize);

        },
        initPermission()
        {
          if(this.$store.state.partyPermission.indexOf(this.Permission.Fund_Create_Default)>-1)
          {
            this.fundCreate=true;
          }
          if(this.$store.state.partyPermission.indexOf(this.Permission.Fund_Update_Default)>-1)
          {
            this.fundUpdate=true;
            console.log('fundUpdate',this.fundUpdate)
          }
          if(this.$store.state.partyPermission.indexOf(this.Permission.Fund_Delete_Default)>-1)
          {
            this.fundDelete=true;
            console.log('fundDelete',this.fundDelete)
          }
          console.log('operation',this.fundChange)
          if(this.fundChange){
            this.columns= columnsAdmin;
          }
          else {
            this.columns= columnsHero;
          }
        }
      },
      mounted() {
        console.log("Fund mounted");
        this.initPermission();
        this.getRemainMoney();
        this.getData(this.current,this.pagination.pageSize);
      }
    }
</script>

<style scoped>
  .editable-row-operations a {
    margin-right: 8px;
  }

  .fund-option
  {
    margin-top: 15px;
  }
  .radio-button {
    margin-right: 10px;
  }
  .fund-create
  {
    margin:10px;
    float: right
  }
  .red{
    color: red;
  }
  .green{
    color: green;
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
  .icon-point-style
  {
    cursor:pointer;
  }
</style>
