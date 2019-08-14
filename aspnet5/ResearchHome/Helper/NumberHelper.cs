using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Helper
{
    public class NumberHelper
    {
        public static string ChineseTONumber(string chinesePara)
        {
            string numStr = "0123456789";
            string chineseStr = "零一二三四五六七八九";
            char[] c = chinesePara.ToCharArray();
            for (int i = 0; i < c.Length; i++)
            {
                int index = chineseStr.IndexOf(c[i]); if (index != -1) c[i] = numStr.ToCharArray()[index];
            }
            return new string(c);
        }
        public static string NumberToChinese(string numberPara)
        {
            string numStr = "0123456789";
            string chineseStr = "零一二三四五六七八九";
            char[] c = numberPara.ToCharArray();
            for (int i = 0; i < c.Length; i++)
            {
                int index = numStr.IndexOf(c[i]); if (index != -1) c[i] = chineseStr.ToCharArray()[index];
            }
            return new string(c);
        }
    }
}
