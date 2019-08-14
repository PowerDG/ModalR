using Abp.AspNetCore;
using Abp.AspNetCore.Configuration;
using Abp.Modules;
using Abp.Reflection.Extensions;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using PartyService.Host.Configuration;
using PartyService.Host.EntityFrameworkCore;

namespace PartyService.Host
{
    [DependsOn(
        typeof(PartyApplicationModule),
        typeof(PartyEntityFrameworkCoreModule),
        typeof(AbpAspNetCoreModule))]
    public class PartyServiceHostModule : AbpModule
    {
        private readonly IHostingEnvironment _env;
        private readonly IConfigurationRoot _appConfiguration;

        public PartyServiceHostModule(IHostingEnvironment env)
        {
            _env = env;
            _appConfiguration = AppConfigurations.Get(env.ContentRootPath, env.EnvironmentName);
        }

        public override void PreInitialize()
        {
            Configuration.DefaultNameOrConnectionString = _appConfiguration.GetConnectionString(PartyServiceHostConsts.ConnectionStringName);

            // Configuration.Navigation.Providers.Add<MyCompanyNavigationProvider>();

            Configuration.Modules.AbpAspNetCore()
                .CreateControllersForAppServices(
                    typeof(PartyApplicationModule).GetAssembly()
                );
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(PartyServiceHostModule).GetAssembly());
        }
    }
}