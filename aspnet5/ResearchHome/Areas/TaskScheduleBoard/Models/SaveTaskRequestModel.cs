namespace ResearchHome.Areas.TaskScheduleBoard.Models
{
    public class SaveTaskRequestModel
    {
        public int TaskId { get; set; }
        public string TaskStatus { get; set; }
        public string TaskName { get; set; }
        public string TaskRemark { get; set; }
        public int Principal { get; set; }
        public string Participants { get; set; }
        public int? TaskPriority { get; set; }
        public string DeadLineTime { get; set; }
    }
}