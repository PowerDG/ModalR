using Microsoft.AspNetCore.Mvc;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public class TitleController : BaseController
    {
        private readonly IDatabase database;
        public TitleController(IDatabase database)
        {
            this.database = database;
        }

        public IActionResult TitleChange(int memberId, int recordId = 0)
        {
            string querySQL = $"SELECT * FROM titlechanges WHERE id = {recordId}";
            var titleChange = database.Single<TitleChangesModel>(querySQL);
            if (titleChange != null)
            {
                ViewBag.OldTitle = titleChange.OldTitle;
            }
            else
            {
                string queryMember = $"SELECT * FROM members WHERE id = {memberId}";
                var member = database.Single<Members>(queryMember);
                ViewBag.OldTitle = member != null ? member.Title : "错误";
            }
            ViewBag.MemberId = memberId;
            return View(titleChange);
        }

        public async Task<JsonResult> GetTitleChanges(int id, int page, int limit)
        {
            StringBuilder sql = new StringBuilder();
            sql.Append($"SELECT t.*,m.`Name` AS CreatedMemberName FROM titlechanges AS t LEFT JOIN members AS m ");
            sql.Append($" ON t.CreatedMemberId = m.Id WHERE memberid = {id} ORDER BY t.ChangedTime DESC LIMIT {(page - 1) * limit}, {limit}");
            var titleChanges = database.QueryListSQL<TitleChangesModel>(sql.ToString());
            var count = await database.ExecuteScalarAsync($"SELECT COUNT(*) AS Count FROM titlechanges WHERE MemberId= {id} ");
            var result = new { code = 0, msg = "查询成功", count, data = titleChanges };
            return Json(result);
        }

        [HttpPost]
        public JsonResult ChangeTitle(TitleChangesModel titleChange)
        {
            titleChange.ChangedTime = DateTime.Now;
            var userid = Convert.ToInt32(GetCurrentUserClaim("Id"));
            titleChange.CreatedMemberId = userid;
            string updateMember = $"UPDATE members SET title = @title WHERE id = @id";
            Dapper.DynamicParameters paras = new Dapper.DynamicParameters();
            paras.Add("@title", titleChange.NewTitle, DbType.String);
            paras.Add("@id", titleChange.MemberId, DbType.Int32);
            if (titleChange.Id > 0) return UpdateTitleChangeRecord(titleChange, updateMember, paras);
            else return InsertTitleChangeRecord(titleChange, updateMember, paras);
        }

        private JsonResult InsertTitleChangeRecord(TitleChangesModel titleChange, string updateMember, Dapper.DynamicParameters paras)
        {
            bool result = database.RunInTransaction(() => 
            {
                bool updateTitleResult = database.ExecuteSQL(updateMember, paras);
                bool insertTitleChangeResult = database.CreateAsync(titleChange).Result > 0;
                if(!updateTitleResult || !insertTitleChangeResult)
                {
                    throw new Exception("事务执行失败");
                }
            });
            return Json(new { success = result, message = result ? "新增成功" : "新增失败" });
        }

        private JsonResult UpdateTitleChangeRecord(TitleChangesModel titleChange, string updateMember, Dapper.DynamicParameters paras)
        {
            bool result = false;
            var currentTitle = database.QuerySQL<TitleChangesModel>($"SELECT * FROM titlechanges WHERE MemberId = {titleChange.MemberId}  ORDER BY ChangedTime DESC LIMIT 1");
            bool isCurrentTitle = currentTitle.Id == titleChange.Id;
            result = database.RunInTransaction(() => 
            {
                var updateTitleResult = true;
                //如果是最新的记录，则修改当前职位
                if (isCurrentTitle)
                {
                    updateTitleResult = database.ExecuteSQL(updateMember, paras);
                }
                bool updateTitleChangeResult = database.TransactionExecuteSQL($"UPDATE titlechanges SET NewTitle = '{titleChange.NewTitle}' WHERE Id = {titleChange.Id}");
                if(!updateTitleResult || !updateTitleChangeResult)
                {
                    throw new Exception("事务执行失败");
                }
            });
            return Json(new { success = result, message = result ? "更新成功" : "更新失败" });
        }

        [HttpPost]
        public JsonResult Delete(int id)
        {
            bool result = false;
            var titleChange = database.QuerySQL<TitleChangesModel>($"SELECT * FROM TitleChanges WHERE Id = {id}");
            //必须保留一条记录
            var titles = database.QueryListSQL<TitleChangesModel>($"SELECT * FROM titlechanges WHERE MemberId = {titleChange.MemberId}  ORDER BY ChangedTime DESC LIMIT 2").ToList();
            if(titles.Count < 2)
            {
                return Json(new { success = false, message = "不允许删除最后一条记录" });
            }
            //需要删除的title记录是否是最新的（变更记录最新的一条是当前职位的记录）
            bool isSame = titles[0].Id == titleChange.Id;
            result = database.RunInTransaction(() =>
            {
                var updateMember = true;
                //如果是最新，则更改当前职位
                if (isSame)
                {
                    updateMember = database.TransactionExecuteSQL($"UPDATE members SET title = '{titles[1].NewTitle}' WHERE id = {titleChange.MemberId}");
                }
                var deleteResult = database.TransactionExecuteSQL($"DELETE FROM TitleChanges  WHERE Id = {id}");
                if(!updateMember || !deleteResult)
                {
                    throw new Exception("事务执行失败");
                }
            });
            return Json(new { success = result, message = result ? "删除成功" : "删除失败" });
        }
    }
}
