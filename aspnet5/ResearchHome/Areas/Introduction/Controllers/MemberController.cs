using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.Areas.SkillsAndMedals.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using System;
using System.Data;
using System.IO;
using System.Text;
using System.Threading.Tasks;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public class MemberController : BaseController
    {
        private readonly IConfiguration m_configuration;
        private readonly IDatabase m_database;
        private IHostingEnvironment m_environment;

        public MemberController(IConfiguration configuration, IDatabase database, IHostingEnvironment environment)
        {
            this.m_configuration = configuration;
            this.m_database = database;
            this.m_environment = environment;
        }

        public IActionResult MemberList()
        {
            var members = m_database.QueryListSQL<Members>("SELECT * FROM members WHERE IsLeave = 0 ORDER BY EntryTime");
            return PartialView(members);
        }

        public IActionResult HeroicArtPhoto()
        {
            return View();
        }

        [HttpPost]
        public JsonResult InsertArtPhoto(string imgPath)
        {
            var effectCount = false;
            var memberId = GetCurrentUserClaim("Id");
            if (string.IsNullOrEmpty(memberId))
            {
                return Json(new { Result = false, Msg = "请先登录" });
            }
            if (string.IsNullOrEmpty(imgPath))
            {
                return Json(new { Result = false, Msg = "请上传图片" });
            }

            if (!PictureSizeCheck(imgPath))
            {
                return Json(new { Result = false, Msg = "图片尺寸不对" });
            }
            var imgUrlResult = PictureHelper.UploadOriginPicture("FileUpload", imgPath, m_configuration, m_environment);
            if (imgUrlResult == null)
            {
                return Json(new { Result = false, Msg = $@"{imgUrlResult},请通知管理员查看！" });
            }
            string artPhotoSql = $@"UPDATE members SET art_photo='{ imgUrlResult}' WHERE Id={memberId}";
            effectCount = m_database.ExecuteSQL(artPhotoSql);

            return Json(new { Result = effectCount, Msg = "" });
        }

        private bool PictureSizeCheck(string imageSource)
        {
            string imageFormat = null;
            byte[] imageBytes = PictureHelper.GetImgBytes(imageSource, out imageFormat);
            using (var image = System.Drawing.Image.FromStream(new MemoryStream(imageBytes, 0, imageBytes.Length)))
            {
                return image.Width >= 760 && image.Height >= 300;
            }
        }

        [HttpPost]
        public JsonResult GetMemberList()
        {
            string memberSql = $@"SELECT Id,`Name`,Motto,art_photo FROM members WHERE IsLeave = 0 ORDER BY EntryTime";
            var member = m_database.QueryListSQL<dynamic>(memberSql);
            return Json(member);
        }

        public IActionResult EditMember(int id)
        {
            string querySQL = $"SELECT * FROM members WHERE id = {id}";
            var member = m_database.Single<Members>(querySQL);
            ViewBag.ActionType = member == null ? "Add" : "Edit";
            return View(member);
        }

        public IActionResult MemberRecord(int id)
        {
            var currentYear = DateTime.Now.Year;
            string account = GetCurrentUserClaim("Account");

            int loginId = 0;
            int.TryParse(GetCurrentUserClaim("Id"), out loginId);
            string queryStr = $@"SELECT OperateType FROM likerecords WHERE MemberId={id} AND LikeMeMemberId={loginId} AND DATE(LastOperateTime)=CURDATE()";
            var queryResult = m_database.Single<dynamic>(queryStr);
            var likeType = new object();
            if (queryResult == null)
            {
                likeType = null;
            }
            else
            {
                if (Convert.ToInt32(queryResult.OperateType) == 1)
                {
                    likeType = "like";
                }
                else if (Convert.ToInt32(queryResult.OperateType) == 2)
                {
                    likeType = "dislike";
                }
                else
                {
                    likeType = null;
                }
            }

            string querySQL = $@"SELECT m.*, IFNULL(n.AnnualIntegral,0) AS AnnualIntegral FROM members AS m LEFT
                                JOIN annualintegrals AS n ON n.MemberId = m.Id and Years = {currentYear} WHERE m.Id = {id}";
            var memberData = m_database.Single<dynamic>(querySQL);
            Members member = new Members
            {
                AnnualIntegral = Convert.ToInt32(memberData.AnnualIntegral),
                DislikeCount = memberData.DislikeCount,
                Gender = Convert.ToBoolean(memberData.Gender),
                Id = memberData.Id,
                LikeCount = memberData.LikeCount,
                Name = memberData.Name,
                Photo = memberData.Photo,
                PhotoHD = memberData.PhotoHD,
                Title = memberData.Title,
                TotalIntegral = memberData.TotalIntegral,
                EntryTime = memberData.EntryTime,
                Account = memberData.Account,
                IsLeave = Convert.ToBoolean(memberData.IsLeave),
                QQ = memberData.QQ,
                Phone = memberData.Phone,
                WeChat = memberData.WeChat,
                Email = memberData.Email,
                AliasName = memberData.AliasName,
                Motto = memberData.Motto
            };
            ViewBag.LikeType = likeType;
            return PartialView(member);
        }

        public JsonResult GetMemberProfile(int id)
        {
            string querySQL = $@"SELECT Id,Name,AliasName,Gender,Title,Phone,QQ,WeChat,Email,Motto FROM members WHERE Id = {id}";
            var memberData = m_database.Single<dynamic>(querySQL);
            return Json(memberData);
        }

        public JsonResult GetTotalIntegral(int id)
        {
            var currentYear = DateTime.Now.Year;
            string querySQL = $@"SELECT m.TotalIntegral, IFNULL(n.AnnualIntegral,0) AS AnnualIntegral FROM members AS m LEFT
                                JOIN annualintegrals AS n ON n.MemberId = m.Id and Years = {currentYear} WHERE m.Id = {id}";
            var memberData = m_database.Single<dynamic>(querySQL);
            int TotalIntegral = 0;
            int AnnualIntegral = 0;
            if (memberData != null)
            {
                TotalIntegral = Convert.ToInt32(memberData.TotalIntegral);
                AnnualIntegral = Convert.ToInt32(memberData.AnnualIntegral);
            }
            return Json(new { totalIntegral = TotalIntegral, annualIntegral = AnnualIntegral });
        }

        public async Task<JsonResult> GetNewTitle(int id)
        {
            string querySQL = $"SELECT Title FROM Members WHERE Id = {id}";
            var title = await m_database.ExecuteScalarAsync(querySQL);
            return Json(new { title });
        }

        public JsonResult GetAllMedals()
        {
            var medals = m_database.QueryListSQL<Medals>("SELECT * FROM medals");
            return Json(medals);
        }

        public JsonResult GetMedalById(int id)
        {
            var medal = m_database.QuerySQL<Medals>($"SELECT * FROM medals WHERE Id = {id}");
            return Json(medal);
        }

        public string GetPinYin(string name)
        {
            return Helper.PinYinHelper.ConvertToAllSpell(name);
        }

        [HttpPost]
        public async Task<JsonResult> ClickLike(int memberId, int type, int like, int fight)
        {
            int operateType = 0;
            //取消点赞或取消加油
            if (like + fight != -1)
            {
                operateType = type;
            }
            int loginId = int.Parse(GetCurrentUserClaim("Id"));
            string querySQL = $@"SELECT COUNT(Id) FROM likerecords WHERE MemberId={memberId} AND LikeMeMemberId={loginId} AND OperateType={operateType}
                                AND DATE(LastOperateTime)=CURDATE()";
            var count = await m_database.ExecuteScalarAsync(querySQL);
            if ((long)count >= 1)
            {
                return Json(new { success = false });
            }
            bool resultUpdate = m_database.ExecuteSQL($@"UPDATE likerecords SET LastOperateTime='{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}',OperateType={operateType} WHERE MemberId={memberId} AND LikeMeMemberId={loginId}");
            if (!resultUpdate)
            {
                bool resultInsert = m_database.ExecuteSQL($@"INSERT INTO likerecords(MemberId,LikeMeMemberId,LastOperateTime,OperateType)
                                                   VALUES ({memberId}, {loginId},'{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}',{operateType})");
            }

            string likeType = type == 1 ? "like" : "dislike";
            string account = GetCurrentUserClaim("Account");
            var member = m_database.Single<Members>($"SELECT * FROM Members WHERE Id = {memberId}");
            member.LikeCount += like;
            member.DislikeCount += fight;
            var updateResule = await m_database.UpdateAsync(member);
            if (updateResule)
            {
                if (like > 0 || fight > 0)
                {
                    Helper.CacheHelper.SetCache($"like:{account}:{memberId}", likeType, new Microsoft.Extensions.Caching.Memory.MemoryCacheEntryOptions() { SlidingExpiration = TimeSpan.FromDays(1) });
                }
                else
                {
                    Helper.CacheHelper.RemoveCache($"like:{account}:{memberId}");
                }
            }
            return Json(new { success = updateResule });
        }

        [HttpPost]
        public async Task<JsonResult> EditMember(Members member, string actionType)
        {
            if (!string.IsNullOrEmpty(member.Photo))
            {
                var photo = Helper.PictureHelper.UploadPicture("FileUpload", member.Photo, m_configuration, m_environment);
                member.Photo = photo.Item2;
                member.PhotoHD = photo.Item1;
            }
            else
            {
                member.Photo = AppConsts.NewStaffDeafultPhoto;
                member.PhotoHD = AppConsts.NewStaffDeafultPhotoHD;
            }
            string sql = $"SELECT COUNT(*) FROM members WHERE Account = '{member.Account}' AND Id != {member.Id}";
            var accountCount = await m_database.ExecuteScalarAsync(sql);
            if (Convert.ToInt32(accountCount) > 0)
            {
                return Json(new { success = false, message = "登录名已被使用" });
            }
            switch (actionType)
            {
                case "Add":
                    return await InsertMember(member);

                case "Edit":
                    return UpdateMember(member);

                default:
                    return Json(new { success = false, message = "请求的参数有误" });
            }
        }

        [HttpPost]
        public JsonResult DeleteMember(int id)
        {
            var result = m_database.ExecuteSQL($"DELETE FROM members WHERE Id = {id}");
            return Json(new { success = result, message = result ? "删除成功" : "删除失败" });
        }

        private async Task<JsonResult> InsertMember(Members member)
        {
            bool result = false;
            string passworkKey = Helper.PasswordHelper.GetRandomPasswordKey();
            string randomStr = Helper.PasswordHelper.GetRandomString(8);
            string password = Helper.PasswordHelper.GetRfcDerivePassword(randomStr, passworkKey);
            member.PasswordKey = passworkKey;
            member.Password = password;
            var userid = Convert.ToInt32(GetCurrentUserClaim("Id"));
            using (IDbConnection conn = m_database.Connection)
            {
                IDbTransaction transaction = conn.BeginTransaction();
                try
                {
                    int? memberId = await m_database.CreateAsync(member);
                    TitleChangesModel titleChange = new TitleChangesModel()
                    {
                        MemberId = Convert.ToInt32(memberId),
                        OldTitle = "入职",
                        NewTitle = member.Title,
                        CreatedMemberId = userid,
                        ChangedTime = DateTime.Now
                    };
                    bool insertTitleChangeResult = await m_database.CreateAsync(titleChange) > 0;
                    if (memberId > 0 && insertTitleChangeResult)
                    {
                        transaction.Commit();
                        result = true;
                    }
                    else transaction.Rollback();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    throw ex;
                }
            }
            return Json(new { success = result, message = result ? "新增成功,密码是:" + randomStr : "新增失败" });
        }

        private JsonResult UpdateMember(Members member)
        {
            bool result = false;
            dynamic oldPhoto = null;
            StringBuilder sql = new StringBuilder();
            sql.Append("UPDATE members SET name = @name, account = @account, gender = @gender, remarks = @remarks, qq = @qq");
            if (!string.IsNullOrEmpty(member.Photo))
            {
                sql.Append(",photo = @photo, photohd = @photohd ");
                //获取旧照片url，更新后进行删除
                string sqlStr = $@"SELECT Photo,PhotoHD FROM members WHERE Id={member.Id}";
                oldPhoto = m_database.Single<dynamic>(sqlStr);
            }
            sql.Append(", aliasName = @aliasName, motto = @motto");
            sql.Append(", wechat = @wechat, phone = @phone, birthday = @birthday, entrytime = @entrytime, email = @email WHERE Id = @id");
            Dapper.DynamicParameters paras = new Dapper.DynamicParameters();
            paras.Add("@name", member.Name, DbType.String);
            paras.Add("@photo", member.Photo, DbType.String);
            paras.Add("@photohd", member.PhotoHD, DbType.String);
            paras.Add("@gender", member.Gender, DbType.Boolean);
            paras.Add("@remarks", member.Remarks, DbType.String);
            paras.Add("@qq", member.QQ, DbType.String);
            paras.Add("@wechat", member.WeChat, DbType.String);
            paras.Add("@phone", member.Phone, DbType.String);
            paras.Add("@birthday", member.BirthDay, DbType.Date);
            paras.Add("@id", member.Id, DbType.Int32);
            paras.Add("@entrytime", member.EntryTime, DbType.Date);
            paras.Add("@email", member.Email, DbType.String);
            paras.Add("@account", member.Account, DbType.String);
            paras.Add("@motto", member.Motto, DbType.String);
            paras.Add("@aliasName", member.AliasName, DbType.String);
            result = m_database.ExecuteSQL(sql.ToString(), paras);
            return Json(new { success = result, message = result ? "修改成功" : "修改失败" });
        }

        [HttpPost]
        public JsonResult ResetPassword(int memberId)
        {
            bool result = false;
            string sql = "UPDATE members SET password = @password , passwordkey = @passwordkey WHERE Id = @id";
            string passworkKey = Helper.PasswordHelper.GetRandomPasswordKey();
            string randomStr = Helper.PasswordHelper.GetRandomString(8);
            string password = Helper.PasswordHelper.GetRfcDerivePassword(randomStr, passworkKey);
            Dapper.DynamicParameters paras = new Dapper.DynamicParameters();
            paras.Add("@password", password, DbType.String);
            paras.Add("@passwordkey", passworkKey, DbType.String);
            paras.Add("@id", memberId.ToString(), DbType.Int32);
            result = m_database.ExecuteSQL(sql, paras);
            return Json(new { success = result, message = result ? "重置成功,新密码为:" + randomStr : "重置失败", password = randomStr });
        }

        public IActionResult FarAwayHero()
        {
            return View();
        }

        public JsonResult GetReentryMember()
        {
            var members = m_database.QueryListSQL<Members>("SELECT * FROM members WHERE IsLeave = 1 ORDER BY LeaveTime DESC");
            return Json(members);
        }

        [HttpPost]
        public JsonResult ReenterMember(int id)
        {
            bool result = m_database.RunInTransaction(() =>
            {
                var member = m_database.QuerySQL<Members>($"SELECT * FROM Members Where Id = {id}");
                var titleChanges = new TitleChangesModel()
                {
                    OldTitle = "离职",
                    NewTitle = member.Title,
                    ChangedTime = DateTime.Now,
                    MemberId = id,
                    CreatedMemberId = Convert.ToInt32(GetCurrentUserClaim("Id"))
                };
                var insertTitleChange = m_database.CreateAsync(titleChanges).Result > 0;
                var updateMember = m_database.ExecuteSQL($"UPDATE members SET IsLeave = 0, LeaveTime = null, EntryTime = '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}'  WHERE Id = {id}");
                if (!insertTitleChange || !updateMember)
                {
                    throw new Exception("事务执行失败");
                }
            });
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }

        [HttpPost]
        public JsonResult LeaveMember(int id, string title)
        {
            bool result = m_database.RunInTransaction(() =>
            {
                var titleChanges = new TitleChangesModel()
                {
                    OldTitle = title,
                    NewTitle = "离职",
                    ChangedTime = DateTime.Now,
                    MemberId = id,
                    CreatedMemberId = Convert.ToInt32(GetCurrentUserClaim("Id"))
                };
                var insertTitleChange = m_database.CreateAsync(titleChanges).Result > 0;
                var updateMember = m_database.ExecuteSQL($"UPDATE members SET IsLeave = 1, LeaveTime = '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}' WHERE Id = {id}");
                if (!insertTitleChange || !updateMember)
                {
                    throw new Exception("事务执行失败");
                }
            });
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }
    }
}