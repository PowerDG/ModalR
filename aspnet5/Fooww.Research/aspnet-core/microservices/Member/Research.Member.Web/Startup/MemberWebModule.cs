using Abp.AspNetCore;
using Abp.AspNetCore.Configuration;
using Abp.Modules;
using Abp.Reflection.Extensions;
using Research.Member.Configuration;
using Research.Member.EntityFrameworkCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;

namespace Research.Member.Web.Startup
{
    [DependsOn(
        typeof(MemberApplicationModule), 
        typeof(MemberEntityFrameworkCoreModule), 
        typeof(AbpAspNetCoreModule))]
    public class MemberWebModule : AbpModule
    {
        private readonly IConfigurationRoot _appConfiguration;

        public MemberWebModule(IHostingEnvironment env)
        {
            _appConfiguration = AppConfigurations.Get(env.ContentRootPath, env.EnvironmentName);
        }

        public override void PreInitialize()
        {
            Configuration.DefaultNameOrConnectionString = _appConfiguration.GetConnectionString(MemberConsts.ConnectionStringName);

            Configuration.Navigation.Providers.Add<MemberNavigationProvider>();

            Configuration.Modules.AbpAspNetCore()
                .CreateControllersForAppServices(
                    typeof(MemberApplicationModule).GetAssembly()
                );
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(MemberWebModule).GetAssembly());
        }
    }
}