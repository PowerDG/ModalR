using ResearchHome.Areas.Introduction.Models;
using System;
using System.Xml.Linq;

namespace ResearchHome.Helper
{
    public class XmlHelper
    {
        public static IntroductionsModel ReadXmlData(string urlPath)
        {
            XDocument document = XDocument.Load(urlPath);
            //获取到XML的根元素进行操作
            var root = document.Root;
            var titleNode = root.Element("title");
            var contentNode = root.Element("content");
            return new IntroductionsModel
            {
                Title = titleNode.ToString().Replace("<title>", "").Replace("</title>", ""),
                Content = contentNode.ToString().Replace("<content>", "").Replace("</content>", "")
            };
        }
        
        public static bool WriteXmlData(string rootName, string urlPath, IntroductionsModel introductionsModel,out string Message)
        {
            Message = "";
            XDocument document = new XDocument();
            XElement root = new XElement(rootName);
            root.SetElementValue("title", introductionsModel.Title);
            root.SetElementValue("content", introductionsModel.Content);
            try
            {
                root.Save(urlPath);
            }
            catch (Exception e)
            {
                Message = e.Message;
                return false;
            }
            return true;
        }
    }
}
