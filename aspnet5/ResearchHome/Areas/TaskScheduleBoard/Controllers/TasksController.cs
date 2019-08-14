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
    public class TasksController : BaseController
    {
        private readonly IDatabase m_database;

        public TasksController(IDatabase database)
        {
            this.m_database = database;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult CreateTask(int? planId)
        {
            ViewBag.PlanId = planId;
            ViewBag.CurrentUserId = GetCurrentUserClaim("Id");
            return View();
        }

        [HttpPost]
        public IActionResult CreateTask(CreateTaskRequestModel request)
        {
            var memberId = GetCurrentUserClaim("Id");
            var dateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            var result = m_database.TransactionInsertSQL("Tasks",
                                               new DataColumn("Name", request.TaskName),
                                               new DataColumn("Description", request.Description),
                                               new DataColumn("MemberId", request.Principal),
                                               new DataColumn("Status", TaskStatus.NotStarted),
                                               new DataColumn("CreatedTime", dateTime),
                                               new DataColumn("CreatedMemberId", memberId),
                                               new DataColumn("Priority", request.Priority),
                                               new DataColumn("DeadLineTime", request.DeadLineTime),
                                               new DataColumn("PlanId", request.PlanId));
            if (!result)
            {
                TempData["Message"] = "parent.layer.msg('创建失败,请重试！！',{icon: 5,shift: -1, time: 500});";
            }
            else
            {
                var taskId = m_database.QuerySQL<int>("SELECT MAX(Id) AS Id FROM Tasks");
                AddTaskTracking(m_database, taskId, "创建任务：" + request.TaskName, "创建任务");
                TempData["Message"] = @"parent.layer.msg('创建成功!', { icon: 6,shift: -1, time: 500, shade: 0.3},
                                            function() { parent.layer.closeAll(); })";
            }
            return View();
        }

        public IActionResult GetTaskDetail(int taskId)
        {
            string sql = $@"SELECT tasks.Id,Score,tasks.`Name`,`Status`,MemberId AS PrincipalId,m1.`Name` AS PrincipalName
                            ,CreatedMemberId,m2.`Name` AS CreatedMemberName,ScoreApportioned AS IsReview
                            ,CreatedTime,DeadLineTime,StartTime,EndTime,Description,tracks.FollowTime,tasks.Priority
                            FROM tasks
                            LEFT JOIN members AS m1 ON tasks.MemberId=m1.Id
                            LEFT JOIN members AS m2 ON tasks.CreatedMemberId=m2.Id
                            LEFT JOIN (SELECT Id,TaskId,FollowTime FROM tasktrackings WHERE Id IN (
						      SELECT MAX(Id) FROM tasktrackings GROUP BY TaskId)) AS tracks ON tasks.Id=tracks.TaskId
                            WHERE tasks.Id={taskId}";
            var taskDetailModel = m_database.QuerySQL<TaskDetailModel>(sql);

            string sqlForParticipants = $@"SELECT group_concat(taskpartners.MemberId) AS Id
                                           FROM taskpartners
                                           LEFT JOIN members ON taskpartners.MemberId=members.Id
                                           WHERE TaskId={taskId}  ";
            var participants = m_database.QuerySQL<string>(sqlForParticipants);

            taskDetailModel.Participants = participants;
            taskDetailModel.CanEdit = 0;
            var currentUser = GetCurrentUserClaim("Id");
            List<string> allMember = new List<string>();
            if (!string.IsNullOrWhiteSpace(participants))
            {
                allMember = participants.Split(',').ToList();
            }
            if (taskDetailModel.PrincipalId != null)
            {
                allMember.Add(taskDetailModel.PrincipalId.ToString());
            }
            if (allMember.IndexOf(currentUser) != -1 || GetCurrentUserClaim("IsAdmin") == "True")
            {
                taskDetailModel.CanEdit = 1;
            }
            return View(taskDetailModel);
        }

        public JsonResult GetKanbanTasks()
        {
            string sql = $@"SELECT tasks.Id,tasks.`Name`,tasks.`Status`,tasks.MemberId AS Leader,
                            Date(tracks.FollowTime) AS LastTrackTime,m1.Photo,tasks.DeadLineTime,tasks.Priority
						    FROM `tasks`
						    LEFT JOIN (SELECT Id,FollowerId,TaskId,FollowTime,FollowDescription FROM tasktrackings WHERE Id IN (
						    SELECT MAX(Id) FROM tasktrackings GROUP BY TaskId)) AS tracks ON tasks.Id=tracks.TaskId
						    LEFT JOIN members AS m1 ON tasks.MemberId=m1.Id
                            ORDER BY tasks.DeadLineTime DESC";
            var tasks = m_database.QueryListSQL<dynamic>(sql);
            List<dynamic> tasksResult = new List<dynamic>();
            Dictionary<string, string> allStatus = new Dictionary<string, string>()
            {
                {TaskStatus.NotStarted,"orange" },
                {TaskStatus.Research,"purple" },
                {TaskStatus.Implement,"purple" },
                {TaskStatus.Testing,"purple" },
                {TaskStatus.Online,"purple" },
                {TaskStatus.Completed,"green" }
            };
            string[] onGoingStatus = { TaskStatus.Research, TaskStatus.Implement, TaskStatus.Testing, TaskStatus.Online };
            foreach (var status in allStatus)
            {
                List<dynamic> cardList = new List<dynamic>();
                var taskOnStatus = tasks.Where(task => task.Status == status.Key).ToList();
                var taskCount = taskOnStatus.Count;
                GenerateKanBanColumnTasks(taskOnStatus, status, onGoingStatus, ref cardList);
                tasksResult.Add(new { status = status.Key, taskCount, cardList });
            }
            return Json(tasksResult);
        }

        private void GenerateKanBanColumnTasks(List<dynamic> taskOnStatus, KeyValuePair<string, string> status,
            string[] onGoingStatus, ref List<dynamic> cardList)
        {
            foreach (var task in taskOnStatus)
            {
                var taskColor = status.Value;
                if (onGoingStatus.Contains(status.Key))
                {
                    var deadLineTime = Convert.ToDateTime(task.DeadLineTime);
                    if (deadLineTime < DateTime.Now)
                    {
                        taskColor = "red";
                    }
                    else if (deadLineTime < DateTime.Now.AddDays(15))
                    {
                        taskColor = "deepPurple";
                    }
                }
                cardList.Add(new
                {
                    taskName = task.Name,
                    taskId = task.Id,
                    memberId = task.Leader,
                    memberImage = task.Photo,
                    lastTrackTime = Convert.ToDateTime(task.LastTrackTime).ToString("yyyy-MM-dd"),
                    taskColor,
                    taskPriority = task.Priority
                });
            }
            cardList = cardList.OrderByDescending(r => Convert.ToDateTime(r.lastTrackTime)).ToList();
        }

        public JsonResult GetTaskMember()
        {
            string sql = @"SELECT Id,`Name` FROM members WHERE IsLeave=0";
            var result = m_database.QueryListSQL<dynamic>(sql);
            return Json(new PageResponse(result));
        }

        private List<dynamic> GetSearchTasks(int search, int page, int limit, out int tasksCount)
        {
            var memberId = search;
            string sql = $@"SELECT tasks.Id AS TaskId,tasks.`Name` AS TaskName,tasks.PlanId ,plans.`Name` AS PlanName,
                                   tasks.`Status` AS TaskStatus,tasks.DeadLineTime,DATE(tracks.FollowTime) AS LastTrackDate,
                                   tasks.MemberId
                            FROM tasks
                            LEFT JOIN (SELECT Id,TaskId,FollowTime FROM tasktrackings WHERE Id IN (
						                SELECT MAX(Id) FROM tasktrackings GROUP BY TaskId)) AS tracks ON tasks.Id=tracks.TaskId
                            LEFT JOIN plans ON tasks.PlanId=plans.Id

                            WHERE (MemberId = {memberId} OR EXISTS( SELECT MemberId FROM Taskpartners
                                        WHERE MemberId = {memberId} AND TaskId = tasks.Id ))
                            ORDER BY (CASE WHEN tasks.`Status`='{TaskStatus.NotStarted}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Research}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Implement}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Testing}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Online}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Completed}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Closed}' then 1 END)
                                           ,tracks.FollowTime DESC LIMIT {limit * (page - 1)},{limit}";
            var tasks = m_database.QueryListSQL<dynamic>(sql).ToList();

            string sqlCount = $@"SELECT COUNT(1) FROM Tasks
                                 WHERE MemberId = {memberId}
                                        OR EXISTS(SELECT MemberId FROM Taskpartners
                                                  WHERE MemberId = {memberId} AND TaskId = tasks.Id )";
            tasksCount = m_database.QuerySQL<int>(sqlCount);
            return tasks;
        }

        public JsonResult GetTasks(int page, int limit, string queryType, int search)
        {
            var tasks = new List<dynamic>();
            int resultCount = 0;
            if (search > 0)
            {
                tasks = GetSearchTasks(search, page, limit, out resultCount);
            }
            else
            {
                switch (queryType)
                {
                    case "notClosedTask":
                        tasks = GetNotClosedTasks(page, limit, out resultCount);
                        break;

                    case "allTask":
                        tasks = GetAllTasks(page, limit, out resultCount);
                        break;

                    case "participateTask":
                        tasks = GetParticipateTasks(page, limit, out resultCount);
                        break;

                    default:
                        tasks = GetAllTasks(page, limit, out resultCount);
                        break;
                }
            }
            //通过任务id，获取任务参与人信息
            //通过任务id，获取最后一天跟进信息
            var ids = tasks.Select(t => new { t.TaskId, t.LastTrackDate }).ToList();
            var tasksMembers = GetAllMembersByTaskId(ids);
            var tasksTracks = GetLastDayTrackByTaskId(ids);
            List<dynamic> result = GenerateTaskResponse(tasks, tasksMembers, tasksTracks);
            return Json(new PageResponse(result, resultCount));
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

        private List<dynamic> GetNotClosedTasks(int page, int limit, out int tasksCount)
        {
            string sql = $@"SELECT tasks.Id AS TaskId,tasks.`Name` AS TaskName,tasks.PlanId ,plans.`Name` AS PlanName,
                                   tasks.`Status` AS TaskStatus,tasks.DeadLineTime,DATE(tracks.FollowTime) AS LastTrackDate,
                                   tasks.MemberId
                            FROM tasks
                            LEFT JOIN (SELECT Id,TaskId,FollowTime FROM tasktrackings WHERE Id IN (
						                 SELECT MAX(Id) FROM tasktrackings GROUP BY TaskId)) AS tracks ON tasks.Id=tracks.TaskId
                            LEFT JOIN plans ON tasks.PlanId=plans.Id
                            WHERE tasks.`Status` <> '{TaskStatus.Closed}'
                            ORDER BY tracks.FollowTime DESC
                            LIMIT {limit * (page - 1)},{limit}";

            var tasks = m_database.QueryListSQL<dynamic>(sql).ToList();

            string sqlCount = $@"SELECT COUNT(1) FROM Tasks WHERE tasks.`Status` <> '{TaskStatus.Closed}'";
            tasksCount = m_database.QuerySQL<int>(sqlCount);

            return tasks;
        }

        private List<dynamic> GetAllTasks(int page, int limit, out int tasksCount)
        {
            string sql = $@"SELECT tasks.Id AS TaskId,tasks.`Name` AS TaskName,tasks.PlanId ,plans.`Name` AS PlanName,
                                   tasks.`Status` AS TaskStatus,tasks.DeadLineTime,DATE(tracks.FollowTime) AS LastTrackDate,
                                   tasks.MemberId
                            FROM tasks
                            LEFT JOIN (SELECT Id,TaskId,FollowTime FROM tasktrackings WHERE Id IN (
						                 SELECT MAX(Id) FROM tasktrackings GROUP BY TaskId)) AS tracks ON tasks.Id=tracks.TaskId
                            LEFT JOIN plans ON tasks.PlanId=plans.Id
                            ORDER BY (CASE WHEN tasks.`Status`='{TaskStatus.NotStarted}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Research}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Implement}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Testing}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Online}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Completed}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Closed}' then 1 END)
                                           ,tracks.FollowTime DESC LIMIT {limit * (page - 1)},{limit}";

            var tasks = m_database.QueryListSQL<dynamic>(sql).ToList();

            string sqlCount = $@"SELECT COUNT(1) FROM Tasks ";
            tasksCount = m_database.QuerySQL<int>(sqlCount);

            return tasks;
        }

        private List<dynamic> GetParticipateTasks(int page, int limit, out int tasksCount)
        {
            var memberId = GetCurrentUserClaim("Id");
            string sql = $@"SELECT tasks.Id AS TaskId,tasks.`Name` AS TaskName,tasks.PlanId ,plans.`Name` AS PlanName,
                                   tasks.`Status` AS TaskStatus,tasks.DeadLineTime,DATE(tracks.FollowTime) AS LastTrackDate,
                                   tasks.MemberId
                            FROM tasks
                            LEFT JOIN (SELECT Id,TaskId,FollowTime FROM tasktrackings WHERE Id IN (
						                SELECT MAX(Id) FROM tasktrackings GROUP BY TaskId)) AS tracks ON tasks.Id=tracks.TaskId
                            LEFT JOIN plans ON tasks.PlanId=plans.Id

                            WHERE (MemberId = {memberId} OR EXISTS( SELECT MemberId FROM Taskpartners
                                        WHERE MemberId = {memberId} AND TaskId = tasks.Id ))
                            ORDER BY (CASE WHEN tasks.`Status`='{TaskStatus.NotStarted}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Research}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Implement}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Testing}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Online}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Completed}' then 0
                                           WHEN tasks.`Status`='{TaskStatus.Closed}' then 1 END)
                                           ,tracks.FollowTime DESC LIMIT {limit * (page - 1)},{limit}";
            var tasks = m_database.QueryListSQL<dynamic>(sql).ToList();

            string sqlCount = $@"SELECT COUNT(1) FROM Tasks
                                 WHERE MemberId = {memberId}
                                        OR EXISTS(SELECT MemberId FROM Taskpartners
                                                  WHERE MemberId = {memberId} AND TaskId = tasks.Id )";
            tasksCount = m_database.QuerySQL<int>(sqlCount);
            return tasks;
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

            var members = m_database.QueryListSQL<dynamic>(sql).ToList();
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

                string sql = $@"SELECT TaskId,CONCAT('（',FollowTime,'）',members.`Name`,'：'
                                ,IFNULL(FollowDescription,FollowType)) AS TrackDescription
                            FROM tasktrackings
                            LEFT JOIN members ON tasktrackings.FollowerId=members.Id
                            WHERE TaskId = {taskId} AND FollowTime BETWEEN '{trackDate}'
                                  AND DATE_ADD('{trackDate}',INTERVAL 1 DAY)
                            ORDER BY TaskId";
                var trackInfo = m_database.QueryListSQL<dynamic>(sql).ToList();
                tracks.AddRange(trackInfo);
            }

            return tracks;
        }

        [HttpPost]
        public JsonResult SaveTask(SaveTaskRequestModel request)
        {
            bool operateResult = true;
            string message = "";
            if (request.TaskStatus != TaskStatus.NotStarted && request.TaskStatus != TaskStatus.Research && request.TaskStatus != TaskStatus.Implement)
            {
                string sqlCountKeyResult = $@"SELECT COUNT(*) FROM keyresults
                                              WHERE TaskId={request.TaskId} AND`Status` != '{TaskStatus.Closed}'";
                int count = m_database.QuerySQL<int>(sqlCountKeyResult);
                if (count > 0)
                {
                    operateResult = false;
                    message = "保存失败!：请先关闭所有关键结果！";
                    return Json(new { result = operateResult, message });
                }
            }
            SaveUpdateTask(request, ref operateResult);
            if (operateResult)
            {
                AddTaskTracking(m_database, request.TaskId, null, "修改任务");
            }
            message = operateResult ? "" : "保存失败!请重试！";
            return Json(new { result = operateResult, message });
        }

        private void SaveUpdateTask(SaveTaskRequestModel request, ref bool operateResult)
        {
            string sqlStartTimeResult = $@"SELECT StartTime,EndTime FROM tasks
                                             WHERE Id = { request.TaskId }";
            string sql = $@"UPDATE tasks
                            SET `Name`='{request.TaskName}',Description='{request.TaskRemark}',MemberId={request.Principal},
                            `Status`='{request.TaskStatus}',Priority={request.TaskPriority ?? 3},
                            DeadLineTime='{request.DeadLineTime}'";
            var trackInfo = m_database.QueryListSQL<dynamic>(sqlStartTimeResult).ToList();
            if (request.TaskStatus != TaskStatus.NotStarted && trackInfo[0].StartTime == null)
            {
                sql += $@",StartTime='{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}'";
            }
            if ((request.TaskStatus == TaskStatus.Completed)
                                                            && trackInfo[0].EndTime == null)
            {
                sql += $@",EndTime='{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}'";
            }
            sql += $@"WHERE Id={request.TaskId}";
            m_database.TransactionExecuteSQL(sql);
            UpdateParticipants(request.TaskId, request.Participants);
        }

        private void UpdateParticipants(int taskId, string participants)
        {
            if (string.IsNullOrWhiteSpace(participants))
            {
                m_database.ExecuteSQL($@"DELETE FROM Taskpartners  WHERE TaskId = {taskId}");
                return;
            }
            string[] taskParticipants = participants.Split(',');
            foreach (var participant in taskParticipants)
            {
                m_database.ExecuteSQL($@"DELETE FROM Taskpartners
                                       WHERE TaskId = {taskId} AND MemberId NOT IN ({participants})");
                var isExistedSql = $@"SELECT COUNT(1) FROM Taskpartners WHERE MemberId = {participant} AND TaskId = {taskId}";
                var isExisted = m_database.QuerySQL<int>(isExistedSql) > 0;
                var result = false;
                if (isExisted)
                {
                    result = m_database.UpdateSQL("Taskpartners",

                        new DataColumn("MemberId", participant, true),
                        new DataColumn("TaskId", taskId, true));
                }
                else
                {
                    result = m_database.InsertSQL("Taskpartners",
                        new DataColumn("MemberId", participant),
                        new DataColumn("TaskId", taskId),
                        new DataColumn("CreatedTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
                }
            }
        }

        [HttpPost]
        public JsonResult GetTaskTrackings(int taskId, int page, int limit, bool onlyMy)
        {
            string queryTypeSection = "";
            if (onlyMy)
            {
                queryTypeSection += $@" AND FollowerId={GetCurrentUserClaim("Id")} ";
            }
            var tasktrackingsModel = m_database.QueryListSQL<TasktrackingsModel>(
                                 $@"SELECT TaskId,FollowerId,Members.Name AS Follower,FollowTime,
                                        FollowDescription,FollowType FROM TaskTrackings
                                    LEFT JOIN Members
                                    ON TaskTrackings.FollowerId = Members.Id
                                    WHERE TaskId = {taskId} {queryTypeSection}
                                    ORDER BY FollowTime DESC LIMIT {limit * (page - 1)},{limit}");
            return Json(tasktrackingsModel);
        }

        [HttpPost]
        public JsonResult GetTaskTrackingsCount(int taskId, bool onlyMy)
        {
            string sql = $@"SELECT COUNT(*) FROM TaskTrackings WHERE TaskId = {taskId}";
            if (onlyMy)
            {
                sql += $@" AND FollowerId={GetCurrentUserClaim("Id")}";
            }
            var trackingsCount = m_database.Single<int>(sql);
            return Json(new { trackingsCount });
        }

        [HttpPost]
        public JsonResult RecieveTask(int taskId)
        {
            var memberId = GetCurrentUserClaim("Id");
            var dateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            var operateResult = m_database.RunInTransaction(() =>
            {
                m_database.TransactionUpdateSQL("tasks",
                        new DataColumn("MemberId", memberId),
                        new DataColumn("LastUpdateTime", dateTime),
                        new DataColumn("Id", taskId, true));

                m_database.TransactionInsertSQL("tasktrackings",
                            new DataColumn("TaskId", taskId),
                            new DataColumn("FollowerId", memberId),
                            new DataColumn("FollowTime", dateTime),
                            new DataColumn("FollowType", "领取任务"));
            });

            string message = "";
            if (!operateResult)
            {
                message = "领取失败，请重试！";
            }
            return Json(new { result = operateResult, message });
        }

        [HttpPost]
        public JsonResult DeleteTask(int taskId)
        {
            var memberId = GetCurrentUserClaim("Id");
            var dateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");

            var operateResult = m_database.RunInTransaction(() =>
            {
                m_database.ExecuteSQL($"DELETE FROM tasks WHERE Id = {taskId}");
                m_database.ExecuteSQL($"DELETE FROM tasktrackings WHERE TaskId = {taskId}");
                m_database.ExecuteSQL($"DELETE FROM task_feedback WHERE task_id = {taskId}");
                m_database.ExecuteSQL($"DELETE FROM taskreviews WHERE TaskId = {taskId}");
                m_database.ExecuteSQL($"DELETE FROM todos WHERE TaskId = {taskId}");
            });

            string message = "";
            if (!operateResult)
            {
                message = "领取失败，请重试！";
            }
            return Json(new { result = operateResult, message });
        }

        #region 任务点评

        public IActionResult ReviewTask(int taskId)
        {
            string sql = $@"SELECT tasks.`Name`,members.`Name` AS Leader,StartTime,DeadLineTime,EndTime,Score,ScoreApportioned,
                            taskreviews.PerfectFunction,taskreviews.StrongAspect,taskreviews.TroubleFunction,
                            taskreviews.WeaknessAspect       FROM tasks
                            LEFT JOIN members ON tasks.MemberId=members.Id
                            LEFT JOIN taskreviews ON tasks.Id=taskreviews.TaskId     WHERE tasks.Id={taskId}";
            var task = m_database.QuerySQL<dynamic>(sql);
            string perfectFunction = "", strongAspect = "", troubleFunction = "", weaknessAspect = "";
            if (Convert.ToInt32(task.ScoreApportioned) == 0)
            {
                FeedBackToReview(taskId, out perfectFunction, out troubleFunction, out strongAspect, out weaknessAspect);
            }
            string sqlKeyResult = $@"SELECT CONCAT((@i:=@i+1),'. ',Description) AS KeyResultDescription
                                    FROM keyresults,(SELECT @i := 0) AS it
                                    WHERE TaskId={taskId}  ORDER BY CreateTime";
            var keyResults = m_database.QueryListSQL<string>(sqlKeyResult).ToList();
            var reviewTaskViewModel = new TaskReviewModel
            {
                TaskId = taskId,
                TaskName = task.Name,
                Leader = task.Leader,
                StartTime = task.StartTime,
                DeadLineTime = task.DeadLineTime,
                EndTime = task.EndTime,
                Score = task.Score,
                KeyResults = keyResults,
                PerfectFunction = String.IsNullOrEmpty(perfectFunction) ? task.PerfectFunction : perfectFunction,
                StrongAspect = String.IsNullOrEmpty(strongAspect) ? task.StrongAspect : strongAspect,
                TroubleFunction = String.IsNullOrEmpty(troubleFunction) ? task.TroubleFunction : troubleFunction,
                WeaknessAspect = String.IsNullOrEmpty(weaknessAspect) ? task.WeaknessAspect : weaknessAspect,
                PersonalContributions = GetPersonalContribution(taskId),
                IsReview = Convert.ToInt32(task.ScoreApportioned),
            };
            return View(reviewTaskViewModel);
        }

        private void FeedBackToReview(int taskId, out string perfectFunction, out string troubleFunction,
                                                  out string strongAspect, out string weaknessAspect)
        {
            perfectFunction = ""; strongAspect = ""; troubleFunction = ""; weaknessAspect = "";
            List<dynamic> feedbacks = new List<dynamic>();
            string feedbackSql = $@"SELECT description,type FROM task_feedback   WHERE task_id={taskId}";
            feedbacks = m_database.QueryListSQL<dynamic>(feedbackSql).ToList();

            foreach (var feedback in feedbacks)
            {
                if (feedback.type == 1)
                {
                    perfectFunction += "\r\n" + feedback.description + "；";
                }
                if (feedback.type == 2)
                {
                    troubleFunction += "\r\n" + feedback.description + "；";
                }
                if (feedback.type == 3)
                {
                    strongAspect += "\r\n" + feedback.description + "；";
                }
                if (feedback.type == 4)
                {
                    weaknessAspect += "\r\n" + feedback.description + "；";
                }
            }
        }

        private List<PersonalTodos> GetPersonalContribution(int taskId)
        {
            string sql = $@"SELECT AllMembers.MemberId AS ExecutorId,members.`Name` AS ExecutorName,tds1.Id,tds1.Description,tds1.Integral AS ReviewScore,todocount
                            FROM (
                                    SELECT MemberId FROM taskpartners
                                    WHERE TaskId ={taskId}
                                    UNION ALL
                                    SELECT MemberId FROM tasks
                                    WHERE Id={taskId}
                                 ) AS AllMembers
                            LEFT JOIN (SELECT Executor,count(*) AS todocount FROM todos WHERE TaskId={taskId}
                                       GROUP BY Executor) AS tds ON AllMembers.MemberId=tds.Executor
                            LEFT JOIN (SELECT * FROM integrals WHERE SourceId={taskId}) AS tds1 ON AllMembers.MemberId=tds1.MemberId
                            LEFT JOIN members ON AllMembers.MemberId=members.Id
                            ORDER BY ExecutorId";
            var todos = m_database.QueryListSQL<dynamic>(sql);

            var todosGroup = from todo in todos
                             group todo by new { todo.ExecutorId, todo.ExecutorName, todo.ReviewScore, todo.Description, todo.todocount };
            List<PersonalTodos> personalContribution = new List<PersonalTodos>();
            foreach (var tg in todosGroup)
            {
                PersonalTodos personalTodos = new PersonalTodos();
                personalTodos.ExecutorId = tg.Key.ExecutorId;
                personalTodos.ExecutorName = tg.Key.ExecutorName;
                personalTodos.ReviewComment = tg.Key.Description;
                personalTodos.ReviewScore = tg.Key.ReviewScore;
                personalTodos.FinishTodoCount = tg.Key.todocount ?? 0;
                personalContribution.Add(personalTodos);
            }

            return personalContribution;
        }

        [HttpPost]
        public JsonResult GetReviewTaskTodos(int taskId, string executorName, int page, int limit)
        {
            string sql = $@"SELECT AllMembers.MemberId AS ExecutorId,members.`Name` AS ExecutorName,tds.Id,tds.Description
                            FROM (
                                    SELECT MemberId FROM taskpartners
                                    WHERE TaskId ={taskId}
                                    UNION ALL
                                    SELECT MemberId FROM tasks
                                    WHERE Id={taskId}
                                 ) AS AllMembers
                            LEFT JOIN (SELECT * FROM todos WHERE TaskId={taskId}) AS tds ON AllMembers.MemberId=tds.Executor
                            LEFT JOIN members ON AllMembers.MemberId=members.Id
                            ORDER BY ExecutorId  LIMIT {limit * (page - 1)},{limit}";

            var todos = m_database.QueryListSQL<dynamic>(sql);
            todos = from s in todos
                    where s.ExecutorName == executorName
                    select s;

            return Json(todos);
        }

        public JsonResult AddContributionStandard(ContributionStandardModel parent, string contributionStandardName)
        {
            string sql = $@"INSERT INTO contribution_standard(ParentId,Name,Level,CreatedTime)
                            VALUES({parent.Id},'{contributionStandardName}',{parent.Level + 1},NOW())";
            var result = m_database.ExecuteSQL(sql);
            string message = "";
            if (result)
            {
                message = "添加成功！";
            }
            else
            {
                message = "添加失败，请重试";
            }
            return Json(new { result, message });
        }

        public IActionResult GrantMedal(int taskId, int grantType)
        {
            string isForeign = "";
            if (grantType == 2)
            {
                isForeign = " AND Id=14 ";
            }
            string sql = $@"SELECT Id,Icon,Name,Description,Grade
                            FROM medals WHERE IsDiscard = 0 {isForeign}
                            ORDER BY CreatedTime DESC";
            var medals = m_database.QueryListSQL<dynamic>(sql).ToList();
            ViewBag.TaskId = taskId;
            ViewBag.GrantType = grantType;
            ViewBag.Medals = medals;
            return View();
        }

        [HttpPost]
        public JsonResult SaveMemberMedals(int taskId, int memberId, string reason, string medalIds, int grantType)
        {
            string[] memberMedalIds = medalIds.Split(',');

            var result = m_database.RunInTransaction(() =>
            {
                string sql = "";
                foreach (var medalId in memberMedalIds)
                {
                    sql = $@"INSERT INTO membermedals(MemberId, MedalId, Reason, GainDate, TaskId, GainType)
                            VALUES ({memberId}, {medalId},  '{reason}', NOW(), {taskId}, {grantType})";
                    m_database.ExecuteSQL(sql);
                }
            });

            string message = "";
            if (!result)
            {
                message = "保存失败，请重试！";
            }
            return Json(new { result, message });
        }

        [HttpPost]
        public JsonResult ClearMedal(int taskId)
        {
            string sql = $@"DELETE FROM membermedals WHERE TaskId = {taskId}";
            var result = m_database.ExecuteSQL(sql);
            string message = "";
            if (!result)
            {
                message = "保存失败，导入数据库错误！";
            }
            return Json(new { result, message });
        }

        public JsonResult GetMemberMedals(int taskId, int grantType)
        {
            string sql = $@"SELECT membermedals.Id,MemberId,members.Photo,MedalId,medals.Icon
                          FROM membermedals
                          LEFT JOIN members ON membermedals.MemberId=members.Id
                          LEFT JOIN medals ON membermedals.MedalId=medals.Id
                          WHERE membermedals.TaskId={taskId} AND membermedals.GainType={grantType}
                          ORDER BY membermedals.GainDate";
            var membersMedals = m_database.QueryListSQL<dynamic>(sql);

            var query = from memberMedals in membersMedals
                        group memberMedals by new { memberMedals.MemberId, memberMedals.Photo };

            List<dynamic> allMemberMedals = new List<dynamic>();
            foreach (var memberMedals in query)
            {
                var memberId = memberMedals.Key.MemberId;
                var memberPhoto = memberMedals.Key.Photo;
                List<dynamic> personalMedals = new List<dynamic>();
                foreach (var medal in memberMedals)
                {
                    personalMedals.Add(new { medalId = medal.MedalId, medalIcon = medal.Icon });
                }
                allMemberMedals.Add(new { memberId, memberPhoto, personalMedals });
            }
            return Json(allMemberMedals);
        }

        [HttpPost]
        public JsonResult UpdateTaskReviews(int taskId, string perfectFunction, string troubleFunction, string strongAspect, string weaknessAspect)
        {
            string updateTasksSql = $@"UPDATE taskreviews SET perfectFunction='{perfectFunction}',troubleFunction='{troubleFunction}',
                                                        strongAspect='{strongAspect}',weaknessAspect='{weaknessAspect}'
                                       WHERE Id={taskId}";
            bool result = m_database.ExecuteSQL(updateTasksSql);
            string message = "";
            if (!result)
            {
                message = "保存失败，请重试！";
            }
            return Json(new { result, message });
        }

        [HttpPost]
        public JsonResult SaveTaskReview(TaskReviewResult taskReviewResult)
        {
            var result = m_database.RunInTransaction(() =>
            {
                string sql = $@"INSERT INTO taskreviews (TaskId, PerfectFunction, TroubleFunction, StrongAspect, WeaknessAspect)
                                VALUES ({taskReviewResult.TaskId}, '{taskReviewResult.PerfectFunction}',
                '{taskReviewResult.TroubleFunction}', '{taskReviewResult.StrongAspect}', '{taskReviewResult.WeaknessAspect}')";
                m_database.ExecuteSQL(sql);
                string updateTasksSql = $@"UPDATE tasks SET ScoreApportioned=1,Score={taskReviewResult.TotalScore}
                                           WHERE Id={taskReviewResult.TaskId}";
                m_database.ExecuteSQL(updateTasksSql);
                foreach (var member in taskReviewResult.Members)
                {
                    string endTimeSql = $@"SELECT EndTime FROM tasks WHERE Id={taskReviewResult.TaskId}";
                    DateTime endTime = m_database.Single<DateTime>(endTimeSql);
                    string insertIntegralsSql = $@"INSERT INTO integrals (MemberId, CreatedTime, Integral, Description,SourceId,SourceType)
                                                   VALUES ({member.Id}, '{endTime.ToString()}', {member.ReviewScore}, '{member.ReviewComment}',
                                                           {taskReviewResult.TaskId}, 'Tasks')";
                    m_database.ExecuteSQL(insertIntegralsSql);
                    string insertIntegralsSql1 = $@"SELECT AnnualIntegral from annualintegrals
                                                    WHERE MemberId={member.Id} AND Years={DateTime.Now.Year}";
                    int AnnualIntegral = m_database.Single<int>(insertIntegralsSql1);
                    UpdateScores(AnnualIntegral, member.Id, member.ReviewScore);
                }
            });
            string message = "";
            if (!result)
            {
                message = "保存失败，请重试！";
            }
            return Json(new { result, message });
        }

        private void UpdateScores(int AnnualIntegral, int id, string ReviewScore)
        {
            //更新点评积分，年度积分，总积分
            if (AnnualIntegral == 0)
            {
                string insertIntegralsSql2 = $@"INSERT INTO annualintegrals (MemberId, Years, AnnualIntegral, UpdatedTime)
                                                        VALUES ({id}, {DateTime.Now.Year}, {ReviewScore}, NOW())";
                m_database.ExecuteSQL(insertIntegralsSql2);
            }
            else
            {
                int newScore = int.Parse(ReviewScore) + AnnualIntegral;
                string updateIntegralsSql = $@"UPDATE annualintegrals SET AnnualIntegral={newScore}
                                                       WHERE MemberId={id} AND Years={DateTime.Now.Year}";
                m_database.ExecuteSQL(updateIntegralsSql);
            }
            string totalScoresql = $@"select TotalIntegral from members WHERE Id={id}";
            int? totalScore = m_database.Single<int?>(totalScoresql);
            totalScore += int.Parse(ReviewScore);
            string updateTotalIntegralsSql = $@"UPDATE members SET TotalIntegral={totalScore}
                                                        WHERE Id={id}";
            m_database.ExecuteSQL(updateTotalIntegralsSql);
        }

        #endregion 任务点评

        #region 跟进

        public IActionResult TrackingTask(int taskId)
        {
            ViewBag.TaskId = taskId;
            return View();
        }

        [HttpPost]
        public IActionResult TrackingTask(int taskId, string description)
        {
            var memberId = GetCurrentUserClaim("Id");
            if (string.IsNullOrEmpty(memberId))
            {
                TempData["Message"] = "parent.layer.msg('请登录!',{icon: 5,shift: -1, time: 500});";
            }
            var taskDbStatus = m_database.QuerySQL<string>($@"SELECT Status FROM Tasks WHERE Id = {taskId}");
            if (taskDbStatus == TaskStatus.NotStarted || taskDbStatus == TaskStatus.Closed)
            {
                TempData["Message"] = "parent.layer.msg('任务状态已更新,请重新操作!',{icon: 5,shift: -1, time: 500});";
            }

            var result = AddTaskTracking(m_database, taskId, description, "任务跟进");

            if (!result)
            {
                TempData["Message"] = "parent.layer.msg('跟进失败,请重试！！',{icon: 5,shift: -1, time: 500});";
            }
            else
            {
                TempData["Message"] = @"parent.layer.msg('跟进成功!', { icon: 6,shift: -1, time: 500, shade: 0.3},
                                            function() { parent.layer.closeAll(); })";
            }
            return View();
        }

        #endregion 跟进
    }
}