using System;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using ResearchHome.DataBase;

namespace ResearchHome.Controllers
{
    [ExceptionTool]
    public class BaseController : Controller
    {
        public string GetCurrentUserClaim(string paramKey)
        {
            if (!HttpContext.User.Identity.IsAuthenticated) return "";
            var userInfo = HttpContext.User.Identities.First(u => u.IsAuthenticated).FindFirst(paramKey).Value;
            return userInfo;
        }

        public bool AddTaskTracking(IDatabase database, int taskId, string description, string type)
        {
            var memberId = GetCurrentUserClaim("Id");
            var result = database.RunInTransaction(() =>
            {
                database.TransactionUpdateSQL("Tasks",
                    new DataColumn("LastUpdateTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")),
                    new DataColumn("Id", taskId, true));

                database.InsertSQL("TaskTrackings",
                    new DataColumn("TaskId", taskId),
                    new DataColumn("FollowerId", memberId),
                    new DataColumn("FollowTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")),
                    new DataColumn("FollowDescription", description),
                    new DataColumn("FollowType", type));
            });
            return result;
        }
    }
}