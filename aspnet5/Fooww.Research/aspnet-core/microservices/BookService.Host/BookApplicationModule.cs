using Abp.AutoMapper;
using Abp.Modules;
using Abp.Reflection.Extensions;

namespace BookService.Host
{
    [DependsOn(
        typeof(BookCoreModule),
        typeof(AbpAutoMapperModule))]
    public class BookApplicationModule : AbpModule
    {
        public override void Initialize()
        {
            var thisAssembly = typeof(BookApplicationModule).GetAssembly();
            IocManager.RegisterAssemblyByConvention(thisAssembly);
            Configuration.Modules.AbpAutoMapper().Configurators.Add(
                // Scan the assembly for classes which inherit from AutoMapper.Profile
                cfg => cfg.AddMaps(thisAssembly)
            );
        }
    }
}