using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.Areas.SkillsAndMedals.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;
using System.Data;
using System.Text;
using System.Threading.Tasks;
using System.Linq;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public class LabelsController : BaseController
    {
        private readonly IConfiguration configuration;
        private readonly IDatabase database;

        public LabelsController(IConfiguration configuration, IDatabase database, IHostingEnvironment environment)
        {
            this.configuration = configuration;
            this.database = database;
        }

        /// <summary>
        /// 添加成员标签
        /// </summary>
        /// <returns></returns>
        public IActionResult AddMemberLabel(int memberId)
        {
            ViewBag.MemberId = memberId;
            return View();
        }

        [HttpPost]
        public JsonResult AddMemberLabel(int memberId, string labels)
        {
            string[] labelArry = labels.Split(new char[] { ',', '，' });
            StringBuilder sql = new StringBuilder();
            foreach(var label in labelArry)
            {
                var trimedLabel = label.Trim();
                dynamic labelId = database.Single<dynamic>(
                    $@"SELECT Id FROM memberlabels WHERE MemberId = {memberId} AND  Label='{trimedLabel}'");
                if(labelId== null)
                {
                    sql.Append($@"INSERT INTO memberlabels(MemberId,Label,Count) Values({memberId},'{trimedLabel}',1);");
                }
                else
                {
                    sql.Append($@"UPDATE memberlabels SET Count=Count+1 WHERE MemberId={memberId} AND Label='{trimedLabel}';");
                }
            }

            bool result = database.ExecuteSQL(sql.ToString());
            return Json(new { success = result, message = result ? "添加成功" : "操作失败" });

        }

        public JsonResult GetMemberLabels(int memberId)
        {
            string querySQL = $@"SELECT Label AS name,Count AS value FROM memberlabels where MemberId={memberId}";
            var memberLabels = database.QueryListSQL<dynamic>(querySQL).ToList();
            int labelCount = memberLabels.Count;
            return Json(new { labelCount, memberLabels });
        }
    }
}