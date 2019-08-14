using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Models
{
    public static class CommonDictionary
    {
        public static Dictionary<int, string> AppraisalLevel = new Dictionary<int, string>()
        {
            { 1, "低于预期" },
            { 2, "达到预期" },
            { 3, "超出预期" },
            { 4, "表现杰出" }
        };

        public static Dictionary<int, string> AppraisalType = new Dictionary<int, string>()
        {
            { 1, "年中" },
            { 2, "年末" },
            { 3, "转正" }
        };
    }
}
