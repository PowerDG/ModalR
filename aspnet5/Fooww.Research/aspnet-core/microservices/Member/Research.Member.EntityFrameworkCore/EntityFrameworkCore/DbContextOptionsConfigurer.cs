using Microsoft.EntityFrameworkCore;

namespace Research.Member.EntityFrameworkCore
{
    public static class DbContextOptionsConfigurer
    {
        public static void Configure(
            DbContextOptionsBuilder<MemberDbContext> dbContextOptions, 
            string connectionString
            )
        {
            /* This is the single point to configure DbContextOptions for MemberDbContext */
            dbContextOptions.UseMySql(connectionString);
        }
    }
}
