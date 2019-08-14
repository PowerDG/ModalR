using Abp.EntityFrameworkCore;
using Abp.Modules;
using Abp.Reflection.Extensions;

namespace PartyService.Host.EntityFrameworkCore
{
    [DependsOn(
        typeof(PartyCoreModule),
        typeof(AbpEntityFrameworkCoreModule))]
    public class PartyEntityFrameworkCoreModule : AbpModule
    {
        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(PartyEntityFrameworkCoreModule).GetAssembly());
        }
    }
}