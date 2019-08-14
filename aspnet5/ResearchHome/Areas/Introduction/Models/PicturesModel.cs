using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;

namespace ResearchHome.Areas.Introduction.Models
{
    public class PicturesModel
    {
        [JsonProperty("Id")]
        public long Id { get; set; }

        [Required(ErrorMessage = "图片不能为空")]
        [JsonProperty("Url")]
        public string Url { get; set; }

        [JsonProperty("UploadImg")]
        public string UploadImg { get; set; }

        [JsonProperty("PartialPictureUrl")]
        public string PartialPictureUrl { get; set; }
        
        [Required(ErrorMessage ="是不是要说些什么呢")]
        [StringLength(40, ErrorMessage ="说明不要超过40个字哟")]
        [JsonProperty("Description")]
        public string Description { get; set; }
        

        [JsonProperty("MemberId")]
        public int MemberId { get; set; }
        
        [JsonProperty("UpdatedTime")]
        public DateTime UpdatedTime { get; set; }
    } 
}
