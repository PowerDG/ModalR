/**
* api接口统一管理
*/
import { get, post, postify, del, put, putify } from './http'

const baseURL = "http://192.168.1.102:8957"
const baseAccountURL = "http://192.168.1.102:5001"

// export const reqAccountLogin = p => post(baseAccountURL + '/api/LoginWithAuthenticate', p);
// export const reqAllUserBrief = p => get(baseAccountURL + '/Account/services/app/User/GetAllUserBrief', p);
// //获取当前用户user基本信息
// export const reqCurrentLoginInformations = p => get(baseAccountURL + '/Account/services/app/Session/GetCurrentLoginInformations', p);

// export const reqGetPartyPermission = p => get(baseAccountURL + '/api/services/app/Permission/GetModuleNamePermissionsList', p);


// 登录
export const reqAccountLogin = p => post(baseURL + '/Login', p);
export const reqAllUserBrief = p => get(baseURL + '/Account/services/app/User/GetAllUserBrief', p);
//获取当前用户user基本信息
export const reqCurrentLoginInformations = p => get(baseURL + '/Account/services/app/Session/GetCurrentLoginInformations', p);

export const reqChangePassword = p => post(baseURL + '/Account/services/app/User/ChangePassword', p);
export const reqResetPassword = p => post(baseURL + '/Account/services/app/User/ResetPassword', p);

export const reqGrantedPermissionsAsync = p => post(baseURL + '/Account/services/app/Permission/CheckGrantedPermissionsAsync', p);
export const reqAssignedPermissionsAsync = p => postify(baseURL + '/Account/services/app/Permission/CheckAssignedPermissionsAsync', p);
export const reqGrantedCurrentPermissionsAsync = p => get(baseURL + '/Account/services/app/Permission/GetGrantedCurrentPermissionsAsync', p);
//获取指定user所有权限  userId:13
export const reqGetModulePermission = p => get(baseURL + '/Account/services/app/Permission/ModuleNamePermissionsList', p);


export const reqGrantedAllPermissionsAsync = p => get(baseURL + '/Account/services/app/Permission/GetGrantedAllPermissionsAsync', p);
// 获取模块的权限


/**
* 撷英阁api接口
*/

export const reqGetBookPaged = p => get(baseURL + '/BookService/Book/GetPaged', p);
export const reqGetBookResourceType= p => get(baseURL + '/BookService/Book/GetResourceType', p);

export const reqCreateBook = p => post (baseURL + '/BookService/Book/Create', p);
export const reqUpdateBook = p => put(baseURL + '/BookService/Book/Update', p);
export const reqDeleteBook = p => put(baseURL + '/BookService/Book/Delete', p);
export const reqCreateBookReview = p => get(baseURL + '/BookService/BookReview/Create', p);
export const reqUpdateBookReview = p => get(baseURL + '/BookService/BookReview/Update', p);
export const reqDeleteBookReview = p => get(baseURL + '/BookService/BookReview/Delete', p);
export const reqGetReviewPaged = p => get(baseURL + '/BookService/BookReview/GetReviewPaged', p);

export const reqReturnBookWithReview = p => put(baseURL + '/BookService/BookReview/ReturnBookWithReview', p);
export const reqBorrowBook = p => put(baseURL + '/BookService/Book/BorrowBook', p);
export const reqBorrowStatus = p => get(baseURL + '/BookService/Book/CanBorrow', p);
export const reqBookLoss = p => put(baseURL + '/BookService/Book/BorrowBook', p);
export const reqBookReportLoss = p => put(baseURL + '/BookService/Book/ReportLoss', p);
export const reqBookRemoveOfReportLoss = p => put(baseURL + '/BookService/Book/RemoveOfReportLoss', p);



/**
* 活动林api接口
*/

export const reqGetPartyPermission = p => get(baseURL + '/PartyService/Party/GetModuleNamePermissionsList', p);
export const reqGetPartyPaged = p => get(baseURL + '/PartyService/Party/GetPaged', p);
export const reqCreateOrUpdateParty = p => post(baseURL + '/PartyService/Party/CreateOrUpdate', p);
export const reqDeleteParty = p => del(baseURL + '/PartyService/Party/Delete', p);
export const reqUpdateLikeLevel= p => put(baseURL + '/PartyService/Party/UpdateLikeLevel', p);
export const reqCreatePartyComment = p => post(baseURL + '/PartyService/Party/CreateComment', p);
export const reqGetPartyComments = p => get(baseURL + '/PartyService/Party/GetComments', p);



export const reqCreateFund = p => post(baseURL + '/PartyService/Fund/CreateFund', p);
export const reqRemainMoney = p => get(baseURL + '/PartyService/Fund/GetRemainMoney', p);
export const reqTotalFunds = p => get(baseURL + '/PartyService/Fund/GetTotalFunds', p);
export const reqUpdateFund = p => put(baseURL + '/PartyService/Fund/UpdateFund', p);
export const reqDeleteFund = p => del(baseURL + '/PartyService/Fund/DeleteFund', p);

export const reqUploadImage = p => post(baseURL + '/ImageService/Image/Upload', p);
export const reqInsertPartyImg = p => post(baseURL + '/PartyService/Party/InsertPartyImg', p);
