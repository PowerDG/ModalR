using Microsoft.AspNetCore;
using Microsoft.AspNetCore.Hosting;

namespace ResearchHome
{
    public class Program
    {
        private static readonly ServiceWork Service = new ServiceWork();

        public static void Main(string[] args)
        {
            BuildWebHost(args).Run();
        }

        public static IWebHost BuildWebHost(string[] args)
        {
            return WebHost.CreateDefaultBuilder(args)
                .UseStartup<Startup>()
                .UseUrls("http://*:5100")
                .Build();
        }
    }
}