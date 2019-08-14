using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;

namespace ResearchHome.Areas.TaskScheduleBoard.Models
{
    public class TasksModel
    {
        [JsonProperty("Id")]
        public int Id { get; set; }

        [Required(ErrorMessage = "任务名不能为空")]
        [JsonProperty("Name")]
        public string Name { get; set; }

        [JsonProperty("Score")]
        public int Score { get; set; }

        [JsonProperty("Status")]
        public string Status { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("MemberName")]
        public string MemberName { get; set; }

        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd HH:mm:ss}", ApplyFormatInEditMode = true)]
        [JsonProperty("StartTime")]
        public DateTime StartTime { get; set; }

        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd HH:mm:ss}", ApplyFormatInEditMode = true)]
        [JsonProperty("EndTime")]
        public DateTime? EndTime { get; set; }

        [JsonProperty("Description")]
        public string Description { get; set; }

        [JsonProperty("UpdateDescription")]
        public string UpdateDescription { get; set; }

        [JsonProperty("FabulousCount")]
        public int FabulousCount { get; set; }

        [JsonProperty("HasFabuloued")]
        public bool HasFabuloued { get; set; }

        [JsonProperty("HasJoined")]
        public bool HasJoined { get; set; }

        [JsonProperty("CreatedMemberId")]
        public int CreatedMemberId { get; set; }

        [JsonProperty("CreatedMemberName")]
        public string CreatedMemberName { get; set; }

        [JsonProperty("CreatedTime")]
        public DateTime CreatedTime { get; set; }

        [JsonProperty("ScoreApportioned")]
        public bool ScoreApportioned { get; set; }

        [JsonProperty("ParentId")]
        public int ParentId { get; set; }

        [JsonProperty("IsLeaf")]
        public bool IsLeaf { get; set; }

        [JsonProperty("LastUpdateTime")]
        public DateTime? LastUpdateTime { get; set; }
    }

    public class TasksIntegralModel
    {
        [JsonProperty("MemberId")]
        public int MemberId { get; set; }
        
        [JsonProperty("MemberName")]
        public string MemberName { get; set; }

        [JsonProperty("IsManager")]
        public bool IsManager { get; set; }

        [JsonProperty("Integral")]
        public int Integral { get; set; }

        [JsonProperty("Description")]
        public string Description { get; set; }
    }
}
