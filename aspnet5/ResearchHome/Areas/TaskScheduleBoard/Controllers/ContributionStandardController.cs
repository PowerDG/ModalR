using Microsoft.AspNetCore.Mvc;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ResearchHome.Areas.TaskScheduleBoard.Controllers
{
    [Area("TaskScheduleBoard")]
    public class ContributionStandardController : BaseController
    {
        private readonly IDatabase database;

        public ContributionStandardController(IDatabase database)
        {
            this.database = database;
        }

        public IActionResult Index()
        {
            return View();
        }

        public JsonResult GetContributionStandardData()
        {
            List<dynamic> contributionStandardNode = GetContributionStandard(null, null);

            var contributionStandardRoot = database.Single<dynamic>("SELECT id,name,parentId FROM contribution_standard WHERE parentId = 0");
            contributionStandardRoot.children = contributionStandardNode;
            return Json(contributionStandardRoot);
        }

        private List<dynamic> GetContributionStandard(List<dynamic> contributionStandardNodes = null,
            dynamic contributionStandardParent = null)
        {
            List<dynamic> childs = new List<dynamic>();
            if (contributionStandardNodes == null)
            {
                string sql = $@"SELECT * FROM contribution_standard WHERE parentId != 0";
                var all = database.QueryListSQL<dynamic>(sql);
                contributionStandardNodes = all.ToList();
                childs = contributionStandardNodes.Where(s => s.ParentId == 1).ToList();
            }
            else
            {
                childs = contributionStandardNodes.Where(s => s.ParentId == contributionStandardParent.Id).ToList();
            }
            List<dynamic> result = new List<dynamic>();
            foreach (var child in childs)
            {
                dynamic s = new
                {
                    id = child.Id,
                    parentId = child.ParentId,
                    name = child.Name,
                    level = child.Level,
                    children = GetContributionStandard(contributionStandardNodes, child)
                };
                result.Add(s);
            }
            return result;
        }

        public IActionResult AddContributionStandard(int id)
        {
            var contributionStandard = database.QuerySQL<dynamic>($"SELECT * FROM contribution_standard WHERE id = {id}");
            ViewBag.ContributionStandard = contributionStandard;
            return View();
        }

        [HttpPost]
        public JsonResult AddContributionStandard(int parentId, string name, int level)
        {
            string createdTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            string sql = $@"INSERT INTO contribution_standard(ParentId,Name,Level,CreatedTime)
                          VALUES ({parentId},'{name}',{level},'{createdTime}')";
            bool result = database.ExecuteSQL(sql);
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }

        public JsonResult DeleteContributionStandard(int contributionStandardId)
        {
            string sql = $@"DELETE FROM contribution_standard WHERE Id={contributionStandardId}";
            bool result = database.ExecuteSQL(sql);
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }

        public IActionResult EditContributionStandard(int id)
        {
            var contributionStandard = database.QuerySQL<dynamic>($"SELECT * FROM contribution_standard WHERE id = {id}");
            ViewBag.ContributionStandardId = contributionStandard.Id;
            ViewBag.ContributionStandardName = contributionStandard.Name;
            return View();
        }

        [HttpPost]
        public JsonResult EditContributionStandard(int id, string name)
        {
            var result = database.ExecuteSQL($"UPDATE contribution_standard SET Name='{name}' WHERE Id = {id}");
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }
    }
}