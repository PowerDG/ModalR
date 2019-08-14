using Abp.AutoMapper;
using Abp.Modules;
using Abp.Reflection.Extensions;

namespace PartyService.Host
{
    [DependsOn(
        typeof(PartyCoreModule),
        typeof(AbpAutoMapperModule))]
    public class PartyApplicationModule : AbpModule
    {
        public override void Initialize()
        {
            var thisAssembly = typeof(PartyApplicationModule).GetAssembly();
            IocManager.RegisterAssemblyByConvention(thisAssembly);
            Configuration.Modules.AbpAutoMapper().Configurators.Add(
                // Scan the assembly for classes which inherit from AutoMapper.Profile
                cfg => cfg.AddMaps(thisAssembly)
            );
        }
    }
}