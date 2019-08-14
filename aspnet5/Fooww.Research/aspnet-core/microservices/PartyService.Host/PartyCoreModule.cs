using Abp.Modules;
using Abp.Reflection.Extensions;

namespace PartyService.Host
{
    public class PartyCoreModule : AbpModule
    {
        public override void PreInitialize()
        {
            Configuration.Auditing.IsEnabledForAnonymousUsers = true;

            //  MyCompanyLocalizationConfigurer.Configure(Configuration.Localization);
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(PartyCoreModule).GetAssembly());
        }
    }
}