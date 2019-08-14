<template>
  <div class="party">
    <div>
      <div class="option-div">
        <a-radio-group id="filter" :value="filterType" buttonStyle="solid" @change="activityFilter">
          <a-radio-button class="radio-button" value="all">所有活动</a-radio-button>
          <a-radio-button class="radio-button" value="high">评价最高</a-radio-button>
          <a-radio-button class="radio-button" value="most">去的最多</a-radio-button>
        </a-radio-group>
        <a-input-search
          class="party-option"
          placeholder="活动名称或场所关键字"
          style="width: 250px"
          v-model="filterText"
          @search="onSearch"
          enterButton="搜索"
        />
        <a-button class="float-right" type="primary" @click="showDrawer" v-if="partyCreate">
          <a-icon type="plus" />新增团建
        </a-button>
      </div>
    </div>

    <div>
      <a-modal
        title="添加活动评论"
        :visible="partyCommentEditModalVisible"
        :destroyOnClose="destroyOnClose"
        @cancel="()=>{this.partyCommentEditModalVisible=false}"
        @ok="() => handlePartyComment()"
      >
        <a-form :form="formComments">
          <a-form-item>
            <a-input
              v-decorator="[ '评论',{ rules: [
              {required: true, message: '请输入评论!' },
          {max: 10, message: '评论不能超过10个字符!'}

            ], } ]"
              v-model="partyContent"
            ></a-input>
          </a-form-item>
        </a-form>
      </a-modal>

      <a-modal
        title="查看活动评论"
        :visible="partyCommentReadModalVisible"
        :destroyOnClose="destroyOnClose"
        @cancel="()=>{this.partyCommentReadModalVisible=false}"
        @ok="()=>{this.partyCommentReadModalVisible=false}"
        :cancelButtonProps="{ props: {disabled: true} }"
        :footer="null"
      >
        <a-tag v-for="(comment,index) in this.currentPartyComments" :key="index">{{comment.content}}</a-tag>
      </a-modal>
    </div>

    <div>
      <a-drawer
        title="活动详情"
        :destroyOnClose="destroyOnClose"
        :width="720"
        @close="onClose"
        :visible="visible"
        :wrapStyle="{height: 'calc(100% - 108px)',overflow: 'auto',paddingBottom: '108px'}"
      >
        <a-form :form="detailForm" layout="vertical">
          <a-row :gutter="16">
            <a-col :span="12">
              <a-form-item label="标题">
                <a-input
                  v-model="entityDetailForm.title"
                  v-decorator="['name', {

                  initialValue:entityDetailForm.title,
                  rules: [{ required: true, message: '请输入活动标题' },
                     {max: 60, message: '标题不能超过60个字符!'}]
                }]"
                  placeholder="请输入活动标题"
                />
              </a-form-item>
            </a-col>

            <a-col :span="6">
              <a-form-item label="花费">
                <a-input
                  v-model="entityDetailForm.cost"
                  v-decorator="['cost', {
                  initialValue:entityDetailForm.cost,
                  rules: [{ required: true, message: '请输入花费' },
                   { validator: validateCost,}]
                }]"
                  :disabled="costDisabled"
                  placeholder="请输入花费"
                />
              </a-form-item>
            </a-col>
            <a-col :span="6">
              <a-form-item label="人数">
                <a-input
                  v-model="entityDetailForm.number"
                  v-decorator="['number', {
                  initialValue:entityDetailForm.number,
                  rules: [{ required: true, message: '请输入人数' },
                   { validator: validateNumber,}]
                }]"
                  placeholder="请输入人数"
                />
              </a-form-item>
            </a-col>
          </a-row>

          <a-row :gutter="16">
            <a-col :span="12">
              <a-form-item label="开始时间 ">
                <a-date-picker
                  showTime
                  @ok="onOkStartTime"
                  format="YYYY-MM-DD HH:mm:ss"
                  v-decorator="['StartTime', {
                  initialValue:moment(entityStartTime,dateFormat),
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
                  showTime
                  @ok="onOkEndTime"
                  format="YYYY-MM-DD HH:mm:ss"
                  v-decorator="['EndTime', {
                  initialValue:moment(entityEndTime,dateFormat),
                  rules: [{ required: true, message: 'Please choose the EndTime ' }]
                }]"
                  style="width: 100%"
                  :getPopupContainer="trigger => trigger.parentNode"
                  @openChange="handleEndOpenChange"
                />
              </a-form-item>
            </a-col>
          </a-row>
          <a-row :gutter="16">
            <a-col :span="18">
              <a-form-item label="活动场所 ">
                <a-auto-complete
                  :dataSource="placeNameDictTest"
                  v-decorator="['place', {
                  initialValue:entityDetailForm.place,
                  rules: [{ required: true, message: '请输入活动场所' },
                    {max: 250, message: '不能超过250个字符!'}]
                }]"
                  @blur="blur"
                  @search="handlePlaceChange"
                  @select="onSelectPlace"
                  placeholder="请输入活动场所"
                />
              </a-form-item>
            </a-col>

            <a-col :span="6">
              <a-form-item label="来源">
                <a-select
                  defaultValue="请选择状态"
                  v-model="entityDetailForm.source"
                  v-decorator="['type', {
                  initialValue:entityDetailForm.source,
                  rules: [{ required: true, message: '请选择类型' }]
                }]"
                  placeholder="请选择类型"
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
                  v-decorator="['address', {
                  initialValue:entityDetailForm.address,
                  rules: [{ required: true, message: '请输入地址' },
                  {max: 250, message: '地址不能超过250个字符!'}]
                }]"
                  placeholder="请输入地址"
                />
              </a-form-item>
            </a-col>

            <a-col :span="12">
              <a-form-item label="手机号">
                <a-input
                  v-model="entityDetailForm.tel"
                  v-decorator="['tel', {
                  initialValue:entityDetailForm.tel,
                  rules: [{ required: true, message: '请输入手机号' },
                    {max: 22, message: '号码不能超过22个字符!'}]
                }]"
                  placeholder="请输入手机号"
                />
              </a-form-item>
            </a-col>
          </a-row>
          <a-row :gutter="16" style="height:350px">
            <a-col :span="24">
              <div class="amap-page-con1tainer" style="height:330px">
                <!-- <div class="toolbar">position: [{{ lng }}, {{ lat }}] address: {{ address }}</div> -->
                <el-amap
                  ref="map"
                  vid="amapDemo"
                  :center="center"
                  :zoom="zoom"
                  :events="events"
                  :plugin="plugin"
                  class="amap-demo"
                >
                  <el-amap-marker vid="marker" :position="center"></el-amap-marker>
                  <el-amap-circle
                    vid="circle"
                    :center="center"
                    fill-opacity="0.2"
                    strokeColor="#38f"
                    strokeOpacity="0.8"
                    strokeWeight="1"
                    fillColor="#38f"
                  ></el-amap-circle>
                </el-amap>
                <div class="toolbar">
                  <button @click="getMap()">get map</button>
                </div>
              </div>
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
          <a-button :style="{marginRight: '8px'}" @click="onClose">取消</a-button>
          <a-button @click="onCreateParty" type="primary">提交</a-button>
        </div>
      </a-drawer>
    </div>

    <div>
      <a-list
        size="large"
        :split="true"
        :grid="{ gutter: 16, xs: 1, sm: 1, md: 2, lg: 2, xl: 1, xxl: 1 }"
        :pagination="pagination"
        itemLayout="vertical"
        :dataSource="entitylistData"
      >
        <a-list-item
          key="item.title"
          slot="renderItem"
          slot-scope="item, index"
          @mouseenter="enter(index)"
          @mouseleave="leave()"
          @mouseover="hover(index)"
        >
          <div class="listDetail" style="float:left;">
            <div class="list-col"></div>
            <div class="div-css">
              <span>{{item.title}}</span>
              <a-icon
                class="edit-icon"
                type="edit"
                @click="() => onEdit(index)"
                title="编辑"
                v-if="canEdit(item.memberId)"
              />
              <a-popconfirm
                title="是否缺删除?"
                @confirm="() => onDelete(item.id)"
                v-if="canDelete(item.memberId)"
              >
                <a-icon class="edit-icon" type="delete" title="删除" />
              </a-popconfirm>
            </div>
            <div class="content">
              <a-icon type="schedule" />
              {{item.startTime|dateFilter}} ~ {{item.endTime|dateFilter}}
            </div>
            <div class="content">
              <a-icon type="environment" />
              {{item.place}} {{item.address}}
            </div>
            <div class="content">
              <a-icon type="phone" />
              {{item.tel}}
            </div>
            <div class="content">
              <a-icon type="money-collect" />
              {{(item.cost).toFixed(2)}}大洋- {{item.number}} /人
            </div>
            <div class="content">
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
            </div>
            <div class="content">
              <a-icon  class="edit-icon" type="read" @click="() => readPartyCommentModal(item.id)" title="查看评论" />
              <a-tag
                v-for="(comment,index) in item.partyCommentDtos"
                :key="index"
              >{{comment.content}}</a-tag>
              <a-icon
                v-if="partyComment"
                class="edit-icon"
                type="edit"
                @click="() => showPartyCommentModal(item.id)"
                title="添加评论"
              />
            </div>
            <div class="list-col">{{item.lastBookReview}}</div>
          </div>

          <div class="listPhoto">
            <activity-photo
              :activityPhotos="item.partyPhotoDtos"
              :party-id="item.id"
              @refreshPhoto="refreshPhoto"
            ></activity-photo>
          </div>
          <a-divider />
        </a-list-item>
      </a-list>
    </div>
  </div>
</template>



<script>
import {
  reqGetPartyPaged,
  reqCreateOrUpdateParty,
  reqDeleteParty,
  reqUpdateLikeLevel,
  reqCreatePartyComment,
  reqGetPartyComments
} from "../../request/api";
import ActivityPhoto from "@/components/party/ActivityPhoto";
import moment from "moment";
import { AMapManager } from "vue-amap";

const imageBaseUrl = "http://192.168.1.102:8957/src";
export default {
  components: { ActivityPhoto },
  data() {
    let self = this;

    this.dateFormat = "YYYY-MM-DD HH:mm:ss";
    return {
      autoCompleteTest:{},
      markers: [
        [121.59996, 31.197646],
        [121.40018, 31.197622],
        [121.69991, 31.207649]
      ],
      searchOption: {
        city: "上海",
        citylimit: false
      },
      placeAllDict: {},
      placeNameDict:[],
      // amapManager,
      destroyOnClose: true,
      partyCreate: false,
      partyUpdate: false,
      partyUpdateSelf: false,
      partyDelete: false,
      partyDeleteSelf: false,
      partyComment: false,
      partyRate: false,
      address: "",
      events: {
        init: o => {
          console.log(o.getCenter());
          console.log(this.$refs.map.$$getInstance());
          o.getCity(result => {
            console.log(result);
          });
        },
        moveend: () => {},
        zoomchange: () => {},
        click(e) {
          let { lng, lat } = e.lnglat;
          console.log("getAddre-ss----经纬", e.lnglat);
          self.lng = lng;
          self.lat = lat;
          self.entityDetailForm.longitude = lng;
          self.entityDetailForm.latitude = lat;
          // 这里通过高德 SDK 完成。
          var geocoder = new AMap.Geocoder({
            radius: 1000,
            extensions: "all"
          });
          geocoder.getAddress([lng, lat], function(status, result) {
            console.log("result ---", result);
            if (status === "complete" && result.info === "OK") {
              if (result && result.regeocode) {
                self.entityDetailForm.address = "";
                self.entityDetailForm.address =
                  result.regeocode.formattedAddress;
                console.log(
                  "result && self.currentAddress",
                  self.entityDetailForm.address
                );
                self.$nextTick();
              }
            }
          });
        }
      },
      plugin: [
        "ToolBar",
        {
          pName: "MapType",
          defaultType: 0,
          events: {
            init(o) {
              console.log(o);
            }
          }
        }
      ],
      lng: 0,
      lat: 0,
      zoom: 12,
      center: [121.318759, 31.221327],
      filterType: "all",
      filterText: "",
      entityEndTime: "",
      entityStartTime: "",

      endOpen: false,
      visible: false,

      entitylistData: [],

      currentPartyId: -1,
      partyCommentReadModalVisible: false,
      partyCommentEditModalVisible: false,
      remain: 0,
      pagination: {
        pageSizeOptions: ["2", "5", "10", "20", "30", "40", "50"],
        defaultCurrent: 1,
        current: 1,
        showSizeChanger: true,
        pageSize: 2,
        total: 0,
        showQuickJumper: true,
        position: "bottom",
        onChange: (page, pageSize) => this.changePage(page, pageSize),
        showTotal: total => "共 " + total + " 条",
        onShowSizeChange: (current, pageSize) =>
          this.onShowSizeChange(current, pageSize)
      },
      partyContent: "",

      formComments: this.$form.createForm(this),
      detailForm: this.$form.createForm(this),
      address: "",
      costDisabled:false,
      entityDetailForm: {
        id: "",
        title: "",
        number: "",
        memberId: 0,
        cost: 0.0,
        latitude: 31.221327,
        longitude: 121.318759,
        tel: "",
        place: "",
        source: "",
        address: "",
        endTime: "",
        startTime: ""
      },
      entityEmptyForm: {
        id: "",
        title: "",
        number: "",
        memberId: 0,
        cost: 0.0,
        latitude: 31.221327,
        longitude: 121.318759,
        tel: "",
        place: "",
        source: "1",
        address: "",
        endTime: "",
        startTime: ""
      },
      partyCommentForm: {
        // id: '',
        partyId: "",
        content: "默认好评",
        memberId: 1
      },
      currentPartyComments: []
    };
  },
  watch: {
    startValue(val) {
      console.log("startValue", val);
    },
    endValue(val) {
      console.log("endValue", val);
    }
  },
  computed: {
    placeNameDictTest(){
      return this.placeNameDict;
    }
  },
  methods: {
    blur(){
      console.log("blur==", this.entityDetailForm.place);
      if(this.detailForm.getFieldValue("place")!=this.entityDetailForm.place)
      {
         this.setMap(this.detailForm.getFieldValue("place"));
      }
    },
    onSelectPlace(value){
      console.log("onSelectPlace==", value);
      this.entityDetailForm.place=value;
      this.setMap(value);
    },
    handlePlaceChange(value) {
      let _this = this;
      // 实例化Autocomplete
      var autoOptions = {
        //city 限定城市，默认全国
        city: "全国"
      };
      var autoComplete = new AMap.Autocomplete(autoOptions);
      var nameDict = [];
      _this.placeNameDict=[];
      autoComplete.search(value, function(status, result) {
        if(result.info=='OK')
        {
          _this.placeAllDict=result.tips;
          for (let i = 0; i < result.tips.length; i++) {
            nameDict.push(result.tips[i].name);
          }
          //console.log("result--placeNameDict ", _this.placeNameDict);
        }
      });
      _this.placeNameDict =nameDict;
    },
    setMap(name) {
      console.log("in-setMap", name,this.placeAllDict);
      var place={};
      for (let i = 0; i <  this.placeAllDict.length; i++) {
        if (name ==  this.placeAllDict[i].name) {
          place =  this.placeAllDict[i];
        }
      }
      console.log("placeDict  in-setMap-======element.name", name);
      this.entityDetailForm.longitude = place.location.lng;
      this.entityDetailForm.latitude = place.location.lat;
      this.center = [place.location.lng, place.location.lat];
      this.moveAMap(place.location.lng, place.location.lat);
    },

    addMarker: function() {
      let lng = this.lng + Math.round(Math.random() * 1000) / 10000;
      let lat = this.lat + Math.round(Math.random() * 500) / 10000;
      this.markers.push([lng, lat]);
    },
    onSearchResult(pois) {
      console.log("pois.place -pois", pois);
      console.log("pois.place -entityDetailForm");
      var c = this.detailForm.getFieldValue("place");

      console.log("pois.place ", c);
      let latSum = 0;
      let lngSum = 0;
      if (pois.length > 0) {
        console.log("pois.length ");
        pois.forEach(poi => {
          let { lng, lat } = poi;
          lngSum += lng;
          latSum += lat;
          this.markers.push([poi.lng, poi.lat]);
        });
        let center = {
          lng: lngSum / pois.length,
          lat: latSum / pois.length
        };
        this.center = [center.lng, center.lat];

        console.log("result -center--", center);
        this.entityDetailForm.longitude = center.lng;
        this.entityDetailForm.latitude = center.lat;

        this.moveAMap(center.lng, center.lat);
        // 这里通过高德 SDK 完成。
      }
    },
    moveAMap(lng, lat) {
      let _this = this;
      var geocoder = new AMap.Geocoder({
        radius: 1000,
        extensions: "all"
      });
      console.log("result -geocoder--getAddress");
      geocoder.getAddress([lng, lat], function(status, result) {
        console.log("result ---", result);
        if (status === "complete" && result.info === "OK") {
          if (result && result.regeocode) {
            console.log(
              "result && self.currentAddress",
              result.regeocode.formattedAddress
            );
            // this.entityDetailForm.address = "";
            _this.entityDetailForm.address = result.regeocode.formattedAddress;
            console.log(
              "result && self.currentAddress",
              result.regeocode.formattedAddress
            );
            // let address=result.regeocode.formattedAddress;
            // console.log("result && self.currentAddress", address);
            // _this.entityDetailForm.address = address;
            // _this.detailForm.setFieldsValue('address',address);
            self.$nextTick();
          }
        }
      });
    },
    validateCost(rule, value, callback) {
      const form = this.detailForm;
      if (!Number(value + 0.01)) {
        callback("请输入数字!");
      }
      if (value == 0) {
        callback("金额范围不为0");
      }

      if (value < 0.0 || value > +1000000.0) {
        callback("金额范围0~1000000.00");
      } else {
        callback();
      }
    },
    validateNumber(rule, value, callback) {
      const form = this.detailForm;
      const re = /^[0-9]*[1-9][0-9]*$/;
      if (!Number(value)) {
        callback("请输入数字!");
      } else if (!re.test(value)) {
        callback("请输入正整数!");
      } else if (value < 1 || value > 10000) {
        callback("人数超过10000限制!");
      } else {
        callback();
      }
    },
    canDelete(memberid) {
      // console.log("merber id ", memberid, this.$store.state.userInfo.userId);
      // console.log(
      //   "merber id ",
      //   typeof memberid,
      //   typeof this.$store.state.userInfo.userId
      // );
      if (
        this.partyDeleteSelf &&
        memberid == this.$store.state.userInfo.userId
      ) {
        return true;
      }
    },
    handleEndOpenChange(open) {
      this.endOpen = open;
    },

    canDelete(memberid) {
      // console.log("merber id ", memberid, this.$store.state.userInfo.userId);
      // console.log(
      //   "merber id ",
      //   typeof memberid,
      //   typeof this.$store.state.userInfo.userId
      // );
      if (
        this.partyDeleteSelf &&
        memberid == this.$store.state.userInfo.userId
      ) {
        return true;
      } else if (this.partyDelete && !this.partyDeleteSelf) {
        return true;
      }
      return false;
    },
    canEdit(memberid) {
      if (
        this.partyUpdateSelf &&
        memberid == this.$store.state.userInfo.userId
      ) {
        return true;
      } else if (this.partyUpdate && !this.partyUpdateSelf) {
        return true;
      }
      return false;
    },
    geocoder_CallBack2(data) {
      //回调函数
      var resultStr = "";
      var roadinfo = "";
      var poiinfo = "";
      var address;
      //返回地址描述
      address = data.regeocode.formattedAddress;
      //返回周边道路信息
      roadinfo += "<table style='width:600px'>";
      for (var i = 0; i < data.regeocode.roads.length; i++) {
        var color = i % 2 === 0 ? "#fff" : "#eee";
        roadinfo +=
          "<tr style='background-color:" +
          color +
          "; margin:0; padding:0;'><td>道路：" +
          data.regeocode.roads[i].name +
          "</td><td>方向：" +
          data.regeocode.roads[i].direction +
          "</td><td>距离：" +
          data.regeocode.roads[i].distance +
          "米</td></tr>";
      }
      roadinfo += "</table>";
      //返回周边兴趣点信息
      poiinfo += "<table style='width:600px;cursor:pointer;'>";
      for (var j = 0; j < data.regeocode.pois.length; j++) {
        var color = j % 2 === 0 ? "#fff" : "#eee";
        poiinfo +=
          "<tr onmouseover='onMouseOver(\"" +
          data.regeocode.pois[j].location.toString() +
          "\")' style='background-color:" +
          color +
          "; margin:0; padding:0;'><td>兴趣点：" +
          data.regeocode.pois[j].name +
          "</td><td>类型：" +
          data.regeocode.pois[j].type +
          "</td><td>距离：" +
          data.regeocode.pois[j].distance +
          "米</td></tr>";
      }
      poiinfo += "</table>";
      //返回结果拼接输出
      resultStr =
        '<div style="font-size: 12px;padding:0px 0 4px 2px; border-bottom:1px solid #C1FFC1;">' +
        "<b>地址</b>：" +
        address +
        "<hr/><b>周边道路信息</b>：<br/>" +
        roadinfo +
        "<hr/><b>周边兴趣点信息</b>：<br/>" +
        poiinfo +
        "</div>";
      document.getElementById("result").innerHTML = resultStr;
    },

    moment,

    refreshPhoto() {
      console.log("refreshPhoto");
      this.getData(this.pagination.current, this.pagination.pageSize);
    },
    hover: function(index) {
      // console.log(index);
      // console.log(this.entitylistData[index]);
      // $('a-list-item').eq(index).css({
      //   'background': '#ccc',
      //   'color': '#fff'
      // }).siblings().css({
      //   'background': '#fff',
      //   'color': '#333'
      // })
    },
    validateCode(rule, value, callback) {
      let myreg = /^\d*\S*$/;
      if (value == "") {
        console.log(
          "validateCode------不能为空-------手机号格式有误！----------"
        );
        callback(new Error(" 不能为空!"));
      } else if (!myreg.test(value)) {
        console.log(
          "validateCode-------只能是数字------手机号格式有误！----------"
        );
        callback(new Error(" 只能是数字!"));
      }
      console.log("validateCode-----------------------", value);
      var reg = new RegExp(/^((13|14|15|17|18)[0-9]{1}\d{8})$/);
      if (value && reg.test(value)) {
        console.log("validateCode-------------手机号格式有误！----------");
        callback("手机号格式有误！");
        return;
      }
      callback();
    },
    handlePartyComment() {
      this.formComments.validateFields((err, values) => {
        if (err) {
          console.log("Received values of form: ", values);
          return;
        }
      });

      this.partyCommentForm.partyId = this.currentPartyId;
      this.partyCommentForm.content = this.partyContent;
      reqCreatePartyComment(this.partyCommentForm)
        .then(response => {
          console.log(response);
          if (response.success) {
            console.log("-req", this.partyCommentForm);
            this.currentPartyId = -1;
            this.partyContent = "";

            this.partyCommentEditModalVisible = false;
            console.log("-req-success");
            this.getData(this.pagination.current, this.pagination.pageSize);
          } else {
            console.log(response.result.error);
          }
        })
        .catch(function(error) {
          console.info(error);
        })
        .finally(response => {
          console.info(response);
        });
    },
    edit(index) {
      console.log("edit", index);
    },
    enter(index) {
      this.seen = true;
    },
    leave() {
      this.seen = false;
      //  this.current = null;
    },
    addPartyRate(currentPartyId, currentPartyRate) {
      console.log("，partyId", currentPartyId);
      console.log("currentPartyRate", currentPartyRate);
      var ratePartyComment = {
        id: currentPartyId,
        score: currentPartyRate
      };
      reqUpdateLikeLevel(ratePartyComment)
        .then(response => {
          console.log("!!-", response);
          if (response.success) {
            console.log("addPartyRate", response.success);
            this.getData(this.pagination.current, this.pagination.pageSize);
          } else {
            console.log(response.result.error);
          }
        })
        .catch(function(error) {
          console.info(error);
        })
        .finally(response => {
          console.info(response);
        });
    },

    readPartyCommentModal(currentPartyId) {
      this.currentPartyId = currentPartyId;
      var readPartyComment = {
        partyId: currentPartyId
      };
      console.log("，partyId", currentPartyId);
      reqGetPartyComments(readPartyComment)
        .then(response => {
          console.log("!!-", response);
          if (response.success) {
            this.currentPartyComments = response.result;
            console.log("，partyId", this.currentPartyComments);
            this.getData(this.pagination.current, this.pagination.pageSize);
          } else {
            console.log(response.result.error);
          }
        })
        .catch(function(error) {
          console.info(error);
        })
        .finally(response => {
          console.info(response);
        });

      this.partyCommentReadModalVisible = true;
    },
    showPartyCommentModal(partyId) {
      this.currentPartyId = partyId;
      this.partyCommentEditModalVisible = true;
    },
    addComment(partyId) {},
    showDrawer() {
      this.costDisabled=false;
      var newEntity = JSON.parse(JSON.stringify(this.entityEmptyForm));
      this.entityDetailForm = newEntity;
      this.entityEndTime = moment().format("YYYY-MM-DD HH:mm:ss");
      this.entityStartTime = moment().format("YYYY-MM-DD HH:mm:ss");
      this.visible = true;
    },
    onClose() {
      this.visible = false;
    },
    onChangeStartTime(value, dateString) {
      console.log("Selected Time: ", value);
      console.log("Formatted Selected Time: ", dateString);

      this.entityStartTime = dateString;
    },
    onOkStartTime(value) {
      console.log("onOk: ", value);
    },

    onChangeEndTime(value, dateString) {
      console.log("Selected Time: ", value);
      console.log("Formatted Selected Time: ", dateString);

      this.entityEndTime = dateString;

      console.log(
        "Selected entityEmptyFormTime: ",
        this.entityEmptyForm.endTime
      );
    },
    onOkEndTime(value) {
      console.log("onOk: ", value);
    },

    onDelete(index) {
      console.log("onDelete----", index, "sd");
      reqDeleteParty({
        params: {
          Id: index
        }
      })
        .then(response => {
          console.log(response);
          if (response.success) {
            this.getData(this.pagination.current, this.pagination.pageSize);
          } else {
            console.log(response.result.error);
          }
        })
        .catch(function(error) {
          console.info(error);
        })
        .finally(response => {
          console.info(response);
        });
    },
    onEdit(index) {
      console.log("edit----", index, "sd");
      console.log("edit！！！----", this.entitylistData[index]);
      this.costDisabled=true;
      var currentEntity = this.entitylistData[index];
      var entityBody = {};
      console.log("edit！！id--！----", currentEntity.id);

      this.entityEndTime = currentEntity.endTime;
      this.entityStartTime = currentEntity.startTime;
      entityBody.id = currentEntity.id;
      entityBody.title = currentEntity.title;
      entityBody.number = currentEntity.number;
      entityBody.cost = currentEntity.cost;
      entityBody.latitude = currentEntity.latitude;
      entityBody.longitude = currentEntity.longitude;
      entityBody.tel = currentEntity.tel;
      entityBody.place = currentEntity.place;
      entityBody.source = currentEntity.source + "";
      entityBody.address = currentEntity.address;
      entityBody.endTime = currentEntity.endTime;
      entityBody.startTime = currentEntity.startTime;
      this.entityDetailForm = entityBody;
      // this.detailForm=entityBody;

      console.log("edit！！！--setFieldsValue--");
      console.log("edit！！！----", this.entityDetailForm);
      // this.showDrawer();

      this.visible = true;
    },
    onCreateParty() {
      this.entityDetailForm.address =  this.detailForm.getFieldValue("address" );
      this.entityDetailForm.startTime = this.entityStartTime;
      this.entityDetailForm.endTime = this.entityEndTime;

      this.entityDetailForm.startTime = this.detailForm.getFieldValue(
        "StartTime"
      );
      this.entityDetailForm.endTime = this.detailForm.getFieldValue("EndTime");
      this.entityDetailForm.address = this.detailForm.getFieldValue("address");
      this.entityDetailForm.place = this.detailForm.getFieldValue("place");
      console.log("this.entityDetailForm", this.entityDetailForm);
      let _this = this;
      this.detailForm.validateFields((err, values) => {
        if (!err) {
          reqCreateOrUpdateParty(this.entityDetailForm)
            .then(response => {
              console.log(this.entityDetailForm);
              console.log(response.result);
              console.log("---");
              if (response.success) {
                this.entityDetailForm = this.entityEmptyForm;
                this.getData(this.pagination.current, this.pagination.pageSize);
                console.log(response.success);
                this.visible = false;
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
        }
      });
    },
    getData(page, pageSize, queryType = "all") {
      console.log("page,pageSize", page, pageSize);
      let _this=this;
      reqGetPartyPaged({
        maxResultCount: pageSize,
        skipCount: pageSize * (page - 1),
        queryType: queryType,
        filterText: this.filterText
      })
        .then(response => {
          console.log("--", page);
          console.log("--", pageSize);
          console.log("--", response);
          var items = response.result.items;
          for (let i = 0; i < items.length; i++) {
            items[i].order = pageSize * (page - 1) + i + 1;
            if (items[i].partyPhotoDtos.length > 0) {
              for (let j = 0; j < items[i].partyPhotoDtos.length; j++) {
                items[i].partyPhotoDtos[j].url =
                  this.webConfig.ImageBaseUrl + items[i].partyPhotoDtos[j].url;
                items[i].partyPhotoDtos[j].urlPart =
                  this.webConfig.ImageBaseUrl + items[i].partyPhotoDtos[j].urlPart;
              }
            }
          }
          console.log("in items", items);
          this.entitylistData = items;
          console.log("in entitylistData", this.entitylistData);
          this.pagination.total = response.result.totalCount;
        })
        .catch(function(error) {
          console.info("error----", error);
          _this.entitylistData=[];
          _this.pagination.total = 0;
        });
    },
    activityFilter(e) {
      console.log("activityFilter", e.target.value);
      this.filterText = "";
      this.filterType = e.target.value;
      this.pagination.current = 1;
      this.pagination.pageSize = 2;
      this.getData(
        this.pagination.current,
        this.pagination.pageSize,
        this.filterType
      );
      console.log("activityFiltertest filterType", this.filterType);
    },
    onSearch(value) {
      console.log("search ", value);
      this.filterType = "";
      this.filterText = value;
      this.pagination.current = 1;
      this.pagination.pageSize = 2;
      this.getData(this.pagination.current, this.pagination.pageSize);
    },
    changePage(page, pageSize) {
      console.log("page: ", page);
      console.log("pageSize: ", pageSize);
      this.pagination.current = page;
      this.pagination.pageSize = pageSize;
      this.getData(this.pagination.current, this.pagination.pageSize,this.filterType);
    },
    onShowSizeChange(current, pageSize) {
      this.pagination.pageSize = pageSize;
      console.log("onShowSizeChange: ", current, pageSize);
      this.getData(this.pagination.current, this.pagination.pageSize,this.filterType);
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
      // console.log("handleChange", value);
      // console.log("handleChange", key);
      // console.log("handleChange", column);
      const newData = [...this.entitylistData];
      const target = newData.filter(item => key === item.id)[0];
      if (target) {
        target[column] = value;
        this.data = newData;
      }
    },
    permissionInit() {
      if (
        this.$store.state.partyPermission.indexOf(
          this.Permission.Party_Create_Default
        ) > -1
      ) {
        this.partyCreate = true;
      }
      if (
        this.$store.state.partyPermission.indexOf(
          this.Permission.Party_Update_Oneself
        ) > -1
      ) {
        this.partyUpdateSelf = true;
      }
      if (
        this.$store.state.partyPermission.indexOf(
          this.Permission.Party_Update_Default
        ) > -1
      ) {
        this.partyUpdate = true;
      }
      if (
        this.$store.state.partyPermission.indexOf(
          this.Permission.Party_Delete_Default
        ) > -1
      ) {
        this.partyDelete = true;
      }
      if (
        this.$store.state.partyPermission.indexOf(
          this.Permission.Party_Delete_Oneself
        ) > -1
      ) {
        this.partyDeleteSelf = true;
      }
      if (
        this.$store.state.partyPermission.indexOf(
          this.Permission.Party_Comment_Default
        ) > -1
      ) {
        this.partyComment = true;
      }
      if (
        this.$store.state.partyPermission.indexOf(
          this.Permission.Party_Rate_Default
        ) > -1
      ) {
        this.partyRate = true;
      }
    }
  },
  created() {
    //console.log("PartyPage Created merber id ");
  },
  mounted() {
    console.log("PartyList mounted()",
      this.pagination.current,
      this.pagination.pageSize
    );
    this.getData(this.pagination.current, this.pagination.pageSize);
    this.permissionInit();
  }
};
</script>
<style>
.party {
  max-width: 1280px;
  min-height: 300px;
  text-align: left;
}
.option-div {
  margin-top: 15px;
  margin-bottom: 10px;
}
.float-left {
  float: left;
}
.flex-lay {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  justify-content: center;
}
.float-right {
  float: right;
}
.radio-button {
  margin-right: 10px;
}

.listDetail {
  display: flex;
  flex-direction: column;
  margin: 0 auto;
  width: 550px;
}
.listPhoto {
  display: flex;
  flex-direction: column;
  margin: 0 auto;
  float: left;
}
.listbackground {
  background-color: #f2f2f2;
}
.listDetail-text {
  display: flex;
  float: left;
  flex-direction: column;
  margin: 0 auto;
}

.search-box {
  position: absolute !important;
  top: 8px;
  left: 5px;
  z-index: 200 !important;

  /* width: 70%;

  height: 20px; */
}

.div-css {
  margin: 10px;
  font-size: 20px;
}
.content {
  margin: 5px;
  float: left;
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
