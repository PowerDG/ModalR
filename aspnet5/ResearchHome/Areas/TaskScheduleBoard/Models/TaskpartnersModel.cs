using Newtonsoft.Json;
using System;

namespace ResearchHome.Areas.TaskScheduleBoard.Models
{
    public class TaskpartnersModel
    {
        [JsonProperty("Id")]
        public int Id { get; set; }
        
        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("PartnerName")]
        public string PartnerName { get; set; }
        
        [JsonProperty("TaskId")]
        public int TaskId { get; set; }

        [JsonProperty("Description")]
        public string Description { get; set; }

        [JsonProperty("CreatedTime")]
        public DateTime CreatedTime { get; set; }
    }
}
