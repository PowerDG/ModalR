using Microsoft.AspNetCore.Mvc;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public class IntegralsController : BaseController
    {
        private readonly IDatabase database;
        public IntegralsController(IDatabase database)
        {
            this.database = database;
        }

        public async Task<JsonResult> GetIntegrals(int id, int page, int limit)
        {
            var integralsList = database.QueryListSQL<Integrals>($"SELECT * FROM integrals WHERE MemberId = {id} ORDER BY CreatedTime DESC LIMIT {(page - 1) * limit}, {limit}");
            var count = await database.ExecuteScalarAsync($"SELECT COUNT(*) AS Count FROM integrals WHERE MemberId= {id}");
            var result = new { code = 0, msg = "查询成功", count, data = integralsList };
            return Json(result);
        }

        public IActionResult EditIntegral(int memberId, int integralId = 0)
        {
            ViewBag.MemberId = memberId;
            Integrals integral = database.Single<Integrals>($"SELECT * FROM integrals WHERE Id = {integralId}");
            return View(integral);
        }

        [HttpPost]
        public JsonResult SaveIntegral(Integrals integrals, int oldScore = 0)
        {
            var result = false;
            var member = database.Single<Members>($"SELECT * FROM Members WHERE Id = {integrals.MemberId}");
            int year = 0;
            if (integrals.Id > 0)
            {
                year = integrals.CreatedTime.Year;
            }
            else
            {
                year = DateTime.Now.Year;
            }
            var annualIntegral = database.Single<AnnualIntegrals>($"SELECT * FROM AnnualIntegrals WHERE MemberId = {integrals.MemberId} AND Years = {year}");
            result = database.RunInTransaction(() =>
            {
                if (integrals.Id > 0)
                    database.UpdateAsync(integrals);
                else
                {
                    integrals.CreatedTime = DateTime.Now;
                    database.CreateAsync(integrals);
                }
                member.TotalIntegral += (integrals.Integral - oldScore);
                database.UpdateAsync(member);
                if(annualIntegral == null)
                {
                    annualIntegral = new AnnualIntegrals()
                    {
                        MemberId = integrals.MemberId,
                        Years = year
                    };
                }
                annualIntegral.AnnualIntegral += (integrals.Integral - oldScore);
                annualIntegral.UpdatedTime = DateTime.Now;
                if (annualIntegral.Id > 0)
                    database.UpdateAsync(annualIntegral);
                else
                    database.CreateAsync(annualIntegral);
            });
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }

        [HttpPost]
        public JsonResult Delete(int id)
        {
            var result = false;
            var integrals = database.QuerySQL<Integrals>($"SELECT * FROM integrals WHERE Id = {id}");
            var year = integrals.CreatedTime.Year;
            var member = database.QuerySQL<Members>($"SELECT * FROM members WHERE Id = {integrals.MemberId}");
            var annualIntegral = database.QuerySQL<AnnualIntegrals>($"SELECT * FROM annualintegrals WHERE MemberId = {integrals.MemberId} AND Years = {year}");
            result = database.RunInTransaction(() => 
            {
                bool updateMember, updateAnnual, deleteResult = true;
                updateMember = database. TransactionExecuteSQL($"UPDATE members SET TotalIntegral = {member.TotalIntegral - integrals.Integral} WHERE Id = {member.Id}");
                updateAnnual = database.TransactionExecuteSQL($"UPDATE annualintegrals SET annualIntegral = {annualIntegral.AnnualIntegral - integrals.Integral} WHERE Id = {annualIntegral.Id}");
                deleteResult = database.TransactionExecuteSQL($"DELETE FROM integrals WHERE Id = {id}");
                if(!updateAnnual || !updateMember || !deleteResult)
                {
                    throw new Exception("事务执行失败");
                }
            });
            return Json(new { success = result, message = result ? "删除成功" : "删除失败" });
        }
    }
}
