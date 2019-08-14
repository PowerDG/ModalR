using System;
using System.Collections.Generic;

namespace ResearchService.Host.Web
{
    public class UserNameHelper
    {
        public static Dictionary<long, string> UserSelectDtos { get; set; } = new Dictionary<long, string>();

        public static string GetUserName(long? id)
        {
            if (id == null)
            {
                return String.Empty;
            }
            UserSelectDtos.TryGetValue(id.Value, out string name);
            return name;
        }
    }
}