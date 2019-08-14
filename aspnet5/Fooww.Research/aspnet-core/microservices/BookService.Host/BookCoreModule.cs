using Abp.Modules;
using Abp.Reflection.Extensions;

namespace BookService.Host
{
    public class BookCoreModule : AbpModule
    {
        public override void PreInitialize()
        {
            Configuration.Auditing.IsEnabledForAnonymousUsers = true;

            Configuration.EntityHistory.IsEnabled = true;
            //  MyCompanyLocalizationConfigurer.Configure(Configuration.Localization);
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(BookCoreModule).GetAssembly());
        }
    }
}