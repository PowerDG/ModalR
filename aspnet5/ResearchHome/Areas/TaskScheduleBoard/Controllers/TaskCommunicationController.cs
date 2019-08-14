using Microsoft.AspNetCore.Mvc;
using ResearchHome.Areas.TaskScheduleBoard.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ResearchHome.Areas.TaskScheduleBoard.Controllers
{
    [Area("TaskScheduleBoard")]
    public class TaskCommunicationController : BaseController
    {
        private readonly IDatabase _database;

        public TaskCommunicationController(IDatabase database)
        {
            _database = database;
        }

        public IActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetCommunicationTask(int taskId)
        {
            var result = _database.QuerySQL<TasksModel>($@"SELECT Tasks.Id,Tasks.Name,Score,Status,MemberId,MembersInfo.Name AS MemberName,StartTime,EndTime,
	                            Description,CreatedMemberId,CreatedMembersInfo.Name AS CreatedMemberName,CreatedTime 
                            FROM Tasks
                            LEFT JOIN Members AS MembersInfo
                            ON Tasks.MemberId = MembersInfo.Id
                            LEFT JOIN Members AS CreatedMembersInfo
                            ON Tasks.CreatedMemberId = CreatedMembersInfo.Id
                            WHERE Tasks.Id = {taskId}");
            return Json(result);
        }

        [HttpPost]
        public JsonResult GetCommunicationData(int taskId)
        {
            var taskCommunications = _database.QueryListSQL<TasksCommunicationsModel>(
                    $@"SELECT TaskCommunications.Id, TaskId, Content, MemberId,Members.Name MemberName,TaskCommunications.CreatedTime FROM TaskCommunications
                        LEFT JOIN Members
                        ON TaskCommunications.MemberId = Members.Id
                        WHERE TaskId = {taskId} AND Type = 'Communication' ORDER BY TaskCommunications.CreatedTime DESC"
                ).ToList();

            var taskReplys = _database.QueryListSQL<TaskCommunicationReplysModel>(
                    $@"SELECT ReplyInfo.Id,CommunicationId, MemberId,CommunicationReplyMember.Name AS MemberName,
	                    ReplyMemberId, ReplyMember.Name AS ReplyMemberName, Content,ReplyInfo.CreatedTime FROM
	                    (
		                    SELECT Id,CommunicationId, MemberId,ReplyMemberId, Content, CreatedTime FROM taskcommunicationreplys
		                    WHERE EXISTS(SELECT Id FROM TaskCommunications WHERE TaskId = {taskId} AND TaskCommunications.Id = taskcommunicationreplys.CommunicationId)
	                    )ReplyInfo
	                    LEFT JOIN Members AS CommunicationReplyMember
	                    ON ReplyInfo.MemberId = CommunicationReplyMember.Id
	                    LEFT JOIN Members AS ReplyMember
	                    ON ReplyInfo.ReplyMemberId = ReplyMember.Id"
                );
            for (var i = 0; i < taskCommunications.Count; i++)
            {
                taskCommunications[i].TaskCommunicationReplysList = new List<TaskCommunicationReplysModel>(
                        taskReplys.Where(item => item.CommunicationId == taskCommunications[i].Id)
                    );
            }
            return Json(taskCommunications);
        }

        [HttpPost]
        public JsonResult SetFabulousTask(int taskId, bool fabulousType)
        {
            if (string.IsNullOrEmpty(GetCurrentUserClaim("Id"))) return Json(false);
            var result = false;
            if (fabulousType)
            {
                result = _database.ExecuteSQL($@"INSERT INTO TaskCommunications(TaskId, MemberId,CreatedTime,Type)
                             VALUES ({taskId}, {GetCurrentUserClaim("Id")},'{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}','fabulous')");
            }
            else
            {
                result = _database.ExecuteSQL($@"DELETE FROM TaskCommunications WHERE TaskId = {taskId} AND MemberId = {GetCurrentUserClaim("Id")} AND Type = 'fabulous'");
            }
            return Json(result);
        }
        
        [HttpPost]
        public JsonResult InsertTaskCommunication(int taskId, string communicationText)
        {
            if (string.IsNullOrEmpty(GetCurrentUserClaim("Id"))) return Json(false);
            var result = _database.InsertSQL("TaskCommunications",
                new DataColumn("TaskId",taskId),
                new DataColumn("Content", communicationText),
                new DataColumn("MemberId", GetCurrentUserClaim("Id")),
                new DataColumn("CreatedTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")),
                new DataColumn("Type", "Communication"));
            return Json(result);
        }
        
        [HttpPost]
        public JsonResult InsertTaskCommunicationReply(int replyMemberId,int replycommounicationId, string communicationText)
        {
            if (string.IsNullOrEmpty(GetCurrentUserClaim("Id"))) return Json(false);
            var result = _database.InsertSQL("TaskCommunicationReplys",
                new DataColumn("CommunicationId", replycommounicationId),
                new DataColumn("MemberId", GetCurrentUserClaim("Id")),
                new DataColumn("Content", communicationText),
                new DataColumn("ReplyMemberId", replyMemberId),
                new DataColumn("CreatedTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")));
            return Json(result);
        }
    }
}