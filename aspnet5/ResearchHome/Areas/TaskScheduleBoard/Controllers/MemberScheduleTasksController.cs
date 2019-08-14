using Microsoft.AspNetCore.Mvc;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ResearchHome.Areas.TaskScheduleBoard.Controllers
{
    [Area("TaskScheduleBoard")]
    public class MemberScheduleTasksController : BaseController
    {
        private readonly IDatabase m_database;

        public MemberScheduleTasksController(IDatabase database)
        {
            m_database = database;
        }

        public IActionResult Index()
        {
            return View();
        }

        public JsonResult GetMemberScheduleTasks(int page, int limit)
        {
            string lastSeasonEnd = DateTime.Now.AddMonths(-9 - ((DateTime.Now.Month - 1) % 3))//三个季度前
                                                               .AddDays(1 - DateTime.Now.Day).AddDays(-1).ToString("yyyy-MM-dd HH:mm:ss");
            string condition = $@"WHERE
                         ((to_days(tasks.StartTime) >= to_days('{lastSeasonEnd}') AND to_days(tasks.StartTime) <= to_days(NOW()))
                         OR (to_days(tasks.EndTime) >= to_days('{lastSeasonEnd}') AND to_days(tasks.EndTime) <= to_days(NOW())) )
                         AND tasks.`Status` <> '{TaskStatus.NotStarted}' AND tasks.StartTime IS NOT null";
            string taskSql = $@"SELECT Id,`Name`,StartTime,EndTime,DeadLineTime,MemberId
                                FROM tasks {condition}  ORDER BY StartTime ";

            var tasks = m_database.QueryListSQL<dynamic>(taskSql).ToList();

            List<dynamic> result = TaskResponse(tasks);
            result = result.OrderByDescending(task => task.Count).ToList();
            return Json(new PageResponse(result));
        }

        private List<dynamic> TaskResponse(List<dynamic> tasks)
        {
            var memberGroup = GetMemberGroup();
            List<dynamic> result = new List<dynamic>();
            foreach (var member in memberGroup)
            {
                List<dynamic> taskList = new List<dynamic>();
                foreach (var taskId in member.taskIds)
                {
                    var task = tasks.Where(t => t.Id == taskId.TaskId).ToList();
                    if (task.Count > 0)
                    {
                        var memberTask = task[0];
                        int endSeason = 0, startSeason = 0, season = 0;//根据月份计算季度
                        endSeason = memberTask.EndTime == null ? (memberTask.DeadLineTime.Month + 2) / 3 :
                                                               (memberTask.EndTime.Month + 2) / 3;
                        startSeason = (memberTask.StartTime.Month + 2) / 3;
                        season = GetSeason(memberTask.StartTime);
                        int length = startSeason == endSeason ? 1 : 2;
                        taskList.Add(new { memberTask.Id, memberTask.Name, memberTask.MemberId, season, length });
                    }
                }
                string memberPhotoSql = $@"SELECT Photo,Name,Id FROM members WHERE Id={member.Id}";
                var memberPhoto = m_database.QueryListSQL<dynamic>(memberPhotoSql);
                result.Add(new { memberPhoto, taskList.Count, taskList});
            }

            return result;
        }

        private List<dynamic> GetMemberGroup()
        {
            List<dynamic> memberGroup = new List<dynamic>();
            string memberSql = @"SELECT Id FROM members WHERE IsLeave=0";
            var members = m_database.QueryListSQL<dynamic>(memberSql).ToList();
            foreach (var member in members)
            {
                string taskIdSql = $@"SELECT AllMembers.TaskId FROM (
                                SELECT TaskId FROM taskpartners
                                WHERE  MemberId ={member.Id} 
                                UNION All
                                SELECT Id AS TaskId FROM tasks
                                WHERE  MemberId = {member.Id}   ) AS AllMembers";
                List<dynamic> taskIds = m_database.QueryListSQL<dynamic>(taskIdSql).ToList();
                memberGroup.Add(new { member.Id, taskIds });
            }

            return memberGroup;
        }

        private int GetSeason(DateTime dateTime)
        {
            DateTime lastSeasonEnd = DateTime.Now.AddMonths(0 - ((DateTime.Now.Month - 1) % 3)).
                 AddDays(1 - DateTime.Now.Day).AddDays(-1);// 上季度最后一天
            DateTime lastSeasonEnd2 = DateTime.Now.AddMonths(-3 - ((DateTime.Now.Month - 1) % 3)).
                AddDays(1 - DateTime.Now.Day).AddDays(-1);// 上上季度最后一天
            DateTime lastSeasonEnd3 = DateTime.Now.AddMonths(-6 - ((DateTime.Now.Month - 1) % 3)).
                AddDays(1 - DateTime.Now.Day).AddDays(-1);
            DateTime lastSeasonEnd4 = DateTime.Now.AddMonths(-9 - ((DateTime.Now.Month - 1) % 3)).
                AddDays(1 - DateTime.Now.Day).AddDays(-1);

            if (dateTime < lastSeasonEnd4)
            {
                return (int)Season.LastFourSeason;
            }
            if (dateTime < lastSeasonEnd3)
            {
                return (int)Season.LastThreeSeason;
            }
            if (dateTime < lastSeasonEnd2)
            {
                return (int)Season.LastTwoeason;
            }
            if (dateTime < lastSeasonEnd)
            {
                return (int)Season.LastSeason;
            }
            return (int)Season.CurrentSeason;
        }

        private enum Season
        {
            LastFourSeason,
            LastThreeSeason,
            LastTwoeason,
            LastSeason,
            CurrentSeason
        }
    }
}