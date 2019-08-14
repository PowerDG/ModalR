using Microsoft.AspNetCore.Mvc;
using ResearchHome.Areas.TaskScheduleBoard.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using System;
using System.Linq;

namespace ResearchHome.Areas.TaskScheduleBoard.Controllers
{
    [Area("TaskScheduleBoard")]
    public class TaskDealController : BaseController
    {
        private readonly IDatabase _database;

        public TaskDealController(IDatabase database)
        {
            _database = database;
        }

        public IActionResult DealTask()
        {
            return View();
        }

        public IActionResult TaskProcess(int taskId)
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetTaskTrackings(int taskId)
        {
           
            var tasktrackingsModel = _database.QueryListSQL<TasktrackingsModel>(
                                 $@"SELECT TaskId,FollowerId,Members.Name AS Follower,FollowTime,
                                        FollowDescription,FollowType FROM TaskTrackings
                                    LEFT JOIN Members
                                    ON TaskTrackings.FollowerId = Members.Id
                                    WHERE TaskId = {taskId} ORDER BY FollowTime DESC");
            return Json(tasktrackingsModel);
        }

        [HttpPost]
        public JsonResult GetTaskTrackingsPersonTask(int taskId)
        {
            var userId = Convert.ToInt32(GetCurrentUserClaim("Id"));
            var taskPrincipalPerson = _database.QuerySQL<dynamic>($@"SELECT MemberId,Status FROM Tasks WHERE Id = {taskId}");
            var isTaskPartner = _database.QuerySQL<int>($@"SELECT COUNT(1) FROM Taskpartners 
                                                            WHERE TaskId = {taskId} AND MemberId = {userId}") > 0;
            return Json(new TasktrackingsPersonTaskModel()
            {
                TaskStatus = taskPrincipalPerson.Status,
                IstaskPrincipalPerson = taskPrincipalPerson.MemberId == userId,
                IsTaskPartner = isTaskPartner
            });
        }

        [HttpPost]
        public JsonResult RecieveTask(int taskId)
        => UpdateTasksStatus(taskId, "执行中");

        [HttpPost]
        public JsonResult RemoveTask(int taskId, string description)
        => UpdateTasksStatus(taskId, "作废", description);


        [HttpPost]
        public JsonResult FinishTask(int taskId, string description)
        => UpdateTasksStatus(taskId, "完成", description);

        private JsonResult UpdateTasksStatus(int taskId, string taskNewStatus, string description = "")
        {
            var memberId = GetCurrentUserClaim("Id");
            var taskDbStatus = _database.QuerySQL<string>($@"SELECT Status FROM Tasks WHERE Id = {taskId}");
            if (taskDbStatus.Equals(taskNewStatus) || (taskNewStatus == "作废" && taskDbStatus == "完成"))
            {
                return Json(new PageResponse() { msg= "任务状态已更新,请重新操作!", code = 1, data = false});
            } 
            var taskTrackings = "";
            var taskTimedataColumn = new DataColumn();
            var dateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            switch (taskNewStatus)
            {
                case "执行中":
                    taskTrackings = "领取任务";
                    taskTimedataColumn = new DataColumn("StartTime", dateTime);
                    break;
                case "作废":
                    taskTrackings = "任务作废";
                    taskTimedataColumn = new DataColumn("EndTime", dateTime);
                    break;
                case "完成":
                    taskTrackings = "完成任务";
                    taskTimedataColumn = new DataColumn("EndTime", dateTime);
                    break;
            }
            if (string.IsNullOrEmpty(memberId))
            {
                return Json(false);
            }
            var result = _database.RunInTransaction(() =>
            {

                var taskTree = _database.QueryListSQL<dynamic>($@"SELECT Id FROM tasks WHERE `Status` <> '作废' AND `Status` <> '完成' AND FIND_IN_SET(Id,getChildTasksId({taskId}))");
                foreach(var taskNode in taskTree)
                {
                    _database.TransactionUpdateSQL("Tasks",
                        new DataColumn("MemberId", memberId),
                        new DataColumn("Status", taskNewStatus),
                        new DataColumn("LastUpdateTime", dateTime),
                        new DataColumn("Id", taskNode.Id, true),
                        taskTimedataColumn);

                    _database.TransactionInsertSQL("TaskTrackings",
                        new DataColumn("TaskId", taskNode.Id),
                        new DataColumn("FollowerId", memberId),
                        new DataColumn("FollowTime", dateTime),
                        new DataColumn("FollowDescription", description),
                        new DataColumn("FollowType", taskTrackings));
                }

                //任务作废时，更新任务树分数
                if (taskNewStatus == "作废")
                {
                    UpdateTasksScore(taskId);
                }
            });
            return Json(new PageResponse() { msg = result?"":$@"{taskTrackings}失败!", data = result });
        }

        [HttpPost]
        public JsonResult TrackingTask(int taskId, string description)
        {
            var memberId = GetCurrentUserClaim("Id");
            if (string.IsNullOrEmpty(memberId))
            {
                return Json(new PageResponse() { msg = $@"请登录!", data = false });
            }
            var taskDbStatus = _database.QuerySQL<string>($@"SELECT Status FROM Tasks WHERE Id = {taskId}");
            if(taskDbStatus == TaskStatus.NotStarted || taskDbStatus == TaskStatus.Closed)
            {
                return Json(new PageResponse() { msg = $@"任务状态已更新,请重新操作!", code = 1, data = false });
            }
            var result = _database.RunInTransaction(() =>
            {
                _database.TransactionUpdateSQL("Tasks",
                    new DataColumn("LastUpdateTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")),
                    new DataColumn("Id", taskId, true));

                _database.InsertSQL("TaskTrackings",
                    new DataColumn("TaskId", taskId),
                    new DataColumn("FollowerId", memberId),
                    new DataColumn("FollowTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")),
                    new DataColumn("FollowDescription", description),
                    new DataColumn("FollowType", "任务跟进"));
            });

            return Json(new PageResponse() { msg = result ? "" : $@"添加跟进失败!", data = result });
        }

        private void UpdateTasksScore(int rootId)
        {
            var taskTree = _database.QueryListSQL<dynamic>($"SELECT Id,ParentId,Score FROM tasks WHERE `Status` <> '作废' AND FIND_IN_SET(Id,getParentTasksId({rootId}))");
            foreach (dynamic taskNode in taskTree)
            {
                var id = Convert.ToInt32(taskNode.Id);
                var subTree = _database.QueryListSQL<dynamic>($"SELECT Id,ParentId,Score FROM tasks WHERE `Status` <> '作废' AND FIND_IN_SET(Id,getChildTasksId({id}))");
                int sumScore = 0;
                foreach (var subNode in subTree)
                {
                    if (subTree.Where(n => n.ParentId == subNode.Id).Count() == 0)//叶子节点
                    {
                        sumScore += subNode.Score;
                    }
                }
                _database.TransactionUpdateSQL("tasks", new DataColumn[] { new DataColumn("Score", sumScore), new DataColumn("Id", id, true) });
            }

        }

        private void CascadeUpdateTasksStatus(int rootId,string targetStatus)
        {
            if (targetStatus == "进行中")
            {

            }
            else if(targetStatus == "完成")
            {

            }
            else if (targetStatus == "作废")
            {

            }

        }

    }
}