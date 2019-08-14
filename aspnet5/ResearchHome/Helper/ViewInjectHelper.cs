using Microsoft.AspNetCore.Http;
using System;
using System.Linq;

namespace ResearchHome.Helper
{
    /// <summary>
    /// 供视图调用
    /// </summary>
    public class ViewInjectHelper
    {
        private readonly IHttpContextAccessor _accessor;

        public ViewInjectHelper(IHttpContextAccessor accessor)
        {
            _accessor = accessor;
        }

        public string CurrentUserInfo(string value)
        {
            if (!_accessor.HttpContext.User.Identity.IsAuthenticated)
            {
                return "";
            }
            try
            {
                var userInfo = _accessor.HttpContext.User.Identities.First(u => u.IsAuthenticated).FindFirst(value.ToString()).Value;
                return userInfo;
            }
            catch(Exception exception)
            {
                return "";
            }
        }
    }
}
