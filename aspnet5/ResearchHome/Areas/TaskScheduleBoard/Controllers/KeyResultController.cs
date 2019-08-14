using Microsoft.AspNetCore.Mvc;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;

namespace ResearchHome.Areas.TaskScheduleBoard.Controllers
{
    [Area("TaskScheduleBoard")]
    public class KeyResultController : BaseController
    {
        private readonly IDatabase database;

        public KeyResultController(IDatabase database)
        {
            this.database = database;
        }

        public IActionResult CreateKeyResult(int taskId)
        {
            ViewBag.TaskId = taskId;
            return View();
        }

        [HttpPost]
        public IActionResult CreateKeyResult(string description, string remark, int taskId)
        {
            var memberId = GetCurrentUserClaim("Id");
            var dateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            var result = database.TransactionInsertSQL("keyresults",
                                               new DataColumn("Description", description),
                                               new DataColumn("Remark", remark),
                                               new DataColumn("LastUpdateMemberId", memberId),
                                               new DataColumn("Status", KeyResultStatus.NotCompleted),
                                               new DataColumn("CreateTime", dateTime),
                                               new DataColumn("TaskId", taskId),
                                               new DataColumn("LastUpdateTime", dateTime));

            if (!result)
            {
                TempData["Message"] = "parent.layer.msg('创建失败,请重试！！',{icon: 5,shift: -1, time: 500});";
            }
            else
            {
                TempData["Message"] = @"parent.layer.msg('创建成功!', { icon: 6,shift: -1, time: 500, shade: 0.3},
                                            function() { parent.layer.closeAll(); })";
            }
            return View();
        }

        public IActionResult EditKeyResult(int keyResultId, string type)
        {
            string sql = $@"SELECT Description,`Status`,Remark FROM keyresults  WHERE Id={keyResultId}";
            var keyResult = database.QuerySQL<dynamic>(sql);
            ViewBag.KeyResultId = keyResultId;
            ViewBag.Description = keyResult.Description;
            ViewBag.Status = keyResult.Status;
            ViewBag.Remark = keyResult.Remark;
            ViewBag.Type = type;
            return View();
        }

        [HttpPost]
        public IActionResult EditKeyResult(int keyResultId, string description, string remark, string keyResultStatus)
        {
            var memberId = GetCurrentUserClaim("Id");
            var dateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            var result = database.TransactionUpdateSQL("keyresults",
                                               new DataColumn("Description", description),
                                               new DataColumn("Remark", remark),
                                               new DataColumn("Status", keyResultStatus),
                                               new DataColumn("Id", keyResultId, true),
                                               new DataColumn("LastUpdateMemberId", memberId),
                                               new DataColumn("LastUpdateTime", dateTime));

            if (!result)
            {
                TempData["Message"] = "parent.layer.msg('更新失败,请重试！！',{icon: 5,shift: -1, time: 500});";
            }
            else
            {
                TempData["Message"] = @"parent.layer.msg('更新成功!', { icon: 6,shift: -1, time: 500, shade: 0.3},
                                            function() { parent.layer.closeAll(); })";
                if (keyResultStatus == KeyResultStatus.Closed)
                {
                    var keyResultInfo = database.QuerySQL<dynamic>($@"SELECT TaskId,Description FROM keyresults 
                                                                      WHERE Id={keyResultId}");
                    AddTaskTracking(database, keyResultInfo.TaskId, "关闭关键结果：" + keyResultInfo.Description, "关闭关键结果");
                }
            }
            return View();
        }

        public JsonResult GetTaskKeyResultsSummary(int taskId)
        {
            string sqlTotal = $@"SELECT COUNT(1) FROM `keyresults` WHERE TaskId={taskId} ";
            var keyResultsTotalCount = database.Single<int>(sqlTotal);

            string sqlComplete = $@"SELECT COUNT(1) FROM `keyresults` 
                                    WHERE TaskId={taskId} AND Status = '{KeyResultStatus.Closed}' ";
            var keyResultsClosedCount = database.Single<int>(sqlComplete);

            return Json(new { keyResultsTotalCount, keyResultsClosedCount });
        }

        [HttpPost]
        public JsonResult GetTaskKeyResultsCount(int taskId)
        {
            string sql = $@"SELECT COUNT(1) FROM `keyresults` WHERE TaskId={taskId} ";
            var keyResultsCount = database.Single<int>(sql);
            return Json(new { keyResultsCount });
        }

        [HttpPost]
        public JsonResult GetTaskKeyResults(int taskId, int page, int limit)
        {
            string sql = $@"SELECT keyresults.Id,keyresults.Description,members.`Name` AS LastUpdateMemberName,
                                   keyresults.`Status`,keyresults.LastUpdateTime
                            FROM `keyresults`
                            LEFT JOIN members ON keyresults.LastUpdateMemberId=members.Id
                            WHERE keyresults.TaskId={taskId} 
                            ORDER BY (CASE WHEN keyresults.`Status`='{KeyResultStatus.NotCompleted}' then 0
                                           WHEN keyresults.`Status`='{KeyResultStatus.Closed}' then 1 END)                          
                            , keyresults.LastUpdateTime DESC LIMIT {limit * (page - 1)},{limit}";
            var keyResults = database.QueryListSQL<dynamic>(sql);
            return Json(keyResults);
        }

        [HttpPost]
        public JsonResult CloseKeyResult(int keyResultId)
        {
            string sql = $@"UPDATE keyresults SET `Status`='{KeyResultStatus.Closed}',ClosedTime=NOW(),LastUpdateTime=NOW(),
                            LastUpdateMemberId={GetCurrentUserClaim("Id")},ClosedMemberId={GetCurrentUserClaim("Id")}
                            WHERE Id ={keyResultId}";
            var operateResult = database.TransactionExecuteSQL(sql);
            string message = "";
            if (!operateResult)
            {
                message = "关闭失败，请重试！";
            }
            else
            {
                var keyResultInfo = database.QuerySQL<dynamic>($@"SELECT TaskId,Description FROM keyresults 
                                                                  WHERE Id={keyResultId}");
                AddTaskTracking(database, keyResultInfo.TaskId, "关闭关键结果：" + keyResultInfo.Description, "关闭关键结果");
            }
            return Json(new { result = operateResult, message });
        }

        [HttpPost]
        public JsonResult DeleteKeyResult(int keyResultId)
        {
            var operateResult = database.TransactionExecuteSQL($@"DELETE FROM keyresults WHERE Id ={keyResultId}");
            string message = "";
            if (!operateResult)
            {
                message = "删除失败，请重试！";
            }
            else
            {
                var keyResultInfo = database.QuerySQL<dynamic>($@"SELECT TaskId,Description FROM keyresults 
                                                                  WHERE Id={keyResultId}");
                AddTaskTracking(database, keyResultInfo.TaskId, "删除关键结果：" + keyResultInfo.Description, "删除关键结果");
            }
            return Json(new { result = operateResult, message });
        }
    }
}