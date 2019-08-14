using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.TaskScheduleBoard.Models
{
    public class PlanModel
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string CreateMemberName { get; set; }
        public string CreateTime { get; set; }
        public string Status { get; set; }
        public string ClosedTime { get; set; }
        public string Remark { get; set; }
    }
}
