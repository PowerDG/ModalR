<template>
  <div style="display: flex;flex-direction:column">
    <div style="margin-top: 20px" >
      <div class="float-left" v-if="bookSelectPermission">
        <a-radio-group :value="queryType" buttonStyle="solid" @change="activityFilter" >
          <a-radio-button class="radio-button" value="all">所有图书</a-radio-button>
          <a-radio-button class="radio-button" value="canborrow">可借图书</a-radio-button>
        </a-radio-group>
        <a-input-search
          placeholder="书名或作者"
          style="width: 250px"
          v-model="filterText"
          @search="onSearch"
          enterButton="搜索"
        />
      </div>
      <div class="float-right" >
        <book-edit-modal @refreshBook="refreshBook"  showType="button" v-if="bookCreatePermission"></book-edit-modal>
      </div>
      <div>
        <a-modal :visible="bookPhotoVisible"
                 @cancel="()=>{this.bookPhotoVisible=false;}"
                 :footer="null">
          <img alt="example" :src="photoSrc"  style="width: 100%;height: 100%" />
        </a-modal>
        <a-modal
          title="图书归还"
          :visible="returnVisible"
          @cancel="()=>{this.returnVisible=false}"
          :destroyOnClose="true"
          @ok="() => submitReturn()">
          <a-form layout="vertical" :form="returnForm">
            <a-form-item label="评分">
              <span>
                <a-rate
                  v-decorator="[ 'rate',{
                   rules: [{ required: true, message: '请输书评!' }
                            ],  } ]"
                />
              </span>
            </a-form-item>
            <a-form-item label="书评">
              <a-input
                v-decorator="[ 'review',{ rules: [{ required: true, message: '请输书评!' },
                         {max: 250, message: '书评不能超过250个字符!'}
                        ], } ]"
                type="textarea"
              ></a-input>
            </a-form-item>
          </a-form>
        </a-modal>
        <a-modal
          title="书籍丢失处理"
          :visible="lostFormVisible"
          @cancel="()=>{this.lostFormVisible=false}"
          :destroyOnClose="true"
          @ok="() => handleBookLost()">
          <a-form layout="vertical" :form="lostForm">
            <a-form-item label="原因">
              <a-input
                v-decorator="[ 'reason',{ rules: [{ required: true, message: '请输入原因!' },
                         {max: 250, message: '内容不能超过250个字符!'}
                        ], } ]"
                type="textarea"
              ></a-input>
            </a-form-item>
          </a-form>
        </a-modal>
      </div>
      <div style="margin-top: 60px">
      <a-list
        size="large"
        :grid="{ gutter: 16, xs: 1, sm: 1, md: 2, lg: 3, xl: 1, xxl: 1 }"
        :pagination="pagination"
        :dataSource="entitylistData"
      >
        <a-list-item key="item.title" slot="renderItem" slot-scope="item, index">
          <div class="list-item">
            <div class="list-col" style="width: 20px">
              <span class="list-col-text">{{item.order}}</span>
            </div>
            <div class="list-col" style="width: 120px">
              <div class="list-col-text">
                <book-edit-modal  @refreshBook="refreshBook"  :bookData="item"  showType="name"></book-edit-modal>
              </div>
            </div>
            <div class="list-col" style="width:120px">
              <img
                class="image-size"
                alt="default"
                :src="item.photo"
                slot="cover"
                @click="showOrigin(item.photoHd)"
              />
            </div>
            <div class="list-col" :class="{'delete-style': item.state==2}"  style="width:120px">
              <div class="list-col-text">
                <span>{{item.author}}</span>
              </div>
            </div>
            <div class="list-col" :class="{'delete-style': item.state==2}" style=" width:80px">
              <span class="list-col-text">
                {{item.entryTime.toString().substr(0,10)}}
                <!-- {{formatDate(new Date(item.entryTime ), "yyyy-MM-dd hh:mm")}} -->
              </span>
            </div>
            <div class="list-col" style="width:150px">
              <div class="list-col-text">
                <a-rate :disabled="rateDiabled" v-model="item.averageScore" />
              </div>
            </div>
            <div class="list-col" :class="{'delete-style': item.state==2}" style="width:200px">
              <div class="list-col-text-book" :title="item.lastBookReview">{{item.lastBookReview}}</div>
            </div>
            <div class="list-col" :class="{'delete-style': item.state==2}" style="width:50px">
              <div class="list-col-text">{{item.memberName}}</div>
            </div>
            <div class="list-col" style="width:100px">
              <div class="list-col-text" >
                <book-edit-modal  @refreshBook="refreshBook"  :bookData="item"  showType="icon"></book-edit-modal>
                <div v-if="item.state!=2&&bookBorrowPermission">
                  <a-popconfirm
                    title="确定借阅这本书吗?"
                    @confirm="() => onBorrow(item.id)"
                    v-if="canBorrow(item.memberId)"
                  >
                    <a-icon class="icon-style" type="book" title="借阅" />
                  </a-popconfirm>
                  <a-icon
                    class="icon-style"
                    type="export"
                    title="归还"
                    @click="()=>onReturn(item.id)"
                    v-if="canReturn(item.memberId)"
                  />
                  <a-icon class="icon-style" type="frown" @click="()=>setLost(item.id)" title="丢失" v-if="bookLostPermission"/>
                </div>
              </div>
            </div>
          </div>
        </a-list-item>
      </a-list>
      <!--<book-lost :bookId="bookLossId" :formVisible="bookLossVisiable"></book-lost>-->
    </div>
   </div>
    <!--<book-lost :book-id="bookLossId" :formVisible="bookLossVisiable"></book-lost>-->
  </div>

</template>


<script>
import {
  reqGetBookPaged,
  reqBorrowBook,
  reqBookReportLoss,
  reqReturnBookWithReview ,
  reqBorrowStatus
} from "../../request/api";

import { formatDate } from "../../fiters/common.js";

// import BookLost from "@/components/Libraries/BookLost";
import BookEditModal from "@/components/Libraries/BookEditModal";
import Bus from "@/plugins/Bus";
import ReturnBookWithReview from "@/components/Libraries/ReturnBookWithReview";

export default {
  components: { BookEditModal, ReturnBookWithReview },
  data() {
    return {
      //permission
      bookSelectPermission:false,
      bookCreatePermission: false,
      bookBorrowPermission:false,
      bookLostPermission: false,

      borrowValid: false,

      returnBookId: 0,
      returnVisible: false,
      returnForm: this.$form.createForm(this),

      lostBookId:0,
      lostFormVisible:false,
      lostForm: this.$form.createForm(this),

      entitylistData: [],
      queryType: "all",
      filterText: "",
      bookPhotoVisible:false,
      photoSrc:'',
      // columns,
      rateDiabled:true,
      defaultPageSize:10,
      pagination: {
        pageSizeOptions: ["10", "20", "30", "40", "50"],
        defaultCurrent: 1,
        current: 1,
        showSizeChanger: true,
        pageSize: 10,
        total: 0,
        showQuickJumper: true,
        position: "bottom",
        onChange: (page, pageSize) => this.changePage(page, pageSize),
        showTotal: total => "共 " + total + " 条",
        onShowSizeChange: (current, pageSize) =>
          this.onShowSizeChange(current, pageSize)
      },
    };
  },
  computed:{

  },
  methods: {
    //#endregion
    showOrigin(photoHd) {
      this.bookPhotoVisible = true;
      this.photoSrc = photoHd;
    },

    //#region 借书还书
    canBorrow(userId) {
      console.log('canBorrow userId',userId, this.borrowValid)
      if (userId == 0 && this.borrowValid) {
        return true;
      }
      return false;
    },
    canReturn(userId) {
      //console.log('canReturn userId',userId,this.$store.state.userInfo.userId)
      if (userId == this.$store.state.userInfo.userId) {
        return true;
      }
      return false;
    },
    onBorrow(bookId) {
      let _this = this;
      console.log("borror bookId", bookId);
      reqBorrowBook({ id: bookId })
        .then(response => {
          _this.$message.success("借阅成功！");
          _this.getData(
            this.pagination.current,
            this.pagination.pageSize,
            this.queryType
          );
        })
        .catch(error => {
          _this.$message.error(error.error.message);
        });
    },
    onReturn(bookId) {
      let _this = this;
      _this.returnBookId = bookId;
      console.log("onReturn还书还书 bookId", bookId);
      _this.returnVisible = true;
    },
    submitReturn() {
      let _this = this;
      this.returnForm.validateFields((err, values) => {
        if (!err) {
          var returnBookWithReviewForm = {};
          returnBookWithReviewForm.bookId = _this.returnBookId ;
          returnBookWithReviewForm.score = _this.returnForm.getFieldValue("rate");
          returnBookWithReviewForm.review = _this.returnForm.getFieldValue("review");
          console.log("submitRe turn 还书还书 bookId", returnBookWithReviewForm);
          reqReturnBookWithReview(returnBookWithReviewForm)
            .then(response => {
              console.log("submitRe turn 还书还书 bookId", response);
              _this.$message.success("归还成功！");
              _this.returnVisible=false;
              _this.getData(
                _this.pagination.current,
                _this.pagination.pageSize,
                _this.queryType
              );
            })
            .catch(error => {
              _this.$message.error(error.error.message);
            });
        }
      });

    },
    handleBookLost() {
      let _this = this;
      this.lostForm.validateFields((err, values) => {
        if (!err) {
          var bookLostForm = {};
          bookLostForm.id = _this.lostBookId ;
          bookLostForm.reason = _this.lostForm.getFieldValue("reason");
          console.log('handleBookLost',bookLostForm);
          reqBookReportLoss(bookLostForm)
            .then(response => {
              _this.$message.success("图书已挂失！");
              _this.lostFormVisible=false;
              _this.getData(
                _this.pagination.current,
                _this.pagination.pageSize,
                _this.queryType
              );
            })
            .catch(error => {
              _this.$message.error(error.error.message);
            });
        }
      });
    },
    setLost(bookId) {
      this.lostFormVisible=true;
      this.lostBookId=bookId;
      let _this = this;

    },
    //#endregion

    getData(page, pageSize, queryType = "all") {
      this.borrowStatus();
      console.log("book get data ", page, pageSize);
      let _this = this;
      reqGetBookPaged({
        maxResultCount: pageSize,
        skipCount: pageSize * (page - 1),
        queryType: queryType,
        filterText: this.filterText
      })
        .then(response => {
          var items = response.result.items;
          for (let i = 0; i < items.length; i++) {
            items[i].order = pageSize * (page - 1) + i + 1;
            items[i].photo = this.webConfig.ImageBaseUrl + items[i].photo;
            items[i].photoHd = this.webConfig.ImageBaseUrl + items[i].photoHd;
          }
          _this.entitylistData = items;
          //console.log("in entitylistData", this.entitylistData);
          _this.pagination.total = response.result.totalCount;
        })
        .catch(function(error) {
          console.info(error);
          _this.entitylistData = [];
          _this.pagination.total = 0;
        });
    },
    activityFilter(e) {
      console.log(e.target.value);
      this.filterText = "";
      this.queryType = e.target.value;
      this.pagination.current = 1;
      this.pagination.pageSize = this.defaultPageSize;
      this.getData(
        this.pagination.current,
        this.pagination.pageSize,
        this.queryType
      );
    },
    onSearch(value) {
      console.log("search ", value);
      this.queryType = null;
      this.filterText = value;
      this.pagination.current = 1;
      this.pagination.pageSize = this.defaultPageSize;
      this.getData(this.pagination.current, this.pagination.pageSize);
    },
    changePage(page, pageSize) {
      this.pagination.current = page;
      this.pagination.pageSize = pageSize;
      this.getData(
        this.pagination.current,
        this.pagination.pageSize,
        this.queryType
      );
    },
    onShowSizeChange(current, pageSize) {
      this.pagination.pageSize = pageSize;
      this.getData(current, this.pagination.pageSize, this.queryType);
    },
    permissionInit() {
      if (
        this.$store.state.bookPermission.indexOf(
          this.Permission.Book_Get_Default
        ) > -1
      ) {
        this.bookSelectPermission = true;
      }
      if (
        this.$store.state.bookPermission.indexOf(
          this.Permission.Book_Create_Default
        ) > -1
      ) {
        this.bookCreatePermission = true;
      }
      if (
        this.$store.state.bookPermission.indexOf(
          this.Permission.Book_Borrow_Default
        ) > -1
      ) {
        this.bookBorrowPermission = true;
      }
      if (
        this.$store.state.bookPermission.indexOf(
          this.Permission.Book_Delete_Default
        ) > -1
      ) {
        this.bookLostPermission = true;
      }
    },
    refreshBook(){
      this.getData(this.pagination.current, this.pagination.pageSize,this.queryType);
    },
    borrowStatus()
    {
      reqBorrowStatus({})
        .then(response => {
          var status = response.result;
          console.log('reqBorrowStatus',status)
          this.borrowValid = status;
        })
        .catch(function(error) {
          console.info(error);
        });
    }
  },
  mounted() {
    this.getData(this.pagination.current, this.pagination.pageSize,this.queryType);
    this.permissionInit();
    Bus.$on('refreshBook', content => {
      console.log(content)
      this.refreshBook();
    });
  }
};
</script>
<style  scoped>
.list-item {
  display: flex;
  height: 120px;
  justify-content: space-around;
  align-items: center;
  flex-direction: row;
  /*background-color: antiquewhite;*/
}
.list-col {
  display: flex;
  justify-content: center;
  /*background-color: lightgray;*/
}
.list-col-text {
  /*margin: 0 auto;*/
  display: flex;
  flex-wrap: wrap;
  text-align: center;
  justify-content: center;
}
.list-col-text-book {
  /*margin: 0 auto;*/
  display: flex;
  flex-wrap: wrap;
  text-align: center;
  justify-content: center;
  width: 180px;
  max-height: 110px;
  white-space: pre-wrap;
  text-overflow: ellipsis;
  overflow: hidden;
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
.radio-button {
  margin-right: 10px;
}
.delete-style{
  color: lightgrey;
}
</style>
