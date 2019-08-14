using Microsoft.AspNetCore.Mvc;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;

namespace ResearchHome.Areas.TaskScheduleBoard.Controllers
{
    [Area("TaskScheduleBoard")]
    public class TodoController : BaseController
    {
        private readonly IDatabase database;

        public TodoController(IDatabase database)
        {
            this.database = database;
        }

        public IActionResult CreateTodo(int taskId)
        {
            ViewBag.TaskId = taskId;
            return View();
        }

        [HttpPost]
        public IActionResult CreateTodo(string description, string remark, int taskId)
        {
            var memberId = GetCurrentUserClaim("Id");
            var dateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            var result = database.TransactionInsertSQL("todos",
                                               new DataColumn("Description", description),
                                               new DataColumn("Remark", remark),
                                               new DataColumn("CreateMemberId", memberId),
                                               new DataColumn("Status", TodoStatus.NotCompleted),
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

        public IActionResult EditTodo(int todoId, string type)
        {
            string sql = $@"SELECT Description,`Status`,Remark FROM todos  WHERE Id={todoId}";
            var todo = database.QuerySQL<dynamic>(sql);
            ViewBag.TodoId = todoId;
            ViewBag.Description = todo.Description;
            ViewBag.Status = todo.Status;
            ViewBag.Remark = todo.Remark;
            ViewBag.Type = type;
            return View();
        }

        [HttpPost]
        public IActionResult EditTodo(int todoId, string description, string remark, string todoStatus)
        {
            bool result = database.TransactionUpdateSQL("todos",
                    GetUpdateColumn(todoId, description, remark, todoStatus));

            if (!result)
            {
                TempData["Message"] = "parent.layer.msg('更新失败,请重试！！',{icon: 5,shift: -1, time: 500});";
            }
            else
            {
                TempData["Message"] = @"parent.layer.msg('更新成功!', { icon: 6,shift: -1, time: 500, shade: 0.3},
                                            function() { parent.layer.closeAll(); })";
                var todoInfo = database.QuerySQL<dynamic>($@"SELECT TaskId,Description FROM todos WHERE Id={todoId}");
                if (todoStatus == TodoStatus.Completed)
                {
                    AddTaskTracking(database, todoInfo.TaskId, "关闭TODO：" + todoInfo.Description, "关闭TODO");
                }
            }
            return View();
        }

        private DataColumn[] GetUpdateColumn(int todoId, string description, string remark, string todoStatus)
        {
            var dateTime = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
            if (todoStatus == TodoStatus.Completed)
            {
                return new[]{ new DataColumn("Description", description),
                    new DataColumn("Remark", remark),
                    new DataColumn("Status", todoStatus),
                    new DataColumn("Executor", GetCurrentUserClaim("Id")),
                    new DataColumn("ClosedTime", dateTime),
                    new DataColumn("Id", todoId, true),
                    new DataColumn("LastUpdateTime", dateTime)};
            }
            else
            {
                return new[]{ new DataColumn("Description", description),
                    new DataColumn("Remark", remark),
                    new DataColumn("Status", todoStatus),
                    new DataColumn("Id", todoId, true),
                    new DataColumn("LastUpdateTime", dateTime)};
            }
        }

        public JsonResult DeleteTodo(int todoId)
        {
            var todoInfo = database.QuerySQL<dynamic>($@"SELECT TaskId,Description FROM todos WHERE Id={todoId}");
            var operateResult = database.TransactionExecuteSQL($@"DELETE FROM todos  WHERE Id ={todoId}");
            string message = "";
            if (!operateResult)
            {
                message = "删除失败，请重试！";
            }
            else
            {
                AddTaskTracking(database, todoInfo.TaskId, "删除TODO：" + todoInfo.Description, "删除TODO");
            }
            return Json(new { result = operateResult, message });
        }

        public JsonResult GetTaskTodosSummary(int taskId)
        {
            string sqlTotal = $@"SELECT COUNT(1) FROM `todos` WHERE TaskId={taskId} ";
            var todosTotalCount = database.Single<int>(sqlTotal);

            string sqlComplete = $@"SELECT COUNT(1) FROM `todos`
                                    WHERE TaskId={taskId} AND Status = '{TodoStatus.Completed}' ";
            var todosCompleteCount = database.Single<int>(sqlComplete);

            return Json(new { todosTotalCount, todosCompleteCount });
        }

        [HttpPost]
        public JsonResult GetTaskTodosCount(int taskId, bool onlyMy, bool onlyEffective)
        {
            string queryTypeSection = "";
            if (onlyMy)
            {
                queryTypeSection += $@" AND CreateMemberId={GetCurrentUserClaim("Id")} ";
            }
            if (onlyEffective)
            {
                queryTypeSection += $@" AND Status <> '{TodoStatus.Completed}'";
            }

            string sql = $@"SELECT COUNT(1) FROM `todos` WHERE TaskId={taskId} {queryTypeSection}
                            ";
            var todosCount = database.Single<int>(sql);
            return Json(new { todosCount });
        }

        [HttpPost]
        public JsonResult GetTaskTodos(int taskId, int page, int limit, bool onlyMy, bool onlyEffective)
        {
            string queryTypeSection = "";
            if (onlyMy)
            {
                queryTypeSection += $@" AND todos.CreateMemberId={GetCurrentUserClaim("Id")} ";
            }
            if (onlyEffective)
            {
                queryTypeSection += $@" AND todos.Status <> '{TodoStatus.Completed}' ";
            }

            string sql = $@"SELECT todos.Id,todos.Description,m1.`Name` AS Creator,todos.`Status`,todos.LastUpdateTime,
                            m2.`Name` AS Executor,todos.ClosedTime
                            FROM `todos`
                            LEFT JOIN members AS m1 ON todos.CreateMemberId=m1.Id
                            LEFT JOIN members AS m2 ON todos.Executor=m2.Id
                            WHERE todos.TaskId={taskId}  {queryTypeSection}
                            ORDER BY (CASE WHEN todos.`Status`='{TodoStatus.NotCompleted}' then 0
                                           WHEN todos.`Status`='{TodoStatus.Executing}' then 0
                                           WHEN todos.`Status`='{TodoStatus.Completed}' then 1 END),
                            todos.LastUpdateTime DESC LIMIT {limit * (page - 1)},{limit}";
            var todos = database.QueryListSQL<dynamic>(sql);
            return Json(todos);
        }

        [HttpPost]
        public JsonResult FinishTodo(int todoId)
        {
            string sql = $@"UPDATE todos SET `Status`='{TodoStatus.Completed}',ClosedTime=NOW(),LastUpdateTime=NOW(),
                            Executor={GetCurrentUserClaim("Id")}
                            WHERE Id ={todoId}";
            var operateResult = database.TransactionExecuteSQL(sql);
            string message = "";
            if (!operateResult)
            {
                message = "关闭失败，请重试！";
            }
            else
            {
                var todoInfo = database.QuerySQL<dynamic>($@"SELECT TaskId,Description FROM todos WHERE Id={todoId}");
                AddTaskTracking(database, todoInfo.TaskId, "关闭TODO：" + todoInfo.Description, "关闭TODO");
            }
            return Json(new { result = operateResult, message });
        }
    }
}