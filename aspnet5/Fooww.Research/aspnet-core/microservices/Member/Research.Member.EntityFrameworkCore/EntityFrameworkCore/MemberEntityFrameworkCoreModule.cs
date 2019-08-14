using Abp.EntityFrameworkCore;
using Abp.Modules;
using Abp.Reflection.Extensions;

namespace Research.Member.EntityFrameworkCore
{
    [DependsOn(
        typeof(MemberCoreModule), 
        typeof(AbpEntityFrameworkCoreModule))]
    public class MemberEntityFrameworkCoreModule : AbpModule
    {
        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(MemberEntityFrameworkCoreModule).GetAssembly());
        }
    }
}