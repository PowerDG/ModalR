using System;
using System.Collections.Generic;
using System.Linq;
using Newtonsoft.Json;
using System.Threading.Tasks;

namespace ResearchHome.Areas.Introduction.Models
{
    public class Integrals
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("CreatedTime")]
        public DateTime CreatedTime { get; set; }

        [JsonProperty("Integral")]
        public int Integral { get; set; }

        [JsonProperty("Description")]
        public string Description { get; set; }
    }
}
