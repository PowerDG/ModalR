using Microsoft.AspNetCore.Mvc;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public class AppraisalsController : BaseController
    {
        private readonly IDatabase m_database;

        public AppraisalsController(IDatabase database)
        {
            this.m_database = database;
        }

        public IActionResult EditAppraisals(int memberId, int appraisalId = 0)
        {
            ViewBag.MemberId = memberId;
            string querySQL = $"SELECT * FROM appraisals WHERE id = {appraisalId}";
            var appraisal = m_database.Single<Appraisals>(querySQL);
            if (appraisal != null)
            {
                appraisal.AppraisalLevel = CommonDictionary.AppraisalLevel.FirstOrDefault(t => t.Value == appraisal.Level).Key;
                appraisal.AppraisalType = CommonDictionary.AppraisalType.FirstOrDefault(t => t.Value == appraisal.Type).Key;
            }
            return View(appraisal);
        }

        public async Task<JsonResult> GetAppraisals(int id, int page, int limit)
        {
            StringBuilder sql = new StringBuilder();
            sql.Append("SELECT a.Id, a.Year, a.Type, CASE a.Type WHEN '年中' THEN 1 WHEN '年末' THEN 2 ELSE 0 END YearType, a.ValueScore, a.PerformanceScore, a.Level,a.TotalScore");
            sql.Append(", a.MemberId, a.CreatedMemberId, a.CreatedTime, m.`Name` AS CreatedMemberName FROM appraisals AS a LEFT JOIN members AS m ON a.CreatedMemberId = m.Id ");
            sql.Append($" WHERE MemberId = {id}  ORDER BY a.Year DESC,YearType DESC  LIMIT {(page - 1) * limit}, {limit}");
            var appraisals = m_database.QueryListSQL<Appraisals>(sql.ToString());
            string sqlCount = $"SELECT COUNT(*) AS Count FROM appraisals WHERE MemberId= {id}";
            var count = await m_database.ExecuteScalarAsync(sqlCount);
            var result = new { code = 0, msg = "查询成功", count, data = appraisals };
            return Json(result);
        }

        [HttpPost]
        public async Task<JsonResult> EditAppraisals(Appraisals appraisal)
        {
            bool result = false;
            appraisal.CreatedTime = DateTime.Now;
            var userid = Convert.ToInt32(GetCurrentUserClaim("Id"));
            appraisal.Type = CommonDictionary.AppraisalType.FirstOrDefault(t => t.Key == appraisal.AppraisalType).Value;
            appraisal.Level = CommonDictionary.AppraisalLevel.FirstOrDefault(t => t.Key == appraisal.AppraisalLevel).Value;
            appraisal.CreatedMemberId = userid;
            if (appraisal.Id > 0)
            {
                result = await m_database.UpdateAsync(appraisal);
            }
            else
            {
                result = await m_database.CreateAsync(appraisal) > 0;
            }
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }

        [HttpPost]
        public JsonResult Delete(int id)
        {
            var result = false;
            result = m_database.ExecuteSQL($"DELETE FROM appraisals WHERE Id = @Id",
                new Dictionary<string, object> { { "@Id", id } });
            return Json(new { success = result, message = result ? "删除成功" : "删除失败" });
        }
    }
}