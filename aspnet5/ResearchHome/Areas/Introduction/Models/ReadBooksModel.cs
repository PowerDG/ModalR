using Dapper;
using Newtonsoft.Json;
using System;

namespace ResearchHome.Areas.Introduction.Models
{
    [Table("book")]
    public class ReadBooks
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("Name")]
        
        public string Name { get; set; }

        [JsonProperty("Photo")]
        public string Photo { get; set; }

        [JsonProperty("PhotoHD")]
        public string PhotoHD { get; set; }

        [JsonProperty("Author")]
        public string Author { get; set; }

        [JsonProperty("create_time")]
        [Helper.Column(Name = "create_time")]
        public DateTime CreateTime { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("Commentary")]
        [Helper.Column(Name = "comment")]
        public string Commentary { get; set; }
    }
}
