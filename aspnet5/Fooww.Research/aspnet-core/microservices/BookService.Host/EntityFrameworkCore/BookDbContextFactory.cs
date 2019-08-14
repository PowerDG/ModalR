using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using BookService.Host.Configuration;
using ResearchService.Host.Web;

namespace BookService.Host.EntityFrameworkCore
{
    /* This class is needed to run EF Core PMC commands. Not used anywhere else */

    public class BookDbContextFactory : IDesignTimeDbContextFactory<BookDbContext>
    {
        public BookDbContext CreateDbContext(string[] args)
        {
            var builder = new DbContextOptionsBuilder<BookDbContext>();
            var configuration = AppConfigurations.Get(WebContentDirectoryFinder.CalculateContentRootFolder());

            DbContextOptionsConfigurer.Configure(
                builder,
                configuration.GetConnectionString(ResearchServiceConsts.ConnectionStringName)
            );

            return new BookDbContext(builder.Options);
        }
    }
}