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
    public class GiftsController : BaseController
    {
        private readonly IDatabase database;
        public GiftsController(IDatabase database)
        {
            this.database = database;
        }

        public IActionResult EditGift(int memberId, int giftId = 0)
        {
            ViewBag.MemberId = memberId;
            string querySQL = $"SELECT * FROM gifts WHERE id = {giftId}";
            var gifts = database.Single<Gifts>(querySQL);
            return View(gifts);
        }

        public async Task<JsonResult> GetGiftsRecord(int id, int page, int limit)
        {
            StringBuilder sql = new StringBuilder();
            sql.Append($"SELECT g.*,m.`Name` AS CreatedMemberName FROM gifts AS g LEFT JOIN members AS m ON g.CreatedMemberId ");
            sql.Append($"= m.Id WHERE memberid = {id} ORDER BY g.CreatedTime DESC  LIMIT {(page - 1) * limit}, {limit}");
            var gifts = database.QueryListSQL<Gifts>(sql.ToString());
            string sqlCount = $"SELECT COUNT(*) AS Count FROM gifts WHERE MemberId= {id} ";
            var count = await database.ExecuteScalarAsync(sqlCount);
            var result = new { code = 0, msg = "查询成功", count, data = gifts };
            return Json(result);
        }

        [HttpPost]
        public async Task<JsonResult> EditGift(Gifts gift)
        {
            bool result = false;
            gift.CreatedTime = DateTime.Now;
            var userid = Convert.ToInt32(GetCurrentUserClaim("Id"));
            gift.CreatedMemberId = userid;
            if (gift.Id > 0)
            {
                result = await database.UpdateAsync(gift);
            }
            else
            {
                result = await database.CreateAsync(gift) > 0;
            }
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }

        [HttpPost]
        public JsonResult Delete(int id)
        {
            var result = false;
            result = database.ExecuteSQL($"DELETE FROM Gifts WHERE Id = {id}");
            return Json(new { success = result, message = result ? "删除成功" : "删除失败" });
        }
    }
}
