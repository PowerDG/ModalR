using Abp.Extensions;
using System.Net.Http;
using System.Threading.Tasks;

namespace ResearchService.Host.Web
{
    public class HttpHelper
    {
        /// <summary>
        /// http://192.168.1.136:5001/api/services/app/User/GetAllUserName
        /// </summary>
        /// <param name="serviceName"></param>
        /// <param name="apiPath"></param>
        /// <returns></returns>
        public static async Task<string> Get(string serviceName, string apiPath)
        {
            var ip = ConsulHelper.GetServiceAddress(serviceName);
            if (string.IsNullOrEmpty(ip))
            {
                return "";
            }
            using (HttpClient http = new HttpClient())
            {
                //                http.SetBearerToken(token);
                var url = ip.EnsureEndsWith('/') + apiPath;
                var msg = await http.GetAsync(url);
                string result = await msg.Content.ReadAsStringAsync();
                return result;
            }
        }

        public static async Task<string> Post(string serviceName, string apiPath)
        {
            var ip = ConsulHelper.GetServiceAddress(serviceName);
            if (string.IsNullOrEmpty(ip))
            {
                return "";
            }
            using (HttpClient http = new HttpClient())
            {
                //TODO(sunyongl): post请求
                //                http.SetBearerToken(token);
                var url = ip.EnsureEndsWith('/') + apiPath;
                var body = new StringContent("");

                var msg = await http.PostAsync(url, body);
                string result = await msg.Content.ReadAsStringAsync();
                return result;
            }
        }
    }
}