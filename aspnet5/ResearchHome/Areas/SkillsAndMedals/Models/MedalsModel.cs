using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace ResearchHome.Areas.SkillsAndMedals.Models
{
    public class Medals
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("Icon")]
        public string Icon { get; set; }

        [JsonProperty("Name")]
        public string Name { get; set; }

        [JsonProperty("Description")]
        public string Description { get; set; }

        [JsonProperty("Count")]
        public int Count { get; set; }


        [JsonProperty("IsDiscard")]
        public int IsDiscard { get; set; }

        [JsonProperty("CreatedTime")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime CreatedTime { get; set; }

        [JsonProperty("DiscardTime")]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime DiscardTime { get; set; }

        [JsonProperty("Grade")]
        public string Grade { get; set; }

        [Dapper.NotMapped]
        [JsonProperty("CurrentPath")]
        public string CurrentPath { get; set; }
    }
}
