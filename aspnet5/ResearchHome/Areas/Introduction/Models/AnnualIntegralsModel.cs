using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace ResearchHome.Areas.Introduction.Models
{
    public class AnnualIntegrals
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("Years")]
        public int Years { get; set; }

        [JsonProperty("AnnualIntegral")]
        public int AnnualIntegral { get; set; }

        [JsonProperty("UpdatedTime")]
        public DateTime UpdatedTime { get; set; }
    }
}
