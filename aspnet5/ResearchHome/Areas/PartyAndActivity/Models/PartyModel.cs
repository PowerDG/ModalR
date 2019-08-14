using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;

namespace ResearchHome.Areas.PartyAndActivity.Models
{
    public class PartyModel
    {
        [JsonProperty("Id")]
        public int Id { get; set; }

        [Required(ErrorMessage = "标题不能为空")]
        [JsonProperty("PartyName")]
        public string PartyName { get; set; }

        [JsonProperty("Address")]
        public string Address { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("Tel")]
        public string Tel { get; set; }

        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd HH:mm:ss}", ApplyFormatInEditMode = true)]
        [JsonProperty("StartTime")]
        public DateTime? StartTime { get; set; }

        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd HH:mm:ss}", ApplyFormatInEditMode = true)]
        [JsonProperty("EndTime")]
        public DateTime? EndTime { get; set; }

        [JsonProperty("PartyPlace")]
        public string PartyPlace { get; set; }
        
        public string Longitude { get; set; }
       
        public string Latitude { get; set; }

        [JsonProperty("MoneyResource")]
        public int MoneyResource { get; set; }

        [JsonProperty("Money")]
        public decimal? Money { get; set; }

        [JsonProperty("Number")]
        public int? Number { get; set; }

        [JsonProperty("LikeLevel")]
        public int LikeLevel { get; set; }
    }
}
