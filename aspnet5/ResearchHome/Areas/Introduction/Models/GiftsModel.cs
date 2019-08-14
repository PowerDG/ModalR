using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.Introduction.Models
{
    public class Gifts
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("Name")]
        public string Name { get; set; }

        [JsonProperty("Price")]
        public decimal Price { get; set; }

        [JsonProperty("Hyperlink")]
        public string Hyperlink { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("CreatedTime")]
        public DateTime CreatedTime { get; set; }

        [JsonProperty("CreatedMemberId")]
        public int CreatedMemberId { get; set; }

       
        #region 辅助属性
        [Dapper.NotMapped]
        [JsonProperty("CreatedMemberName")]
        public string CreatedMemberName { get; set; }
        #endregion
    }
}
