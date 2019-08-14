using Microsoft.EntityFrameworkCore;

namespace PartyService.Host.EntityFrameworkCore
{
    public static class DbContextOptionsConfigurer
    {
        public static void Configure(
            DbContextOptionsBuilder<PartyDbContext> dbContextOptions,
            string connectionString
            )
        {
            /* This is the single point to configure DbContextOptions for MyCompanyDbContext */
            dbContextOptions.UseMySql(connectionString);
        }
    }
}