using Microsoft.AspNetCore.Mvc;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public class FeedbackController : BaseController
    {
        private readonly IDatabase m_database;
        public FeedbackController(IDatabase database)
        {
           m_database = database;
        }

        public IActionResult EditFeedback(int memberId, int feedbackId = 0)
        {
            ViewBag.MemberId = memberId;
            string querySQL = $"SELECT * FROM feedbacks WHERE id = {feedbackId}";
            var feedback = m_database.Single<Feedbacks>(querySQL);
            return View(feedback);
        }

        public async Task<JsonResult> GetFeedbacks(int id, int page, int limit)
        {
            Boolean.TryParse(GetCurrentUserClaim("IsAdmin"), out bool isAdmin);
            int.TryParse(GetCurrentUserClaim("Id"), out int currentId);
            StringBuilder sql = new StringBuilder();
            sql.Append($"SELECT f.Id,f.Content,f.MemberId,f.ProviderId,f.CreatedTime,IFNULL(f.ProviderName,(SELECT m.`Name` FROM members AS m ");
            sql.Append($" WHERE m.Id = f.ProviderId) ) AS ProviderName FROM feedbacks AS f WHERE f.MemberId = {id} ");
            if(currentId == 0)
            {
                sql.Append(" AND (f.ProviderId = 0 || f.ProviderId = -1) ");
            }
            else if(isAdmin == false && currentId > 0 && currentId != id)
            {
                sql.Append($" AND (f.ProviderId = {currentId})");
            }
            sql.Append($" ORDER BY f.CreatedTime DESC  LIMIT {(page - 1) * limit}, {limit}");
            var feedbacks = m_database.QueryListSQL<Feedbacks>(sql.ToString());
            StringBuilder sqlCount = new StringBuilder($"SELECT COUNT(*) AS Count FROM feedbacks WHERE MemberId= {id}  ");
            if (currentId == 0)
            {
                sqlCount.Append(" AND ProviderId = 0 || ProviderId = -1");
            }
            else if (isAdmin == false && currentId > 0 && currentId != id)
            {
                sqlCount.Append($" AND (ProviderId = {currentId})");
            }
            var count = await m_database.ExecuteScalarAsync(sqlCount.ToString());
            var result = new { code = 0, msg = "查询成功", count, data = feedbacks };
            return Json(result);
        }

        [HttpPost]
        public async Task<JsonResult> EditFeedback(Feedbacks feedback)
        {
            bool.TryParse(Request.Form["isCheck"], out bool isCheck);
            int.TryParse(Request.Form["code"], out int code);
            if (isCheck)
            {
                HttpContext.Session.TryGetValue("VerificationCode", out byte[] codeBytes);
                int serverCode = BitConverter.ToInt32(codeBytes);
                if(code != serverCode)
                {
                    return Json(new { success = false, message = "验证码错误" });
                }
            }
            bool result = false;
            feedback.CreatedTime = DateTime.Now;
            if (feedback.Id > 0)
            {
                result = await m_database.UpdateAsync(feedback);
            }
            else
            {
                result = await m_database.CreateAsync(feedback) > 0;
            }
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }

        [HttpPost]
        public JsonResult Delete(int id)
        {
            var result = false;
            result = m_database.ExecuteSQL($"DELETE FROM Feedbacks  WHERE Id = {id}");
            return Json(new { success = result, message = result ? "删除成功" : "删除失败" });
        }
    }
}
