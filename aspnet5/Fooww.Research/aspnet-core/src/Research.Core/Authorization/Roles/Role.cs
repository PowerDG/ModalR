using Abp.Authorization.Roles;
using Research.Authorization.Users;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Research.Authorization.Roles
{
    public class Role : AbpRole<User>
    {
        //Can add application specific role properties here


        public const int MaxDescriptionLength = 5000;
        [StringLength(MaxDescriptionLength)]

        [Column("description")]
        public string Description { get; set; }
        public Role()
        {

        }

        public Role(int? tenantId, string displayName)
            : base(tenantId, displayName)
        {

        }

        public Role(int? tenantId, string name, string displayName)
            : base(tenantId, name, displayName)
        {

        }
    }
}