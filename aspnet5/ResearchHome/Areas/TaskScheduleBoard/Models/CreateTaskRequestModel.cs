namespace ResearchHome.Areas.TaskScheduleBoard.Models
{
    public class CreateTaskRequestModel
    {
        public string TaskName { get; set; }
        public string Principal { get; set; }
        public string DeadLineTime { get; set; }
        public string Description { get; set; }
        public int? PlanId { get; set; }
        public int Priority { get; set; }
    }
}