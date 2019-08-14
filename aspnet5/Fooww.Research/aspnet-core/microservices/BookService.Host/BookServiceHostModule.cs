using Abp.AspNetCore;
using Abp.AspNetCore.Configuration;
using Abp.Modules;
using Abp.Reflection.Extensions;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using BookService.Host.Configuration;
using BookService.Host.EntityFrameworkCore;
using ResearchService.Host.Web;

namespace BookService.Host
{
    [DependsOn(
        typeof(BookApplicationModule),
        typeof(BookEntityFrameworkCoreModule),
        typeof(AbpAspNetCoreModule))]
    public class BookServiceHostModule : AbpModule
    {
        private readonly IHostingEnvironment _env;
        private readonly IConfigurationRoot _appConfiguration;

        public BookServiceHostModule(IHostingEnvironment env)
        {
            _env = env;
            _appConfiguration = AppConfigurations.Get(env.ContentRootPath, env.EnvironmentName);
        }

        public override void PreInitialize()
        {
            Configuration.DefaultNameOrConnectionString = _appConfiguration.GetConnectionString(ResearchServiceConsts.ConnectionStringName);

            // Configuration.Navigation.Providers.Add<MyCompanyNavigationProvider>();

            Configuration.Modules.AbpAspNetCore()
                .CreateControllersForAppServices(
                    typeof(BookApplicationModule).GetAssembly()
                );
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(BookServiceHostModule).GetAssembly());
        }
    }
}