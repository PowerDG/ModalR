using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace ResearchHome.Areas.SkillsAndMedals.Models
{
    public class SkillTree
    {
        [JsonProperty("title")]
        public string Title { get; set; }

        [JsonProperty("value")]
        public int Value { get; set; }

        [JsonProperty("checked")]
        public bool Checked { get; set; }

        [JsonProperty("parentId")]
        public int ParentId { get; set; }

        [JsonProperty("data")]
        public List<SkillTree> Data { get; set; }
    }
}
