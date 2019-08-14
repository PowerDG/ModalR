using Abp.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using PartyService.Host.Models;

namespace PartyService.Host.EntityFrameworkCore
{
    public class PartyDbContext : AbpDbContext
    {
        //Add DbSet properties for your entities...

        public DbSet<FundModel> Fund { get; set; }
        public DbSet<Party> Parties { get; set; }
        public DbSet<PartyPhoto> PartyPhotos { get; set; }
        public DbSet<PartyComment> PartyComments { get; set; }

        public PartyDbContext(DbContextOptions<PartyDbContext> options)
            : base(options)
        {
        }
    }
}