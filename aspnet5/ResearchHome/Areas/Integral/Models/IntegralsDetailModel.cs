using Newtonsoft.Json;
using System;

namespace ResearchHome.Areas.Integral.Models
{
    public class IntegralsDetailModel
    {
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("MemberName")]
        public string MemberName { get; set; }

        [JsonProperty("Integral")]
        public int Integral { get; set; }

        [JsonProperty("Description")]
        public string Description { get; set; }

        [JsonProperty("CreatedTime")]
        public DateTime CreatedTime { get; set; }
    }
}
