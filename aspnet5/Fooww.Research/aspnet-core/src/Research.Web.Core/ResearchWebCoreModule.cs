using System;
using System.Reflection;
using System.Text;
using Abp.AspNetCore;
using Abp.AspNetCore.Configuration;
using Abp.Modules;
using Abp.Reflection.Extensions;
using Abp.Zero.Configuration;
using Research.Authentication.JwtBearer;
using Research.Configuration;
using Research.EntityFrameworkCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using Abp.Runtime.Caching.Redis;

#if FEATURE_SIGNALR
using Abp.Web.SignalR;
#endif

namespace Research
{
    [DependsOn(
         typeof(ResearchApplicationModule),
         typeof(ResearchEntityFrameworkModule),
         typeof(AbpAspNetCoreModule)
         //,typeof(AbpRedisCacheModule) 
#if FEATURE_SIGNALR
        ,typeof(AbpWebSignalRModule)
#endif
     )]
    public class ResearchWebCoreModule : AbpModule
    {
        private readonly IHostingEnvironment _env;
        private readonly IConfigurationRoot _appConfiguration;
    

        public ResearchWebCoreModule(IHostingEnvironment env)
        {
            _env = env;
            _appConfiguration = env.GetAppConfiguration();
        }

        public override void PreInitialize()
        {

            #region AbpRedisCacheModule
            //Configuration.Caching.UseRedis(options =>
            //{
            //    options.ConnectionString = _appConfiguration["Abp:RedisCache:ConnectionString"];
            //    options.DatabaseId = _appConfiguration.GetValue<int>("Abp:RedisCache:DatabaseId");
            //});

            //设置所有缓存的默认过期时间
            //Configuration.Caching.ConfigureAll(cache =>
            //{
            //    cache.DefaultAbsoluteExpireTime = TimeSpan.FromMinutes(2);
            //});
            //设置某个缓存的默认过期时间 根据 "CacheName" 来区分
            //Configuration.Caching.Configure("CacheName", cache =>
            //{
            //    cache.DefaultAbsoluteExpireTime = TimeSpan.FromMinutes(10);
            //});

            #endregion

            Configuration.DefaultNameOrConnectionString = _appConfiguration.GetConnectionString(
                ResearchConsts.ConnectionStringName
            );

            //Use database for language management
            Configuration.Modules.Zero().LanguageManagement.EnableDbLocalization();

            Configuration.Modules.AbpAspNetCore()
                 .CreateControllersForAppServices(
                     typeof(ResearchApplicationModule).GetAssembly()
                 );

            ConfigureTokenAuth();
        }

        private void ConfigureTokenAuth()
        {
            IocManager.Register<TokenAuthConfiguration>();
            var tokenAuthConfig = IocManager.Resolve<TokenAuthConfiguration>();

            tokenAuthConfig.SecurityKey = new SymmetricSecurityKey(Encoding.ASCII.GetBytes(_appConfiguration["Authentication:JwtBearer:SecurityKey"]));
            tokenAuthConfig.Issuer = _appConfiguration["Authentication:JwtBearer:Issuer"];
            tokenAuthConfig.Audience = _appConfiguration["Authentication:JwtBearer:Audience"];
            tokenAuthConfig.SigningCredentials = new SigningCredentials(tokenAuthConfig.SecurityKey, SecurityAlgorithms.HmacSha256);
            tokenAuthConfig.Expiration = TimeSpan.FromDays(1);
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(ResearchWebCoreModule).GetAssembly());
        }
    }
}
