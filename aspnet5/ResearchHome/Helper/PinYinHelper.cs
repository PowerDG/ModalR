using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ResearchHome.Helper
{
    public class PinYinHelper
    {

        /// <summary>
        /// 汉字转全拼
        /// </summary>
        /// <param name="strChinese"></param>
        /// <returns></returns>
        public static string ConvertToAllSpell(string strChinese)
        {
            try
            {
                if (strChinese.Length != 0)
                {
                    StringBuilder fullSpell = new StringBuilder();
                    for (int i = 0; i < strChinese.Length; i++)
                    {
                        var chr = strChinese[i];
                        string pinyin = string.Empty;
                        if (i == 0)
                        {
                            pinyin = GetFromPinYinDic(chr);
                        }
                        if (pinyin.Length == 0)
                        {
                            pinyin = Spell(chr);
                        }
                        fullSpell.Append(pinyin);
                    }

                    return fullSpell.ToString().ToLower();
                }
            }
            catch (Exception e)
            {
                Console.WriteLine("全拼转化出错！" + e.Message);
            }

            return string.Empty;
        }

        private static string Spell(char strChinese)
        {
            return NPinyin.Pinyin.GetPinyin(strChinese);
        }

        /// <summary>
        /// 从字典获取拼音
        /// </summary>
        /// <param name="c">字</param>
        /// <param name="pinyinDic">字典</param>
        /// <returns></returns>
        private static string GetFromPinYinDic(char c)
        {
            if (PinYinDic == null
                || PinYinDic.Count == 0
                || !PinYinDic.ContainsKey(c))
            {
                return "";
            }
            return PinYinDic[c];
        }

        private static IDictionary<char, string> PinYinDic = new Dictionary<char, string>() {
            { '红', "hong" },
            { '贾', "jia" },
            { '薄', "bo" },
            { '褚', "chu" },
            { '翟', "zhai" },
            { '郇', "xun" },
            { '盖', "ge" },
            { '乐', "yue" },
            { '区', "ou" },
            { '卜', "bu" },
            { '曾', "zeng" },
            { '丁', "ding" },
            { '无', "wu" },
            { '长', "chang" },
            { '其', "qi" },
            { '巷', "xiang" },
            { '将', "jiang" },
            { '氏', "shi" },
            { '色', "se" },
            { '系', "xi" },
            { '重', "chong" },
            { '乜', "nie" },
            { '孛', "bo" },
            { '卒', "zu" },
            { '单', "shan" },
            { '解', "xie" },
            { '仇', "qiu" },
            { '隗', "wei" },
            { '查', "zha" },
            { '繁', "po" },
            { '朴', "piao" }
        };
    }
}
