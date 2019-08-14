using Microsoft.AspNetCore.Mvc;
using ResearchHome.DataBase;
using System.Collections.Generic;

namespace ResearchHome.Controllers
{
    public class SelectController : BaseController
    {
        private readonly IDatabase _database;

        public SelectController(IDatabase database)
        {
            _database = database;
        }

        [HttpPost]
        public JsonResult GetMembersList(bool isContainsUerself = true)
        {
            var sqlWhere = isContainsUerself ? "" : $@" AND Id <> {GetCurrentUserClaim("Id")}";
            var result = _database.QueryListSQL<dynamic>($@"SELECT Id,Name FROM Members 
                                                            WHERE  IsLeave = 0 {sqlWhere}");
            return Json(result);
        }
        [HttpPost]
        public JsonResult GetTaskStatus()
        {
            var result = new List<dynamic>();
            result.Add(new { StatusId = "未开始", StatusName = "未开始" });
            result.Add(new { StatusId = "研究", StatusName = "研究" });
            result.Add(new { StatusId = "实施", StatusName = "实施" });
            result.Add(new { StatusId = "测试", StatusName = "测试" });
            result.Add(new { StatusId = "上线", StatusName = "上线" });
            result.Add(new { StatusId = "完成", StatusName = "完成" });
            result.Add(new { StatusId = "关闭", StatusName = "关闭" });
            return Json(result);
        }

        [HttpPost]
        public JsonResult GetTaskPriority()
        {
            var result = new List<dynamic>();
            result.Add(new { Id = "1", Name = "十万火急" });
            result.Add(new { Id = "2", Name = "快马加鞭" });
            result.Add(new { Id = "3", Name = "按部就班" });
            return Json(result);
        }


        [HttpPost]
        public JsonResult GetTodoStatus()
        {
            var result = new List<dynamic>();
            result.Add(new { StatusId = "未完成", StatusName = "未完成" });
            result.Add(new { StatusId = "执行中", StatusName = "执行中" });
            result.Add(new { StatusId = "完成", StatusName = "完成" });

            return Json(result);
        }
        [HttpPost]
        public JsonResult GetKeyResultStatus()
        {
            var result = new List<dynamic>();
            result.Add(new { StatusId = "未完成", StatusName = "未完成" });
            result.Add(new { StatusId = "关闭", StatusName = "关闭" });

            return Json(result);
        }


        [HttpPost]
        public JsonResult GetPlanStatus()
        {
            var result = _database.QueryListSQL<dynamic>($@"SELECT DISTINCT STATUS AS StatusId,STATUS AS StatusName FROM plans");
            return Json(result);
        }

        [HttpPost]
        public JsonResult GetTaskParnerChooseMemberList(int taskId)
        {
            string sql = $@"SELECT Id,Name 
                            FROM Members 
                            WHERE  IsLeave = 0
                            AND NOT EXISTS(SELECT MemberId FROM TaskPartners 
                                            WHERE TaskId ={taskId} AND MemberId = Members.Id 
                            ) AND Id <> (SELECT MemberId FROM Tasks WHERE Id = {taskId})";
            var result = _database.QueryListSQL<dynamic>(sql);
            return Json(result);
        }

        [HttpPost]
        public JsonResult GetTaskParticipant(int taskId)
        {
            string sql = $@"SELECT AllMembers.MemberId AS Id,members.`Name` FROM (
                            SELECT MemberId,'普通成员' AS Role FROM taskpartners
                            WHERE TaskId ={taskId} 
                            UNION ALL
                            SELECT MemberId,'负责人' AS Role FROM tasks
                            WHERE Id={taskId}
                            ) AS AllMembers
                            LEFT JOIN members ON AllMembers.MemberId=members.Id
                            ORDER BY AllMembers.MemberId";

            var result = _database.QueryListSQL<dynamic>(sql);

            return Json(result);
        }

        [HttpPost]
        public JsonResult GetMedals()
        {
            string sql = $@"SELECT Id,`Name` FROM medals WHERE  IsDiscard=0";
            var result = _database.QueryListSQL<dynamic>(sql);

            return Json(result);
        }
    }
}