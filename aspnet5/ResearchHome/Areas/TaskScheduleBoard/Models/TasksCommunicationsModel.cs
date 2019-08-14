using Newtonsoft.Json;
using System;
using System.Collections.Generic;

namespace ResearchHome.Areas.TaskScheduleBoard.Models
{
    public class TasksCommunicationsModel
    {
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("TaskId")]
        public int TaskId { get; set; }

        [JsonProperty("Content")]
        public string Content { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("MemberName")]
        public string MemberName { get; set; }

        [JsonProperty("CreatedTime")]
        public DateTime? CreatedTime { get; set; }
        
        [JsonProperty("TaskCommunicationReplysList")]
        public List<TaskCommunicationReplysModel> TaskCommunicationReplysList { get; set; }
    }

    public class TaskCommunicationReplysModel
    {
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("CommunicationId")]
        public int CommunicationId { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("MemberName")]
        public string MemberName { get; set; }

        [JsonProperty("ReplyMemberId")]
        public int ReplyMemberId { get; set; }

        [JsonProperty("ReplyMemberName")]
        public string ReplyMemberName { get; set; }

        [JsonProperty("CreatedTime")]
        public DateTime? CreatedTime { get; set; }

        [JsonProperty("Content")]
        public string Content { get; set; }
    }
}
