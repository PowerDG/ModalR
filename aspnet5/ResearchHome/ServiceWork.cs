using PeterKottas.DotNetCore.WindowsService.Base;
using PeterKottas.DotNetCore.WindowsService.Interfaces;

namespace ResearchHome
{
    public class ServiceWork : MicroService, IMicroService
    {
        public void Start()
        {
            StartBase();

            Program.BuildWebHost(null).StartAsync();
        }

        public void Stop()
        {
            StopBase();
            Program.BuildWebHost(null).StopAsync();
        }
    }
}
