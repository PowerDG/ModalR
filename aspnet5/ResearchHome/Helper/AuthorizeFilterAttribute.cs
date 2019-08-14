using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using Microsoft.AspNetCore.Routing;
using System;
using System.Linq;

namespace ResearchHome.Helper
{
    public class AuthorizeFilterAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            var userId = CurrentUserInfo(context.HttpContext, "Id");
            if(!string.IsNullOrEmpty(userId))
            {
                base.OnActionExecuting(context);
            }
            else
            {
                context.Result = new ContentResult { Content = @"noAuthorization" };
                //context.Result = new RedirectToRouteResult(
                //new RouteValueDictionary
                //{
                //    { "area", "" },
                //    { "controller", "Home" },
                //    { "action", "NoAuthorization" } 
                //});
            }
        }
        
        public string CurrentUserInfo(HttpContext httpContext,string value)
        {
            if (!httpContext.User.Identity.IsAuthenticated)
            {
                return "";
            }
            try
            {
                var userInfo = httpContext.User.Identities.First(u => u.IsAuthenticated).FindFirst(value.ToString()).Value;
                return userInfo;
            }
            catch (Exception exception)
            {
                return "";
            }
        }
    }
}
