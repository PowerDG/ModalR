using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.TaskScheduleBoard.Models
{
    public class ContributionStandardModel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public int Level { get; set; }
        public DateTime CreateTime { get; set; }
        public ContributionStandardModel Parent { get; set; }
    }
}
