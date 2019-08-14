using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;
using PartyService.Host.Configuration;
using ResearchService.Host.Web;

//using MyCompany.Configuration;
//using MyCompany.Web;

namespace PartyService.Host.EntityFrameworkCore
{
    /* This class is needed to run EF Core PMC commands. Not used anywhere else */

    public class PartyDbContextFactory : IDesignTimeDbContextFactory<PartyDbContext>
    {
        public PartyDbContext CreateDbContext(string[] args)
        {
            var builder = new DbContextOptionsBuilder<PartyDbContext>();
            var configuration = AppConfigurations.Get(WebContentDirectoryFinder.CalculateContentRootFolder());

            DbContextOptionsConfigurer.Configure(
                builder,
                configuration.GetConnectionString(PartyServiceHostConsts.ConnectionStringName)
            );

            return new PartyDbContext(builder.Options);
        }
    }
}