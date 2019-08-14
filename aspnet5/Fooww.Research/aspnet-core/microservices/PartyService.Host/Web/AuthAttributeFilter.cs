using Abp.Authorization;
using Abp.UI;
using Microsoft.AspNetCore.Mvc.Filters;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchService.Host.Web
{
    public class AuthAttributeFilter : ActionFilterAttribute
    {
        public IList<string> permissionNames { get; set; }

        public string permissionName { get; set; }

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            base.OnActionExecuting(filterContext);
            var userId = AjaxHelper.GetCurrentUserId(filterContext);
            if ((PermissionNames.Green_Channel == permissionName))
            {
                return;
            }
            if (!PermissionFilter.IsGrantedAsync(userId, permissionName))
            {
                throw new UserFriendlyException(403, "Your 'permissionNames' did not match the one on record");
            }
        }

        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            base.OnActionExecuted(filterContext);
        }

        public override void OnResultExecuting(ResultExecutingContext filterContext)
        {
            base.OnResultExecuting(filterContext);
        }

        public override void OnResultExecuted(ResultExecutedContext filterContext)
        {
            base.OnResultExecuted(filterContext);
        }
    }
}