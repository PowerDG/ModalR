using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Newtonsoft.Json;

namespace ResearchHome.Areas.Introduction.Models
{
    [Dapper.Table("TitleChanges")]
    public class TitleChangesModel
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }

        [JsonProperty("OldTitle")]
        public string OldTitle { get; set; }

        [JsonProperty("NewTitle")]
        public string NewTitle { get; set; }

        [JsonProperty("ChangedTime")]
        public DateTime ChangedTime { get; set; }

        [JsonProperty("CreatedMemberId")]
        public int CreatedMemberId { get; set; }
        
       

        #region 辅助属性
        [Dapper.NotMapped]
        [JsonProperty("CreatedMemberName")]
        public string CreatedMemberName { get; set; }
        #endregion
    }
}
