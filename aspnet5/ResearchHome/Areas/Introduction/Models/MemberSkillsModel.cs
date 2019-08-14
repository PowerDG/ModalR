using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace ResearchHome.Areas.Introduction.Models
{
    public class MemberSkills
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("SkillId")]
        public int SkillId { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("GainDate")]
        public DateTime GainDate { get; set; }
    }
}
