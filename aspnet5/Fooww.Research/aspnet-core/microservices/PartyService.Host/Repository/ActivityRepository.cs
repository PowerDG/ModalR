using Abp.EntityFrameworkCore;
using PartyService.Host.EntityFrameworkCore;
using PartyService.Host.Models;

namespace PartyService.Host.Repository
{
    public class ActivityRepository : PartyRepositoryBase<Party, long>
    {
        public ActivityRepository(IDbContextProvider<PartyDbContext> dbContextProvider) : base(dbContextProvider)
        {
        }
    }
}