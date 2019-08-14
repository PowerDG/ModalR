using Newtonsoft.Json;
using System;
using System.ComponentModel.DataAnnotations;

namespace ResearchHome.Areas.Introduction.Models
{
    [Serializable]
    [Dapper.Table("Members")]
    public class Members
    {
        [Dapper.Key]
        [JsonProperty("Id")]
        public int Id { get; set; }

        [JsonProperty("Account")]
        [Required(ErrorMessage = "登录名不能为空")]
        public string Account { get; set; }

        [JsonProperty("Password")]
        [Required(ErrorMessage = "密码不能为空")]
        public string Password { get; set; }

        [JsonProperty("PasswordKey")]
        public string PasswordKey { get; set; }

        [JsonProperty("Name")]
        [Required(ErrorMessage = "名字不能为空")]
        public string Name { get; set; }

        [JsonProperty("Photo")]
        public string Photo { get; set; }

        [JsonProperty("PhotoHD")]
        public string PhotoHD { get; set; }

        [JsonProperty("Gender")]
        public bool Gender { get; set; }

        [JsonProperty("Phone")]
        public string Phone { get; set; }

        [JsonProperty("QQ")]
        public string QQ { get; set; }

        [JsonProperty("WeChat")]
        public string WeChat { get; set; }

        [JsonProperty("Email")]
        public string Email { get; set; }

        [JsonProperty("BirthDay")]
        [Required(ErrorMessage = "生日不能为空")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime BirthDay { get; set; }

        [JsonProperty("EntryTime")]
        [Required(ErrorMessage = "入职时间不能为空")]
        [DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime EntryTime { get; set; }

        [JsonProperty("Title")]
        [Required(ErrorMessage = "职位不能为空")]
        public string Title { get; set; }

        [JsonProperty("Remarks")]
        public string Remarks { get; set; }

       

        [JsonProperty("IsAdmin")]
        public bool IsAdmin { get; set; }

        [JsonProperty("TotalIntegral")]
        public int TotalIntegral { get; set; }

        [JsonProperty("LikeCount")]
        public int LikeCount { get; set; }

        [JsonProperty("DislikeCount")]
        public int DislikeCount { get; set; }

        [JsonProperty("IsLeave")]
        public bool IsLeave { get; set; }

        public string AliasName { get; set; }
        public string Motto { get; set; }

        #region 辅助属性
        [JsonProperty("AnnualIntegral")]
        [Dapper.NotMapped]
        public int AnnualIntegral { get; set; }
        #endregion

    }
}
