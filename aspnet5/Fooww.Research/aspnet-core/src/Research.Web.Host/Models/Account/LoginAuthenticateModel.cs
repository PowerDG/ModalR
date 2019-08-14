using System.ComponentModel.DataAnnotations;

namespace Research.Web.Host.Models.Account
{
    public class LoginAuthenticateModel
    {
        [Required]
        public string UsernameOrEmailAddress { get; set; }

        [Required]
        public string Password { get; set; }

        public bool RememberMe { get; set; }
    }

    public class AuthenticateBaseResultModel
    {
        public string AccessToken { get; set; } 
        public string token_type { get; set; }
        public int ExpireInSeconds { get; set; } 
        public long UserId { get; set; }
    }
    public class AuthenticateResultModel: AuthenticateBaseResultModel
    { 
        public string EncryptedAccessToken { get; set; } 
    }
}