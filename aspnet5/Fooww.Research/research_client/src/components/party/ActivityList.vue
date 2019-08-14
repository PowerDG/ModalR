<template>
  <div>
    <div class="search-pages">
      <div class="party-option">
        <a-radio-group
          class="party-option"
          id="filter"
          defaultValue="all"
          buttonStyle="solid"
          @change="activityFilter"
        >
          <a-radio-button value="all">所有活动</a-radio-button>
          <a-radio-button value="high">评价最高</a-radio-button>
          <a-radio-button value="most">去的最多</a-radio-button>
        </a-radio-group>
        <a-input-search
          class="party-option"
          placeholder="活动名称或场所关键字"
          style="width: 250px"
          @search="onSearch"
          enterButton="搜索"
        />
        <!-- <a-button type="primary">新增团建</a-button> -->

        <a-button type="primary" @click="showDrawer" v-if="partyCreate">
          <a-icon type="plus" />新增团建
        </a-button>
      </div>
    </div>

    <div>
      <a-drawer
        title="Create a new account"
        :width="720"
        @close="onClose"
        :visible="visible"
        :wrapStyle="{height: 'calc(100% - 108px)',overflow: 'auto',paddingBottom: '108px'}"
      >
        <a-form :form="form" layout="vertical" hideRequiredMark>
          <a-row :gutter="16">
            <a-col :span="12">
              <a-form-item label="名称">
                <a-input
                  v-model="entityDetail.title"
                  v-decorator="['name', {
                  rules: [{ required: true, message: 'Please enter user name' }]
                }]"
                  placeholder="Please enter user name"
                />
              </a-form-item>
            </a-col>

            <!-- v-model="entityDetail.tel" -->
            <a-col :span="6">
              <a-form-item label="花费">
                <a-input
                  v-decorator="['cost', {
                  rules: [{ required: true, message: 'Please enter cost' }]
                }]"
                  placeholder="Please enter cost"
                />
              </a-form-item>
            </a-col>
            <a-col :span="6">
              <a-form-item label="人数">
                <a-input
                  v-model="entityDetail.number"
                  v-decorator="['number', {
                  rules: [{ required: true, message: 'Please enter user name' }]
                }]"
                  placeholder="Please enter user name"
                />
              </a-form-item>
            </a-col>
          </a-row>

          <a-row :gutter="16">
            <a-col :span="12">
              <a-form-item label="开始时间 ">
                <a-date-picker
                  v-model="entityDetail.startTime"
                  v-decorator="['StartTime ', {
                  rules: [{ required: true, message: 'Please choose the StartTime' }]
                }]"
                  style="width: 100%"
                  :getPopupContainer="trigger => trigger.parentNode"
                />
              </a-form-item>
            </a-col>

            <a-col :span="12">
              <a-form-item label="结束时间">
                <a-date-picker
                  v-model="entityDetail.endTime"
                  v-decorator="['EndTime ', {
                  rules: [{ required: true, message: 'Please choose the EndTime ' }]
                }]"
                  style="width: 100%"
                  :getPopupContainer="trigger => trigger.parentNode"
                />
              </a-form-item>
            </a-col>
          </a-row>
          <a-row :gutter="16">
            <a-col :span="18">
              <a-form-item label="活动场所">
                <a-input
                  v-model="entityDetail.place"
                  v-decorator="['place', {
                  rules: [{ required: true, message: 'Please enter user name' }]
                }]"
                  placeholder="Please enter user name"
                />
              </a-form-item>
            </a-col>
            <a-col :span="6">
              <a-form-item label="来源">
                <a-select
                  v-model="entityDetail.source"
                  v-decorator="['type', {
                  rules: [{ required: true, message: 'Please choose the type' }]
                }]"
                  placeholder="Please choose the type"
                >
                  <a-select-option value="1">团队经费</a-select-option>
                  <a-select-option value="2">捐赠</a-select-option>
                  <a-select-option value="3">其他</a-select-option>
                </a-select>
              </a-form-item>
            </a-col>
          </a-row>
          <a-row :gutter="16">
            <a-col :span="12">
              <a-form-item label="地址">
                <a-input
                  v-model="entityDetail.address"
                  v-decorator="['address', {
                  rules: [{ required: true, message: 'Please enter user address' }]
                }]"
                  placeholder="Please enter user address"
                />
              </a-form-item>
            </a-col>
            <a-col :span="12">
              <a-form-item label="电话">
                <a-input
                  v-model="entityDetail.tel"
                  v-decorator="['tel', {
                  rules: [{ required: true, message: 'Please enter user name' }]
                }]"
                  placeholder="Please enter user name"
                />
              </a-form-item>
            </a-col>
          </a-row>

          <a-row :gutter="16">
            <a-col :span="24">
              <a-form-item label="Description">
                <a-textarea
                  v-decorator="['description', {
                  rules: [{ required: true, message: 'Please enter url description' }]
                }]"
                  :rows="4"
                  placeholder="please enter url description"
                />
              </a-form-item>
            </a-col>
          </a-row>
        </a-form>
        <div
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
          <a-button :style="{marginRight: '8px'}" @click="onClose">Cancel</a-button>
          <a-button @click="onCreateParty" type="primary">Submit</a-button>
        </div>
      </a-drawer>
    </div>

    <div>
      <a-list
        size="large"
        :split="true"
        :grid="{ gutter: 16, xs: 1, sm: 1, md: 2, lg: 2, xl: 1, xxl: 1 }"
        :pagination="pagination"
        :dataSource="entitylistData"
        :itemLayout="horizontal"
      >
        <a-list-item key="item.title" slot="renderItem" slot-scope="item, index">
          <div class="listDetail" style="float:left;">
            <div class="list-col"></div>

            <div class="div-css">
              <span>{{item.title}}</span>
              <a-icon class="edit-icon" type="edit" @click="() => edit(id)" tag="编辑" />
              <a-popconfirm title="Sure to delete?" @confirm="() => onDelete(id)">
                <a-icon class="edit-icon" type="delete" tag="删除" />
              </a-popconfirm>
            </div>

            <div class="content">
              <a-icon type="environment" />
              {{item.place}} {{item.address}}
            </div>
            <div class="content">
              <a-icon type="money-collect" />
              {{(item.number*(1.0)/6).toFixed(2)}}大洋- {{item.number}} /人
            </div>

            <div class="content">
              <a-icon type="phone" />
              {{item.tel}}
            </div>
            <div class="content">{{item.costformat}}</div>
            <div class="content">
              <span>
                <a-icon type="smile" />
                <a-rate v-model="likeLevel" />
                <span class="ant-rate-text">{{item.likeLevel.toFixed(0)}} 星</span>
                <span>{{item.likeCount}} 次打分</span>
              </span>
            </div>
            <div class="content">
              <a-icon type="read" />
              <a-icon class="edit-icon" type="edit" @click="() => addComment(id)" tag="添加评论" />
            </div>

            <div class="list-col"></div>

            <div class="list-col"></div>
            <div class="list-col">{{item.lastBookReview}}</div>
          </div>

          <div>
            <img
              slot="extra"
              width="252"
              alt="logo"
              src="https://gw.alipayobjects.com/zos/rmsportal/mqaQswcyDLcXyDKnZfES.png"
            />
            <img
              slot="extra"
              width="252"
              alt="logo"
              src="https://gw.alipayobjects.com/zos/rmsportal/mqaQswcyDLcXyDKnZfES.png"
            />
            <img
              slot="extra"
              width="252"
              alt="logo"
              src="https://gw.alipayobjects.com/zos/rmsportal/mqaQswcyDLcXyDKnZfES.png"
            />
          </div>
          <a-divider />
        </a-list-item>
      </a-list>
    </div>
  </div>
</template>



<script>
import {
  reqGetBookPaged,
  reqGetPartyPaged,
  reqCreateOrUpdateParty
} from "../../request/api";
import ActivityPhoto from "../party/ActivityShow";
import ActivityShow from "@/components/party/ActivityShow";
import { formatDate } from "../../fiters/common.js";
const listData = [];

const sourceName = ["团队经费", "捐赠", "其他"];

export default {
  data() {
    return {
      partyCreate:false,
      listData,
      form: this.$form.createForm(this),
      visible: false,
      entitylistData: [
        // this.entryTime = formatDate(new Date(this.entryTime), "yyyy-MM-dd hh:mm")
      ],

      formTitle: "添加事项",
      queryType: "all",
      // columns,
      current: 2,
      fundData: [],
      cacheData: [],
      remain: 0,
      pagination: {
        pageSizeOptions: ["2", "3", "10", "20", "30", "40", "50"],
        defaultCurrent: 2,
        current: this.pageCurrent,
        showSizeChanger: true,
        pageSize: 2,
        total: 0,
        showQuickJumper: true,
        onChange: (page, pageSize) => this.changePage(page, pageSize),
        showTotal: total => "共 " + total + " 条",
        onShowSizeChange: (current, pageSize) =>
          this.onShowSizeChange(current, pageSize)
      },
      entityDetail: {
        id: "",
        title: "",
        number: "",

        memberId: 1,
        cost: 2000,
        latitude: 31.071976,
        longitude: 121.406385,
        tel: "13766662376",
        place: "",
        source: 1,
        address: "",
        endTime: "",
        startTime: ""
      },
      // entityOtherDetail: {
      //   memberId,
      //   likeCount,
      //   likeLevel,
      //   partyCommentDtos,
      //   partyPhotoDtos,
      //   order
      // },

      activitylistData: []
    };
  },
  methods: {
    showDrawer() {
      if (1 == 2) {
      } else {
        this.visible = true;
      }
    },
    onClose() {
      this.visible = false;
    },
    onCreateParty() {
      // e.preventDefault();
      this.form.validateFields((err, values) => {
        if (!err) {
          console.log(this.entityDetail);
          console.log("Received values of form: ", values);
          reqCreateOrUpdateParty(this.entityDetail)
            .then(response => {
              console.log(this.entityDetail);
              console.log(response.result);
              console.log("---");
              if (response.success) {
                console.log(response.success);

                this.getData(this.current, this.pagination.pageSize);

                this.visible = false;

                // this.$router.push({ path:'/Party/Fund'  })
              } else {
                console.log("success: false");
                console.log(response.error);
              }
            })
            .catch(function(error) {
              console.info(error);
            })
            .finally(response => {
              console.log("over");
            });
        }
      });
    },

    getData(page, pageSize) {
      reqGetPartyPaged({
        params: {
          MaxResultCount: pageSize,
          SkipCount: pageSize * (page - 1),
          QueryType: this.queryType
        }
      })
        .then(response => {
          console.log("--", page);
          console.log("--", pageSize);
          console.log("--", response);
          var items = response.result.items;
          for (let i = 0; i < items.length; i++) {
            items[i].order = pageSize * (page - 1) + i + 1;
          }

          console.log("in items", items);
          this.entitylistData = items;

          console.log("in entitylistData", this.entitylistData);
          this.pagination.total = response.result.length;
        })
        .catch(function(error) {
          console.info(error);
        });
    },
    activityFilter(e) {
      console.log(e.target.value);
    },
    changePage(page, pageSize) {
      console.log("page: ", page);
      console.log("pageSize: ", pageSize);
      this.current = page;
      this.pagination.current = page;
      this.pagination.pageSize = pageSize;
      this.getData(this.current, this.pagination.pageSize);
    },
    onShowSizeChange(current, pageSize) {
      this.pagination.pageSize = pageSize;
      //  this.current=current;
      console.log("onShowSizeChange: ", current, pageSize);
      this.getData(this.current, this.pagination.pageSize);
    },
    onChange(pageNumber) {
      console.log("current: ", pageNumber.current);
      this.pagination.current = pageNumber.current;
      console.log("pagezie: ", this.pagination.pageSize);
      console.log(
        "skip: ",
        this.pagination.pageSize * (this.pagination.current - 1)
      );
    },
    handleChange(value, key, column) {
      console.log("handleChange", value);
      console.log("handleChange", key);
      console.log("handleChange", column);
      const newData = [...this.entitylistData];
      const target = newData.filter(item => key === item.id)[0];
      if (target) {
        target[column] = value;
        this.data = newData;
      }
    }

  },

  mounted() {
    console.log("in mouont");
    // console.log(" mouont",this.current,this.pagination.pageSize)
    // this.getData(this.current,this.pagination.pageSize);
    if(this.$store.state.partyPermission.indexOf(this.Permission.Party_Create_Default)>-1)
    {
      this.partyCreate=true;
    }

    this.getData(this.current, this.pagination.pageSize);
  }
};
</script>
<style>
.listDetail {
  display: flex;
  flex-direction: column;
  margin: 0 auto;
  width: 350px;
}

.listDetail-text {
  display: flex;
  float: left;
  flex-direction: column;
  margin: 0 auto;
}

.div-css {
  margin: 10px;
  font-size: 20px;
}
.content {
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
.edit-icon {
  height: 25px;
  width: 25px;
  cursor: pointer;
}
</style>
