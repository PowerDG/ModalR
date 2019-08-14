using Microsoft.AspNetCore.Mvc;
using ResearchHome.Areas.TaskScheduleBoard.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ResearchHome.Areas.TaskScheduleBoard.Controllers
{
    [Area("TaskScheduleBoard")]
    public class PlanController : BaseController
    {
        private readonly IDatabase database;

        public PlanController(IDatabase database)
        {
            this.database = database;
        }

        public IActionResult CreatePlan()
        {
            return View();
        }

        [HttpPost]
        public IActionResult CreatePlan(string planName, string remark)
        {
            var memberId = GetCurrentUserClaim("Id");
            var dateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            var result = database.TransactionInsertSQL("plans",
                                               new DataColumn("Name", planName),
                                               new DataColumn("Remark", remark),
                                               new DataColumn("CreatedMemberId", memberId),
                                               new DataColumn("Status", PlanStatus.Opened),
                                               new DataColumn("CreateTime", dateTime),
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

        public IActionResult GetPlanDetail(int planId)
        {
            string sql = $@"SELECT plans.Id,plans.`Name`,plans.`Status`,plans.ClosedTime,plans.CreateTime,
                                   members.`Name` AS CreateMemberName,Remark 
                            FROM plans
                            LEFT JOIN members ON plans.CreatedMemberId=members.Id
                            WHERE plans.Id={planId}";
            var planModel = database.QuerySQL<PlanModel>(sql);

            return View(planModel);
        }

        public JsonResult GetPlans(int page, int limit, string queryType)
        {
            var plans = new List<dynamic>();
            int resultCount = 0;
            List<dynamic> result = new List<dynamic>();
            switch (queryType)
            {
                case "effectivePlans":
                    plans = GetEffectivePlans(page, limit, out resultCount);
                    break;

                case "allPlans":
                    plans = GetAllPlans(page, limit, out resultCount);
                    break;

                default:
                    plans = GetAllPlans(page, limit, out resultCount);
                    break;
            }
            if (resultCount == 0)
            {
                return Json(new PageResponse(result, resultCount));
            }
            var ids = plans.Select(p => p.PlanId).ToList();

            var allTasks = GetTasksByPlanId(ids);
            GeneratePlansResponse(plans, allTasks, ref result);

            return Json(new PageResponse(result, resultCount));
        }

        private void GeneratePlansResponse(List<dynamic> plans, List<dynamic> allTasks, ref List<dynamic> result)
        {
            foreach (var plan in plans)
            {
                var tasks = allTasks.Where(t => t.PlanId == plan.PlanId)
                    .Select(t => new { t.TaskId, t.TaskName, t.TaskStatus, t.DeadLineTime }).ToList();
                bool canClosed = !tasks.Exists(task => task.TaskStatus == PlanStatus.Opened) 
                    && GetCurrentUserClaim("IsAdmin") == "True";
                bool canCreateTask = plan.PlanStatus == PlanStatus.Opened && GetCurrentUserClaim("IsAdmin") == "True" ? true : false;
                bool canDelete = plan.PlanStatus == PlanStatus.Opened && GetCurrentUserClaim("IsAdmin") == "True" ? true : false;
                result.Add(new
                {
                    plan.PlanId,
                    plan.PlanName,
                    plan.PlanStatus,
                    plan.CreatedMemberId,
                    plan.CreatedMemberPhoto,
                    plan.CreateTime,
                    plan.ClosedTime,
                    canClosed,
                    canCreateTask,
                    canDelete,
                    tasks
                });
            }
        }

        private List<dynamic> GetAllPlans(int page, int limit, out int plansCount)
        {
            string sql = $@"SELECT plans.Id AS PlanId,plans.`Name` AS PlanName,`Status` AS PlanStatus,CreatedMemberId,
                                   members.Photo AS CreatedMemberPhoto,CreateTime,ClosedTime FROM plans
                            LEFT JOIN members ON plans.CreatedMemberId=members.Id
                            ORDER BY  (CASE WHEN plans.`Status`='{PlanStatus.Opened}' then 0
                                            WHEN plans.`Status`='{PlanStatus.Closed}' then 1 END)
                            ,CreateTime LIMIT {limit * (page - 1)},{limit}";

            var plans = database.QueryListSQL<dynamic>(sql).ToList();

            string sqlCount = $@"SELECT COUNT(1) FROM plans";
            plansCount = database.QuerySQL<int>(sqlCount);

            return plans;
        }

        private List<dynamic> GetEffectivePlans(int page, int limit, out int plansCount)
        {
            string sql = $@"SELECT plans.Id AS PlanId,plans.`Name` AS PlanName,`Status` AS PlanStatus,CreatedMemberId,
                                   members.Photo AS CreatedMemberPhoto,CreateTime,ClosedTime
                            FROM plans
                            LEFT JOIN members ON plans.CreatedMemberId=members.Id
                            WHERE plans.`Status`<>'{PlanStatus.Closed}'
                            LIMIT {limit * (page - 1)},{limit}";

            var plans = database.QueryListSQL<dynamic>(sql).ToList();

            string sqlCount = $@"SELECT COUNT(1) FROM plans WHERE `Status`<>'{PlanStatus.Closed}'";
            plansCount = database.QuerySQL<int>(sqlCount);

            return plans;
        }

        private List<dynamic> GetTasksByPlanId(dynamic ids)
        {
            string planIds = "";
            foreach (var id in ids)
            {
                planIds += Convert.ToString(id) + ",";
            }
            planIds = planIds.TrimEnd(','); 
            string sql = $@"SELECT Id AS TaskId,`Name` AS TaskName,`Status` AS TaskStatus,DeadLineTime,PlanId, createdTime,endTime
                            FROM tasks 
                            WHERE PlanId IN ({planIds})
                            ORDER BY PlanId,Id";

            var tasks = database.QueryListSQL<dynamic>(sql).ToList();
            return tasks;
        }
        
        public JsonResult GetTasksByPlanId(int page, int limit, int planId)
        {
            string sql = $@"SELECT tasks.Id AS TaskId,tasks.`Name` AS TaskName,tasks.`Status` AS TaskStatus,tasks.CreatedTime,
                                   tasks.EndTime,DATE(tracks.FollowTime) AS LastTrackDate,tasks.DeadLineTime,tasks.MemberId
                            FROM tasks
                            LEFT JOIN (SELECT Id,TaskId,FollowTime FROM tasktrackings WHERE Id IN (
						                SELECT MAX(Id) FROM tasktrackings GROUP BY TaskId)) AS tracks ON tasks.Id=tracks.TaskId
                            WHERE tasks.PlanId = {planId}
                            ORDER BY (CASE WHEN tasks.`Status`='{TaskStatus.NotStarted}' then 0
                                        WHEN tasks.`Status`='{TaskStatus.Research}' then 0
                                        WHEN tasks.`Status`='{TaskStatus.Implement}' then 0
                                        WHEN tasks.`Status`='{TaskStatus.Testing}' then 0
                                        WHEN tasks.`Status`='{TaskStatus.Online}' then 0
                                        WHEN tasks.`Status`='{TaskStatus.Completed}' then 0
                                        WHEN tasks.`Status`='{TaskStatus.Closed}' then 1 END)
                                    ,tracks.FollowTime DESC  LIMIT {limit * (page - 1)},{limit}";

            var tasks = database.QueryListSQL<dynamic>(sql).ToList();

            var ids = tasks.Select(t => new { t.TaskId, t.LastTrackDate }).ToList();

            var tasksMembers = GetAllMembersByTaskId(ids);
            var tasksTracks = GetLastDayTrackByTaskId(ids);
            List<dynamic> result = GenerateTaskResponse(tasks, tasksMembers, tasksTracks);

            return Json(new PageResponse(result, tasks.Count));
        }
        private List<dynamic> GenerateTaskResponse(List<dynamic> tasks, List<dynamic> tasksMembers, List<dynamic> tasksTracks)
        {
            List<dynamic> result = new List<dynamic>();
            foreach (var task in tasks)
            {
                var members = tasksMembers.Where(m => m.TaskId == task.TaskId).Select(m => new { m.MemberId, m.Photo }).ToList();
                var tracks = tasksTracks.Where(t => t.TaskId == task.TaskId).Select(t => t.TrackDescription).ToList();
                result.Add(new
                {
                    task.TaskId,
                    task.TaskName,
                    task.PlanId,
                    task.PlanName,
                    task.TaskStatus,
                    task.DeadLineTime,
                    task.CreatedTime,
                    task.EndTime,
                    members,
                    tracks,
                    canTrack = CanTrackTask(task.TaskStatus),
                    canReceive = CanReceiveTask(task.TaskStatus),
                    canReview = CanReviewTask(task.TaskStatus),
                    canDelete = CanDeleteTask(task.TaskStatus)
                });
            }
            return result;
        }
        private bool CanTrackTask(string status)
        {
            var currentUser = GetCurrentUserClaim("Id");
            return !string.IsNullOrEmpty(currentUser) && status != TaskStatus.NotStarted && status != TaskStatus.Closed;
        }
        private bool CanReceiveTask(string status)
        {
            var currentUser = GetCurrentUserClaim("Id");
            return !string.IsNullOrEmpty(currentUser) && status == TaskStatus.NotStarted;
        }
        private bool CanReviewTask(string status)
        {
            var isAdmin = GetCurrentUserClaim("IsAdmin");
            return isAdmin == "True" && status == TaskStatus.Completed;
        }
        private bool CanDeleteTask(string status)
        {
            var isAdmin = GetCurrentUserClaim("IsAdmin");
            return isAdmin == "True" && status != TaskStatus.Closed;
        }


        private List<dynamic> GetAllMembersByTaskId(dynamic ids)
        {
            if (ids.Count == 0)
            {
                return new List<dynamic>();
            }
            string taskIds = "";
            foreach (var id in ids)
            {
                taskIds += Convert.ToString(id.TaskId) + ",";
            }
            taskIds = taskIds.TrimEnd(',');

            string sql = $@"SELECT AllMembers.TaskId,AllMembers.MemberId,members.Photo FROM (
                            SELECT TaskId,MemberId FROM taskpartners
                            WHERE TaskId IN ({taskIds}) 
                            UNION
                            SELECT Id AS TaskId,MemberId FROM tasks
                            WHERE Id IN ({taskIds}) AND MemberId IS NOT NULL
                            ) AS AllMembers
                            LEFT JOIN members ON AllMembers.MemberId=members.Id
                            ORDER BY AllMembers.TaskId,AllMembers.MemberId";

            var members = database.QueryListSQL<dynamic>(sql).ToList();
            return members;
        }

        private List<dynamic> GetLastDayTrackByTaskId(dynamic ids)
        {
            List<dynamic> tracks = new List<dynamic>();
            int taskId = 0;
            string trackDate = "";
            foreach (var id in ids)
            {
                taskId = Convert.ToInt32(id.TaskId);
                trackDate = Convert.ToString(id.LastTrackDate);

                string sql = $@"SELECT TaskId,CONCAT('（',FollowTime,'）',
                                members.`Name`,'：',IFNULL(FollowDescription,FollowType)) AS TrackDescription
                                FROM tasktrackings
                                LEFT JOIN members ON tasktrackings.FollowerId=members.Id
                                WHERE TaskId = {taskId} AND FollowTime BETWEEN '{trackDate}' 
                                      AND DATE_ADD('{trackDate}',INTERVAL 1 DAY)
                                ORDER BY TaskId";
                var trackInfo = database.QueryListSQL<dynamic>(sql).ToList();
                tracks.AddRange(trackInfo);
            }

            return tracks;
        }

        public JsonResult ClosePlan(int planId)
        {
            string sql = $@"UPDATE plans SET `Status`='{PlanStatus.Closed}',ClosedTime=NOW(),LastUpdateTime=NOW() 
                            WHERE Id ={planId}";
            var operateResult = database.TransactionExecuteSQL(sql);
            string message = "";
            if (!operateResult)
            {
                message = "关闭失败，请重试！";
            }
            return Json(new { result = operateResult, message });
        }

        [HttpPost]
        public JsonResult DeletePlan(int planId)
        {
            var operateResult = database.RunInTransaction(() =>
            {
                database.TransactionExecuteSQL($@"DELETE FROM plans  WHERE Id ={planId}");
                database.TransactionExecuteSQL($@"DELETE FROM tasks  WHERE PlanId ={planId}");
            });
            string message = "";
            if (!operateResult)
            {
                message = "删除失败，请重试！";
            }
            return Json(new { result = operateResult, message });
        }

        [HttpPost]
        public JsonResult SavePlan(int planId, string planName, string planStatus, string remark)
        {
            string sql = $@"UPDATE plans SET `Status`='{planStatus}',`Name`='{planName}',Remark='{remark}',LastUpdateTime=NOW()";
            if (planStatus == PlanStatus.Closed)
            {
                sql = sql + ",ClosedTime=NOW()";
            }
            sql += $@"  WHERE Id ={planId}";
            var operateResult = database.TransactionExecuteSQL(sql);
            string message = "";
            if (!operateResult)
            {
                message = "保存失败，请重试！";
            }

            var plan = database.QuerySQL<dynamic>($@"SELECT Id,`Name`,`Status`,ClosedTime,Remark
                                                     FROM plans WHERE Id={planId}");

            return Json(new { result = operateResult, message, plan });
        }

        public IActionResult RelateTask(int planId)
        {
            ViewBag.PlanId = planId;
            return View();
        }

        public JsonResult GetNotRelateTask(int page, int limit)
        {
            string sql = $@"SELECT Id,`Name` AS taskName,`Status` AS taskStatus
                            FROM tasks
                            WHERE PlanId IS NULL
                            LIMIT {limit * (page - 1)},{limit}";
            List<dynamic> tasks = database.QueryListSQL<dynamic>(sql).ToList();
            var taskCount = database.Single<int>(@"SELECT COUNT(Id) FROM tasks WHERE PlanId IS NULL");
            return Json(new PageResponse(tasks, taskCount));
        }

        public JsonResult SetRelateTaskByPlanId(int planId, string tasksId)
        {
            string sql = $@"UPDATE tasks SET PlanId={planId} WHERE Id IN ({tasksId})";
            var result = database.ExecuteSQL(sql);
            if (result)
            {
                return Json(new { result, message = "" });
            }
            else
            {
                return Json(new { result, message = "关联失败，请重试！" });
            }
        }

        [HttpPost]
        public JsonResult RemoveRelateTaskByPlan(int planId, int taskId)
        {
            string sql = $@"UPDATE tasks SET PlanId=NULL WHERE Id={taskId} AND PlanId={planId}";
            var result = database.ExecuteSQL(sql);
            if (result)
            {
                return Json(new { result, message = "" });
            }
            else
            {
                return Json(new { result, message = "解除关联失败，请重试！" });
            }
        }
    }
}