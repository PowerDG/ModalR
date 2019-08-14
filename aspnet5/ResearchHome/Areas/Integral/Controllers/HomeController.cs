using Microsoft.AspNetCore.Mvc;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ResearchHome.Areas.Integral.Controllers
{
    [Area("Integral")]
    [AuthorizeFilter]
    public class HomeController : BaseController
    {
        private readonly IDatabase m_database;

        public HomeController(IDatabase database)
        {
            m_database = database;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetIntegralRankingData()
        {
            var sqlStr = $@"SELECT Id,Name,Photo,TotalIntegral,IFNULL(MemberAnnualIntegrals.AnnualIntegral,0) AnnualIntegral
                            FROM Members
                            LEFT JOIN(
	                          SELECT MemberId,AnnualIntegral FROM AnnualIntegrals
                              WHERE Years = DATE_FORMAT(NOW(),'%Y')
                            ) AS MemberAnnualIntegrals
                            ON Members.Id = MemberAnnualIntegrals.MemberId
                            WHERE Members.IsLeave = 0
                            ORDER BY TotalIntegral DESC, Id";
            var result = m_database.QueryListSQL<dynamic>(sqlStr);
            return Json(result);
        }

        [HttpPost]
        public JsonResult GetMedals()
        {
            var sqlStr = $@"SELECT MemberId,Grade FROM membermedals,medals WHERE membermedals.MedalId=medals.Id";
            var medals = m_database.QueryListSQL<dynamic>(sqlStr).ToList();
            string memberSql = $@"SELECT Id,`Name`,Photo FROM members   WHERE Members.IsLeave = 0";
            var members = m_database.QueryListSQL<dynamic>(memberSql).ToList();

            List<dynamic> result = new List<dynamic>();
            foreach (var member in members)
            {
                var allMedal = medals.Where(medal => medal.MemberId == member.Id).ToList();
                var medalLevel1 = allMedal.Where(medal => medal.Grade == 1).ToList().Count;
                var medalLevel2 = allMedal.Where(medal => medal.Grade == 2).ToList().Count;
                var medalLevel3 = allMedal.Where(medal => medal.Grade == 3).ToList().Count;
                result.Add(new { member.Name, member.Photo, medalLevel1, medalLevel2, medalLevel3 });
            }
            result = result.OrderByDescending(medal => medal.medalLevel1).ThenByDescending(medal => medal.medalLevel2).
                                                                        ThenByDescending(medal => medal.medalLevel3).ToList();
            return Json(result);
        }

        [HttpPost]
        public JsonResult GetYearReviews()
        {
            int month = DateTime.Now.Month;
            int year = DateTime.Now.Year;
            string type = "年中";
            if (month < 7)
            {
                type = "年末";
                year -= 1;
            }
            var sqlStr = $@"SELECT members.`Name`,members.Photo,appraisals.Type,appraisals.`Level` FROM members,appraisals
                            WHERE members.Id=appraisals.MemberId AND Members.IsLeave = 0 AND appraisals.Type='{type}'
                                  AND appraisals.Year={year}
                                ORDER BY appraisals.TotalScore Desc,members.Id";
            var result = m_database.QueryListSQL<dynamic>(sqlStr);
            return Json(result);
        }
    }
}