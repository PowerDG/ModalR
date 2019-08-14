using Newtonsoft.Json;
using System;

namespace ResearchHome.Areas.TaskScheduleBoard.Models
{
    public class TasktrackingsModel
    {
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("FollowerId")]
        public int FollowerId { get; set; }

        [JsonProperty("Follower")]
        public string Follower { get; set; }

        [JsonProperty("TaskId")]
        public int TaskId { get; set; }
        
        [JsonProperty("FollowTime")]
        public DateTime FollowTime { get; set; }

        [JsonProperty("FollowDescription")]
        public string FollowDescription { get; set; }

        [JsonProperty("FollowType")]
        public string FollowType { get; set; }
    }
    public class TasktrackingsPersonTaskModel
    {
        [JsonProperty("TaskStatus")]
        public string TaskStatus { get; set; }

        [JsonProperty("IstaskPrincipalPerson")]
        public bool IstaskPrincipalPerson { get; set; }

        [JsonProperty("IsTaskPartner")]
        public bool IsTaskPartner { get; set; }
    }
}
