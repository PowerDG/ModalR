using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Memory;
using Microsoft.Extensions.Configuration;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using ResearchHome.Models.Authorization;
using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Threading.Tasks;

namespace ResearchHome.Controllers
{
    public class AuthorizationController : BaseController
    {
        private readonly IConfiguration _configuration;
        private IMemoryCache _cache;
        private readonly IDatabase _database;

        public AuthorizationController(IConfiguration configuration, IMemoryCache cache, IDatabase database)
        {
            _configuration = configuration;

            _cache = cache;
            _database = database;
        }

        public IActionResult Login()
        {
            return View(new AccountLoginModel());
        }

        public IActionResult VerificationPassword()
        {
            return View(new VerificationPasswordModel());
        }

        public async Task<JsonResult> ShowCodeImage()
        {
            var bytes = await VerificationHelper.CreateImage();
            int result = VerificationHelper.Result;
            var resultBit = BitConverter.GetBytes(result);
            HttpContext.Session.Set("VerificationCode", resultBit);
            return Json(bytes);
        }

        [HttpPost]
        public IActionResult VerificationPassword(VerificationPasswordModel verificationPasswordModel)
        {
            if (!ModelState.IsValid)
            {
                return View(verificationPasswordModel);
            }
            string memberpasswordKey = "";
            var isPasswordRight = CheckOldPassword(verificationPasswordModel.OldPassword,out memberpasswordKey);
            if(!isPasswordRight)
            {
                TempData["VerificationErrorMessage"] = "密码验证失败，请确认当前密码!";
                return View(verificationPasswordModel);
            }
            var newPassword = PasswordHelper.GetRfcDerivePassword(verificationPasswordModel.NewPassword, memberpasswordKey);
            var effectCount = _database.UpdateSQL("Members",
                new DataColumn("Password", newPassword),
                new DataColumn("Id", GetCurrentUserClaim("Id"), true));
            TempData["Message"] = effectCount
                    ? "parent.layer.msg('密码修改成功',{icon: 6,shift: -1, time: 500, shade: 0.3},function() { parent.layer.closeAll(); });"
                    : "parent.layer.msg('密码修改失败，请重试',{icon: 5,shift: -1, time: 500, shade: 0.3},function() { parent.layer.closeAll(); });";
            return View(verificationPasswordModel);
        }

        private bool CheckOldPassword(string oldPassword,out string memberpasswordKey)
        {
            var memberPasswordInfo = _database.QuerySQL<dynamic>($@"SELECT Password,PasswordKey FROM Members WHERE Id = {GetCurrentUserClaim("Id")}  AND IsLeave = 0");
            string memberpassword = memberPasswordInfo.Password;
            memberpasswordKey = memberPasswordInfo.PasswordKey;
            if (string.IsNullOrEmpty(memberpassword) || string.IsNullOrEmpty(memberpasswordKey))
            {
                TempData["Message"] = "parent.layer.msg('当前登陆状态已失效，请重新登陆！！',{icon: 5,shift: -1, time: 500, shade: 0.3},function() { parent.layer.closeAll(); });";
                return false;
            }
            return IsPasswordRight(memberpassword, memberpasswordKey, oldPassword);
        }

        [HttpPost]
        public async Task<IActionResult> Login(AccountLoginModel accountLoginModel)
        {
            if(!string.IsNullOrEmpty(accountLoginModel.VerificationCode))
            {
                int.TryParse(accountLoginModel.VerificationCode, out int code);
                HttpContext.Session.TryGetValue("VerificationCode", out byte[] codeByte);
                var serverCode = BitConverter.ToInt32(codeByte);
                if (code != serverCode)
                {
                    TempData["LoginErrorMessage"] = "验证码错误!";
                    accountLoginModel.IsCheck = true;
                    return View(accountLoginModel);
                }
            }
            var memberInfo = new Members();
            var isUserExist = IsUserExist(accountLoginModel.Account, out memberInfo);
            if (!isUserExist)
            {
                TempData["LoginErrorMessage"] = "用户名或密码错误!";
                accountLoginModel.IsCheck = true;
                return View(accountLoginModel);
            }
            else
            {
                var isPasswordRight = IsPasswordRight(memberInfo.Password, memberInfo.PasswordKey, accountLoginModel.Password);
                if (!isPasswordRight)
                {
                    TempData["LoginErrorMessage"] = "用户名或密码错误!";
                    accountLoginModel.IsCheck = true;
                }
                else
                {
                    //写入Claim信息，方便其他地方读取
                    SetCookie(memberInfo,accountLoginModel);
                    TempData["Message"] = "parent.layer.msg('登录成功!', { icon: 6,shift: -1, time: 500, shade: 0.3 }, function() { parent.layer.closeAll(); })";
                }
                return View(accountLoginModel);
            }
        }
        private async void SetCookie(Members memberInfo, AccountLoginModel accountLoginModel)
        {
            var claims = new List<Claim>
                    {
                        new Claim("Id", Convert.ToString(memberInfo.Id), ClaimValueTypes.Integer32),
                        new Claim("Name", memberInfo.Name, ClaimValueTypes.String),
                        new Claim("Account", memberInfo.Account, ClaimValueTypes.String),
                        new Claim("IsAdmin", memberInfo.IsAdmin.ToString(), ClaimValueTypes.Boolean),
                    };
            var userIdentity = new ClaimsIdentity("localUserInfo");
            userIdentity.AddClaims(claims);
            AuthenticationProperties authenProperties;
            if ( accountLoginModel.IsCheckBox)
            {
                 authenProperties = new AuthenticationProperties() {
                    IsPersistent = true,
                    ExpiresUtc = DateTime.UtcNow.AddDays(5)
                };
            }
            else
            {
                authenProperties = new AuthenticationProperties();
            }
            await HttpContext.SignInAsync(_configuration["Cookies:SchemeName"], new ClaimsPrincipal(userIdentity), authenProperties);
        }
        
        public async Task<IActionResult> Logout()
        {
            await HttpContext.SignOutAsync(_configuration["Cookies:SchemeName"],new AuthenticationProperties { IsPersistent = true });
            return Redirect("/Home/Index");
        }

        public bool IsUserExist(string account, out Members accountInfo)
        {
            accountInfo = _database.QuerySQL<Members>($@"SELECT * FROM MEMBERS WHERE Account = @Account  AND IsLeave = 0",
                                        new Dictionary<string, object>() { { "Account", account } });
            return accountInfo != null;
        }


        public bool IsPasswordRight(string userpassword, string userpasswordKey, string loginPassword)
        {
            var rfcPassword = PasswordHelper.GetRfcDerivePassword(loginPassword, userpasswordKey);
            return rfcPassword.Equals(userpassword);
        }
    }
}