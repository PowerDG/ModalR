using Consul;
using System;
using System.Linq;

namespace ResearchService.Host.Web
{
    public class ConsulHelper
    {
        public static string GetServiceAddress(string serviceName)
        {
            using (var consulClient = new ConsulClient(ConsulConfig))
            {
                var services = consulClient.Catalog.Service(serviceName).Result.Response;
                if (services != null && services.Any())
                {
                    // 模拟随机一台进行请求，这里只是测试，可以选择合适的负载均衡工具或框架
                    Random r = new Random();
                    int index = r.Next(services.Count());
                    var service = services.ElementAt(index);
                    return $"http://{service.ServiceAddress}:{service.ServicePort}";
                }

                return null;
            }
        }

        private static void ConsulConfig(ConsulClientConfiguration c)
        {
            // c.Address = new Uri("http://127.0.0.1:8500");
            c.Address = new Uri("http://192.168.1.102:8500");
            c.Datacenter = "dc1";
        }
    }
}