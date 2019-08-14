using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;

namespace ResearchHome.Areas.Introduction.Models
{
    public class IntroductionsModel
    {
        [JsonProperty("Title")]
        [Required(ErrorMessage = "标题不能为空")]
        public string Title { get; set; }

        [JsonProperty("Content")]
        [Required(ErrorMessage = "内容不能为空")]
        public string Content { get; set; }
    }
}
