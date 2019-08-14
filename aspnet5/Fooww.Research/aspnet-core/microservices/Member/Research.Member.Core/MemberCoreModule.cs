using Abp.Modules;
using Abp.Reflection.Extensions;
using Research.Member.Localization;

namespace Research.Member
{
    public class MemberCoreModule : AbpModule
    {
        public override void PreInitialize()
        {
            Configuration.Auditing.IsEnabledForAnonymousUsers = true;

            MemberLocalizationConfigurer.Configure(Configuration.Localization);
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(MemberCoreModule).GetAssembly());
        }
    }
}