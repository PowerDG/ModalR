using Research.Member.Configuration;
using Research.Member.Web;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Design;
using Microsoft.Extensions.Configuration;

namespace Research.Member.EntityFrameworkCore
{
    /* This class is needed to run EF Core PMC commands. Not used anywhere else */
    public class MemberDbContextFactory : IDesignTimeDbContextFactory<MemberDbContext>
    {
        public MemberDbContext CreateDbContext(string[] args)
        {
            var builder = new DbContextOptionsBuilder<MemberDbContext>();
            var configuration = AppConfigurations.Get(WebContentDirectoryFinder.CalculateContentRootFolder());

            DbContextOptionsConfigurer.Configure(
                builder,
                configuration.GetConnectionString(MemberConsts.ConnectionStringName)
            );

            return new MemberDbContext(builder.Options);
        }
    }
}