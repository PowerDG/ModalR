using Abp.Extensions;
using Abp.UI;
using Abp.Web.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Filters;
using Newtonsoft.Json;
using ResearchService.Host.Web;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;

namespace ResearchService.Host.Web
{
    public class AjaxHelper
    {
        public static string GetCurrentUserId(ActionExecutingContext filterContext)
        {
            try
            {
                var headers = filterContext.HttpContext.Request.Headers;
                var auth = headers["Authorization"];
                var token = JwtDecodeHelper.JWTDecoder(auth);
                var userToekn = JsonConvert.DeserializeObject<dynamic>(token);
                return userToekn.sub;
            }
            catch (Exception)
            {
                throw new UserFriendlyException(403, "Could not Verify your identity");
            }
        }

        public static string UrlPath(string serviceName, string apiPath)
        {
            var ip = ConsulHelper.GetServiceAddress(serviceName);
            if (string.IsNullOrEmpty(ip))
            {
                return "";
            }
            return ip.EnsureEndsWith('/') + apiPath;
        }

        #region //AjaxResponse为ABP自动包装的JSON格式

        /// <summary>
        /// 通过地址和参数取得返回OutPut数据
        /// </summary>
        /// <param name="url"></param>
        /// <param name="input">请求参数</param>
        /// <returns></returns>
        public static AjaxResponse ResultGet(string url, object input = null)

        {
            var data = Get(url, input);
            var response = JsonConvert.DeserializeObject<AjaxResponse>(data);
            return response;
        }

        /// <summary>
        /// 通过地址和参数取得返回OutPut数据
        /// </summary>
        /// <param name="url"></param>
        /// <param name="input">请求参数</param>
        /// <returns></returns>
        public static AjaxResponse ResultPost(string url, object input = null)
        {
            var data = Post(url, input);
            var response = JsonConvert.DeserializeObject<AjaxResponse>(data);
            return response;
        }

        /// <summary>
        ///通过地址和我反序列后的JSON取得返回GeneralOutPut数据
        /// </summary>
        /// <param name="url">请求地址</param>
        /// <param name="input">请求参数</param>
        /// <returns>请求返回的结果</returns>
        private static string Get(string url, object input = null)
        {
            var properties = input?.GetType().GetProperties();
            var parm = string.Empty;
            foreach (var propertie in properties)
            {
                var name = propertie.Name;
                var value = input.GetType().GetProperty(name).GetValue(input);//直接根据属性的名字获取其值

                parm += $"&{ name}={value}";
            }

            parm = parm.Trim('&');
            url = $"{url}?{parm}";

            // Prepare web request...
            HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url);
            request.Method = "GET";
            request.ContentType = "application/json";

            return HttpRequest(request);
        }

        /// <summary>
        /// 指定Post地址使用Get 方式获取全部字符串
        /// </summary>
        /// <param name="url">请求后台地址</param>
        /// <returns></returns>
        ///
        //[Authorize]
        public static string Post(string url, object input)
        {
            HttpWebRequest req = (HttpWebRequest)WebRequest.Create(url);
            req.Method = "POST";
            req.ContentType = "application/x-www-form-urlencoded";

            #region 添加Post 参数

            var parm = JsonConvert.SerializeObject(input);
            byte[] data = Encoding.UTF8.GetBytes(parm);
            req.ContentLength = data.Length;
            using (Stream reqStream = req.GetRequestStream())
            {
                reqStream.Write(data, 0, data.Length);
                reqStream.Close();
            }

            #endregion 添加Post 参数

            return HttpRequest(req);
        }

        /// <summary>
        /// 请求的主体部分（由此完成请求并返回请求结果）
        /// </summary>
        /// <param name="request">请求的对象</param>
        /// <returns>请求返回结果</returns>
        private static string HttpRequest(HttpWebRequest request)
        {
            HttpWebResponse response = null;

            try
            {
                response = (HttpWebResponse)request.GetResponse();
            }
            catch (WebException ex)
            {
                response = (HttpWebResponse)ex.Response;
            }

            string result = string.Empty;
            using (StreamReader reader = new StreamReader(response.GetResponseStream()))
            {
                result = reader.ReadToEnd();
            }

            return result;
        }

        /// <summary>
        /// URL拼写完整性检查
        /// </summary>
        /// <param name="url">待检查的URL</param>
        private static string UrlCheck(string url)
        {
            if (!url.StartsWith("http://") && !url.StartsWith("https://"))
                url = "http://" + url;

            return url;
        }

        #endregion //AjaxResponse为ABP自动包装的JSON格式
    }
}