using Microsoft.AspNetCore.Mvc;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;
using System.Linq;

namespace ResearchHome.Areas.TaskScheduleBoard.Controllers
{
    [Area("TaskScheduleBoard")]
    public class TaskFeedbackController : BaseController
    {
        private readonly IDatabase m_database;

        public TaskFeedbackController(IDatabase database)
        {
            m_database = database;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetTaskFeedbacks(int taskId, int page, int limit)
        {
            string feedbackSql = $@"SELECT members.`Name`,description,type,task_feedback.create_time FROM task_feedback,members
                                    WHERE task_id={taskId} AND member_id=members.Id
                                    ORDER BY task_feedback.create_time DESC LIMIT {limit * (page - 1)},{limit}";
            var feedback = m_database.QueryListSQL<dynamic>(feedbackSql).ToList();
            return Json(feedback);
        }

        [HttpPost]
        public JsonResult GetTaskFeedBackCount(int taskId)
        {
            string sql = $@"SELECT COUNT(*) FROM task_feedback WHERE task_id = {taskId}";
            var feedbackCount = m_database.Single<int>(sql);
            return Json(new { FeedbackCount=feedbackCount });
        }

        public IActionResult TrackTaskFeedback(int taskId)
        {
            ViewBag.TaskId = taskId;
            return View();
        }

        [HttpPost]
        public IActionResult TrackTaskFeedback(int taskId, int type, string description)
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
            var result = m_database.RunInTransaction(() =>
            {
                m_database.TransactionUpdateSQL("Tasks",
                    new DataColumn("LastUpdateTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")), new DataColumn("Id", taskId, true));
                m_database.InsertSQL("task_feedback",
                    new DataColumn("task_id", taskId),  new DataColumn("member_id", memberId),
                    new DataColumn("type", type), new DataColumn("description", description));
            });
            TempData["Message"] = !result?"parent.layer.msg('反馈失败,请重试！！',{icon: 5,shift: -1, time: 500});":
            @"parent.layer.msg('反馈成功!', { icon: 6,shift: -1,time: 500, shade: 0.3}, function() { parent.layer.closeAll(); })";
            return View();
        }
    }
}