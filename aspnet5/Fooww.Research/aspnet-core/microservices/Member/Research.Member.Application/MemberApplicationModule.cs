using Abp.AutoMapper;
using Abp.Modules;
using Abp.Reflection.Extensions;

namespace Research.Member
{
    [DependsOn(
        typeof(MemberCoreModule), 
        typeof(AbpAutoMapperModule))]
    public class MemberApplicationModule : AbpModule
    {
        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(MemberApplicationModule).GetAssembly());
        }
    }
}