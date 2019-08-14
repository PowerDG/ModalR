using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;
using ResearchHome.Areas.SkillsAndMedals.Models;

namespace ResearchHome.Areas.Introduction.Models
{
    public class MemberMedals
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("MedalId")]
        public int MedalId { get; set; }

        [JsonProperty("Reason")]
        public string Reason { get; set; }

        [JsonProperty("GainDate")]
        public DateTime GainDate { get; set; }

        #region 辅助属性
        [Dapper.NotMapped]
        [JsonProperty("Count")]
        public int Count { get; set; }

        [Dapper.NotMapped]
        [JsonProperty("Medal")]
        public Medals Medal { get; set; }
        #endregion
    }
}
