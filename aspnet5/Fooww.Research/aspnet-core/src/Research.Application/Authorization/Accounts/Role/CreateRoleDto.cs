using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using Abp.Authorization.Roles;
using Abp.AutoMapper;
using Research.Authorization.Roles;

namespace Fooww.Research.Roles.Dto
{
    [AutoMapTo(typeof(Role))]
    public class CreateRoleDto
    {
        [Required(ErrorMessage = "角色名不能为空")]
        [StringLength(AbpRoleBase.MaxNameLength)]
        public string Name { get; set; }

        [Required(ErrorMessage = "显示名不能为空")]
        [StringLength(AbpRoleBase.MaxDisplayNameLength)]
        public string DisplayName { get; set; }

        public string NormalizedName { get; set; }

        [StringLength(Role.MaxDescriptionLength)]
        public string Description { get; set; }

        public List<string> Permissions { get; set; }
    }
}