using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace ResearchHome.Areas.SkillsAndMedals.Models
{
    public class Skills
    {
        [Dapper.Key]
        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("parentId")]
        public int ParentId { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }

        [JsonProperty("level")]
        public int Level { get; set; }

        [JsonProperty("CreatedTime")]
        public DateTime CreatedTime { get; set; }

        #region 辅助属性
        [JsonProperty("memberSkillsId")]
        [Dapper.NotMapped]
        public int MemberSkillsId { get; set; }

        [JsonProperty("memberId")]
        [Dapper.NotMapped]
        public int MemberId { get; set; }

        [JsonProperty("gainDate")]
        [Dapper.NotMapped]
        public DateTime GainDate { get; set; }

        [Dapper.NotMapped]
        [JsonProperty("parent")]
        public Skills Parent { get; set; }

        [JsonProperty("children")]
        public List<Skills> Childs { get; set; }
        #endregion
    }
}
