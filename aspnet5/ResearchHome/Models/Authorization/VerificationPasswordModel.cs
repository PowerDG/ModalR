using Newtonsoft.Json;
using System.ComponentModel.DataAnnotations;

namespace ResearchHome.Models.Authorization
{
    public class VerificationPasswordModel
    {
        [JsonProperty("OldPassword")]
        [Required(ErrorMessage = "当前密码不能为空")]
        [DataType(DataType.Password)]
        public string OldPassword { get; set; }

        [JsonProperty("NewPassword")]
        [Required(ErrorMessage = "新密码不能为空")]
        [DataType(DataType.Password)]
        public string NewPassword { get; set; }

        [JsonProperty("ConfirmPassword")]
        [Required(ErrorMessage = "验证密码不能为空")]
        [Compare("NewPassword",  ErrorMessage = "新密码和确认密码不匹配。")]
        [DataType(DataType.Password)]
        public string ConfirmPassword { get; set; }
    }
}
