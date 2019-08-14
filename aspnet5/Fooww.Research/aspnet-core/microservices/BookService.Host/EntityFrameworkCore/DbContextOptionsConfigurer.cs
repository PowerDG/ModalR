using Microsoft.EntityFrameworkCore;

namespace BookService.Host.EntityFrameworkCore
{
    public static class DbContextOptionsConfigurer
    {
        public static void Configure(
            DbContextOptionsBuilder<BookDbContext> dbContextOptions,
            string connectionString
            )
        {
            /* This is the single point to configure DbContextOptions for MyCompanyDbContext */
            dbContextOptions.UseMySql(connectionString);
        }
    }
}