using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.TaskScheduleBoard.Models
{
    public class TaskReviewModel
    {
        public int TaskId { get; set; }
        public string TaskName { get; set; }
        public string Leader { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? DeadLineTime { get; set; }
        public DateTime? EndTime { get; set; }
        public int? Score { get; set; }
        public List<string> KeyResults { get; set; }
        public string PerfectFunction { get; set; }
        public string TroubleFunction { get; set; }
        public string StrongAspect { get; set; }
        public string WeaknessAspect { get; set; }
        public List<PersonalTodos> PersonalContributions { get; set; }
        public int IsReview { get; set; }
    }

    public class PersonalTodos
    {
        public int ExecutorId { get; set; }
        public string ExecutorName { get; set; }
        public long FinishTodoCount { get; set; }
        public List<Todo> Todos { get; set; }
        public string ReviewComment { get; set; }
        public int? ReviewScore { get; set; }
    }

    public class Todo
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public int ExecutorId { get; set; }
        public string ExecutorName { get; set; }
    }

    public class TaskReviewResult
    {
        public int TaskId { get; set; }
        public string PerfectFunction { get; set; }
        public string TroubleFunction { get; set; }
        public string StrongAspect { get; set; }
        public string WeaknessAspect { get; set; }
        public int TotalScore { get; set; }
        public List<PersonalReviewResult> Members { get; set; }
    }

    public class PersonalReviewResult
    {
        public int Id { get; set; }
        public string ReviewComment { get; set; }
        public string ReviewScore { get; set; }
    }
}
