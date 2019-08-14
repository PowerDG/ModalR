using System.ComponentModel.DataAnnotations;

namespace ResearchHome.Models.Authorization
{
    public class AccountLoginModel
    {
        [Required(ErrorMessage = "账号不能为空")]
        public string Account { get; set; }

        [Required(ErrorMessage = "密码不能为空")]
        public string Password { get; set; }

        public bool IsCheck { get; set; }

        public string VerificationCode { get; set; }
        
        public string PasswordKey { get; set; }

        public bool IsCheckBox { get; set; }
    }
}
