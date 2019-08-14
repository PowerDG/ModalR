using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Abp.UI;

namespace ResearchService.Host.Web
{
    public class PermissionFilter
    {
        public static bool IsGrantedAsync(string userCliamId, string permissionName)
        {
            long.TryParse(userCliamId, out long userId);
            return IsGrantedAsync(userId, permissionName);
        }

        public static bool IsGrantedAsync(long userId, string permissionName)
        {
            var url = AjaxHelper.UrlPath("Fooww.Research.Web.Host", "api/services/app/Permission/CheckAssignedPermissionsAsync");
            url += $"?userId={userId}&permissionName={permissionName}";
            var ajaxResponse = AjaxHelper.ResultPost(url);
            if (ajaxResponse.Success == false)
            {
                throw new UserFriendlyException(403, "Your 'permissionNames' did not match");
            }
            bool result = ajaxResponse.Result.ToString().ToLowerInvariant().Equals("true");
            return result;
        }

        public static List<string> GetModuleNamePermissionsList(long userId, string moduleName)
        {
            var url = AjaxHelper.UrlPath("Fooww.Research.Web.Host", "api/services/app/Permission/ModuleNamePermissionsList");
            url += $"?userId={userId}&moduleName={moduleName}";
            var ajaxResponse = AjaxHelper.ResultPost(url);
            if (ajaxResponse.Success == false)
            {
                throw new UserFriendlyException(403, "Your 'permissionNames' did not match");
            }
            var c = ajaxResponse.Result.ToString();
            var modulePermissionsList = JsonConvert.DeserializeObject<List<string>>(ajaxResponse.Result.ToString());
            return modulePermissionsList;
        }

        public static Dictionary<string, bool> GetModuleNamePermissionsDict(long userId, string moduleName)
        {
            var url = AjaxHelper.UrlPath("Fooww.Research.Web.Host", "api/services/app/Permission/ModuleNamePermissionsDict");
            url += $"?userId={userId}&moduleName={moduleName}";
            var ajaxResponse = AjaxHelper.ResultPost(url);
            if (ajaxResponse.Success == false)
            {
                throw new UserFriendlyException(403, "Your 'permissionNames' did not match");
            }
            var modulePermissionsList = JsonConvert.DeserializeObject<Dictionary<string, bool>>(ajaxResponse.Result.ToString());
            return modulePermissionsList;
        }
    }
}