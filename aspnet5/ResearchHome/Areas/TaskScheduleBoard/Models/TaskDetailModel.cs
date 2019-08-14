using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.TaskScheduleBoard.Models
{
    public class TaskDetailModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Score { get; set; }
        public string Status { get; set; }
        public int? PrincipalId { get; set; }
        public string PrincipalName { get; set; }
        public int CreatedMemberId { get; set; }
        public string CreatedMemberName { get; set; }
        public DateTime? CreatedTime { get; set; }
        public DateTime? DeadLineTime { get; set; }
        public DateTime? StartTime { get; set; }
        public DateTime? EndTime { get; set; }
        public string Description { get; set; }
        public DateTime? FollowTime { get; set; }
        public string Participants { get; set; }
        public int IsReview { get; set; }
        public int CanEdit { get; set; }
        public int Priority { get; set; }
    }
}
