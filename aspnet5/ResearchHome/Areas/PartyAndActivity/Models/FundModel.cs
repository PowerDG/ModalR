using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;

namespace ResearchHome.Areas.PartyAndActivity.Models
{
    public class FundModel
    {
        public int Id { get; set; }
        public string Description { get; set; }
        public string ItemName { get; set; }

        public int MemberId { get; set; }

        public decimal? OperatMoney { get; set; }
        public decimal RemainMoney { get; set; }

        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd HH:mm:ss}", ApplyFormatInEditMode = true)]
        [JsonProperty("StartTime")]
        public DateTime? InsertTime { get; set; }
    }
}
