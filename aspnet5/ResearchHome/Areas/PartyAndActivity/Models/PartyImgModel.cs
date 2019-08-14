using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.PartyAndActivity.Models
{
    public class PartyImgModel
    {
        public int PartyId { get; set; }

        [JsonProperty("UploadImg")]
        public string UploadImg { get; set; }

        [Required(ErrorMessage = "是不是要说些什么呢")]
        [StringLength(40, ErrorMessage = "说明不要超过40个字哟")]
        public string ImgDescription { get; set; }

        [Required(ErrorMessage = "图片不能为空")]
        [JsonProperty("Url")]
        public string ImgUrl { get; set; }
    }
}
