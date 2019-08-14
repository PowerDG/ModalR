using Abp.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;

namespace Research.Member.EntityFrameworkCore
{
    public class MemberDbContext : AbpDbContext
    {
        //Add DbSet properties for your entities...

        public MemberDbContext(DbContextOptions<MemberDbContext> options) 
            : base(options)
        {

        }
    }
}
