using Abp.EntityFrameworkCore;
using Abp.Modules;
using Abp.Reflection.Extensions;

namespace BookService.Host.EntityFrameworkCore
{
    [DependsOn(
        typeof(BookCoreModule),
        typeof(AbpEntityFrameworkCoreModule))]
    public class BookEntityFrameworkCoreModule : AbpModule
    {
        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(BookEntityFrameworkCoreModule).GetAssembly());
        }
    }
}