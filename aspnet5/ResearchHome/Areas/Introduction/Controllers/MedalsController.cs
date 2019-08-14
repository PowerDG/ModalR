using Microsoft.AspNetCore.Mvc;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.Areas.SkillsAndMedals.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public class MedalsController : BaseController
    {
        private readonly IDatabase database;
        public MedalsController(IDatabase database)
        {
            this.database = database;
        }

        public IActionResult MedalList()
        {
            return PartialView();
        }

        public JsonResult GetMemberMedal(int memberId)
        {
            List<MemberMedals> memberMedals = new List<MemberMedals>();
            var memberMedalsDataEnum = database.QueryListSQL<dynamic>($@"SELECT m2.Name, m2.Icon, m2.Description,m2.Grade, Count(m1.Id) AS Count, m1.MedalId, m1.MemberId, m1.Reason, m1.GainDate FROM 
                                                         membermedals AS m1 LEFT JOIN medals AS m2 ON m2.Id = m1.MedalId WHERE m1.MemberId = {memberId} GROUP BY m1.MedalId");
            if(memberMedalsDataEnum == null)
            {
                return Json(memberMedals);
            }

            var gradeMedals = from medal in memberMedalsDataEnum
                              orderby medal.Grade
                              group medal by medal.Grade;
                              
            List<dynamic> memberMedalsByGrade = new List<dynamic>();
            foreach (var gradeMedal in gradeMedals)
            {
                var grade = gradeMedal.Key;
                memberMedals = new List<MemberMedals>();
                foreach (var medal in gradeMedal)
                {
                    memberMedals.Add(new MemberMedals()
                    {
                        MedalId = Convert.ToInt32(medal.MedalId),
                        GainDate = medal.GainDate,
                        Reason = medal.Reason,
                        MemberId = Convert.ToInt32(medal.MemberId),
                        Count = Convert.ToInt32(medal.Count),
                        Medal = new Medals()
                        {
                            Icon = medal.Icon,
                            Name = medal.Name,
                            Description = medal.Description
                        }
                    });
                }
                memberMedalsByGrade.Add(new { grade=Helper.NumberHelper.NumberToChinese(Convert.ToString(grade)), memberMedals });
            }
            return Json(memberMedalsByGrade);
        }

        [HttpPost]
        public JsonResult AddMemberMedal(MemberMedals model)
        {
            model.GainDate = DateTime.Now;
            bool result = database.RunInTransaction(() => 
            {
                var medals = database.Single<Medals>($"SELECT * FROM Medals WHERE Id = {model.MedalId}");
                var insertResult = database.CreateAsync(model).Result > 0;
                medals.Count += 1;
                var updateResult = database.UpdateAsync(medals).Result;
                if(!insertResult || !updateResult)
                {
                    throw new Exception("事务执行失败");
                }
            });
            return Json(new { success = result, message = result ? "授予成功" : "授予失败" });
        }

        public IActionResult AddMedal(int memberId)
        {
            ViewBag.MemberId = memberId;
            return View();
        }

        public IActionResult MedalGainLogs(int memberId, int medalId)
        {
            ViewBag.MemberId = memberId;
            ViewBag.MedalId = medalId;
            return View();
        }

        public async Task<JsonResult> GetMedalGainLogs(int memberId, int medalId, int page, int limit)
        {
            string sql = $"SELECT * FROM membermedals WHERE MemberId= {memberId} AND MedalId = {medalId} ORDER BY GainDate DESC LIMIT {(page - 1) * limit}, {limit}";
            var memberMedals = database.QueryListSQL<MemberMedals>(sql);
            string sqlCount = $"SELECT COUNT(*) AS Count FROM membermedals WHERE MemberId= {memberId} AND MedalId = {medalId}";
            var count = await database.ExecuteScalarAsync(sqlCount);
            var result = new { code = 0, msg = "查询成功", count, data = memberMedals };
            return Json(result);
        }
    }
}
