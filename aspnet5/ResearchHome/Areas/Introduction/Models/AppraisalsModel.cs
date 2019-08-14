using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace ResearchHome.Areas.Introduction.Models
{
    [Dapper.Table("Appraisals")]
    public class Appraisals
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("Year")]
        public int Year { get; set; }

        [JsonProperty("Type")]
        public string Type { get; set; }

        [JsonProperty("ValueScore")]
        public decimal ValueScore { get; set; }

        [JsonProperty("PerformanceScore")]
        public decimal PerformanceScore { get; set; }

        [JsonProperty("TotalScore")]
        public decimal TotalScore { get; set; }

        [JsonProperty("Level")]
        public string Level { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("CreatedMemberId")]
        public int CreatedMemberId { get; set; }

        [JsonProperty("CreatedTime")]
        public DateTime CreatedTime { get; set; }


        #region 辅助属性
        [Dapper.NotMapped]
        [JsonProperty("CreatedMemberName")]
        public string CreatedMemberName { get; set; }

        [Dapper.NotMapped]
        [JsonProperty("AppraisalLevel")]
        public int AppraisalLevel { get; set; }

        [Dapper.NotMapped]
        [JsonProperty("AppraisalType")]
        public int AppraisalType { get; set; }
        #endregion
    }
}
