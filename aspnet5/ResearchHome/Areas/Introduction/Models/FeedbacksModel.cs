using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace ResearchHome.Areas.Introduction.Models
{
    public class Feedbacks
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("Content")]
        public string Content { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("ProviderId")]
        public int ProviderId { get; set; }

        [JsonProperty("CreatedTime")]
        public DateTime CreatedTime { get; set; }

        [JsonProperty("ProviderName")]
        public string ProviderName { get; set; }
    }
}
