using System.Linq;
using System.Threading.Tasks;
using Abp.Authorization;
using Research.Authorization.Roles;
using Research.Roles.Dto;
using System.Collections.Generic;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Abp.Domain.Repositories;
using Abp.Extensions;
using Abp.IdentityFramework;
using Abp.Linq.Extensions;
using Research.Authorization.Users;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

using AutoMapper;
using System;
using Research.Authorization;

namespace Research.Roles
{
    /* THIS IS JUST A SAMPLE. */

    //[AbpAuthorize(PermissionNames.Pages_Roles)]
    public class RoleAppService : AsyncCrudAppService<Role, RoleDto, int, PagedRoleResultRequestDto, CreateRoleDto, RoleDto>, IRoleAppService
    {
        private readonly UserManager m_userManager;
        private readonly RoleManager m_roleManager;
        private readonly IPermissionManager m_permissionManager;

        public RoleAppService(IRepository<Role> repository,
             UserManager userManager,
            RoleManager roleManager,
            IPermissionManager permissionManager)
            : base(repository)
        {
            m_userManager = userManager;
            m_roleManager = roleManager;
            m_permissionManager = permissionManager;
        }

        /// <summary>
        /// 更改权限列表
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public async Task<List<string>> SetRoleMenu(RoleMenuDto input)
        {
            var role = await m_roleManager.GetRoleByIdAsync(input.RoleId);

            CheckErrors(await m_roleManager.UpdateAsync(role));

            var grantedPermissions = PermissionManager
                .GetAllPermissions()
                .Where(p => input.Permissions.Contains(p.Name))
                .ToList();

            await m_roleManager.SetGrantedPermissionsAsync(role, grantedPermissions);
            var pers = (from p in role.Permissions
                        select p.Name).ToList();

            return pers;
        }

        /// <summary>
        /// RoleId对应所有权限
        /// </summary>
        /// <param name="roleId"></param>
        /// <returns></returns>
        public async Task<List<string>> GetPermissions(int roleId)
        {
            var grantedPermissions = (await m_roleManager.GetGrantedPermissionsAsync(roleId)).ToArray();
            var pers = (from p in grantedPermissions
                        select p.Name).ToList();
            return pers;
        }

        /// <summary>
        /// 创建空角色
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public async Task<RoleDto> CreateSingle(CreateSingleDto input)
        {
            CheckCreatePermission();

            var role = ObjectMapper.Map<Role>(input);
            role.SetNormalizedName();

            CheckErrors(await m_roleManager.CreateAsync(role));

            return MapToEntityDto(role);
        }

        public override async Task<RoleDto> Create(CreateRoleDto input)
        {
            CheckCreatePermission();

            var role = ObjectMapper.Map<Role>(input);
            role.SetNormalizedName();

            CheckErrors(await m_roleManager.CreateAsync(role));

            var grantedPermissions = PermissionManager
                .GetAllPermissions()
                .Where(p => input.Permissions.Contains(p.Name))
                .ToList();

            await m_roleManager.SetGrantedPermissionsAsync(role, grantedPermissions);

            return MapToEntityDto(role);
        }

        public async Task<ListResultDto<RoleListDto>> GetRolesAsync(GetRolesInput input)
        {
            var roles = await m_roleManager
                .Roles
                .WhereIf(
                    !input.Permission.IsNullOrWhiteSpace(),
                    r => r.Permissions.Any(rp => rp.Name == input.Permission && rp.IsGranted)
                )
                .ToListAsync();

            return new ListResultDto<RoleListDto>(ObjectMapper.Map<List<RoleListDto>>(roles));
        }

        public async Task SetRole(int roleId, string permissionName)
        {
            var permissionNames = new List<Permission>();
            var role = await m_roleManager.GetRoleByIdAsync(roleId);
            await m_roleManager.SetGrantedPermissionsAsync(roleId, permissionNames);
        }

        private async Task SetRoles(User user, string oldRoleName)
        {
            var roleName = new string[] { oldRoleName };
            CheckErrors(await m_userManager.SetRoles(user, roleName));
        }

        public async Task<RoleDto> UpdateRolePermissions(UpdateRolePermissionsInput input)
        {
            var role = await m_roleManager.GetRoleByIdAsync(input.RoleId);
            var grantedPermissions = m_permissionManager
                .GetAllPermissions()
                .Where(p => input.GrantedPermissionNames.Contains(p.Name))
                .ToList();

            await m_roleManager.SetGrantedPermissionsAsync(role, grantedPermissions);
            return MapToEntityDto(role);
        }

        public override async Task<RoleDto> Update(RoleDto input)
        {
            CheckUpdatePermission();

            var role = await m_roleManager.GetRoleByIdAsync(input.Id);

            ObjectMapper.Map(input, role);

            CheckErrors(await m_roleManager.UpdateAsync(role));

            var grantedPermissions = PermissionManager
                .GetAllPermissions()
                .Where(p => input.Permissions.Contains(p.Name))
                .ToList();

            await m_roleManager.SetGrantedPermissionsAsync(role, grantedPermissions);

            return MapToEntityDto(role);
        }

        public override async Task Delete(EntityDto<int> input)
        {
            CheckDeletePermission();

            var role = await m_roleManager.FindByIdAsync(input.Id.ToString());
            var users = await m_userManager.GetUsersInRoleAsync(role.NormalizedName);

            foreach (var user in users)
            {
                CheckErrors(await m_userManager.RemoveFromRoleAsync(user, role.NormalizedName));
            }

            CheckErrors(await m_roleManager.DeleteAsync(role));
        }

        public Task<ListResultDto<PermissionDto>> GetAllPermissions()
        {
            var permissions = PermissionManager.GetAllPermissions();

            return Task.FromResult(new ListResultDto<PermissionDto>(
                ObjectMapper.Map<List<PermissionDto>>(permissions)
            ));
        }

        protected override IQueryable<Role> CreateFilteredQuery(PagedRoleResultRequestDto input)
        {
            return Repository.GetAllIncluding(x => x.Permissions)
                .WhereIf(!input.Keyword.IsNullOrWhiteSpace(), x => x.Name.Contains(input.Keyword)
                || x.DisplayName.Contains(input.Keyword)
                || x.Description.Contains(input.Keyword));
        }

        protected override async Task<Role> GetEntityByIdAsync(int id)
        {
            return await Repository.GetAllIncluding(x => x.Permissions).FirstOrDefaultAsync(x => x.Id == id);
        }

        protected override IQueryable<Role> ApplySorting(IQueryable<Role> query, PagedRoleResultRequestDto input)
        {
            return query.OrderBy(r => r.DisplayName);
        }

        protected virtual void CheckErrors(IdentityResult identityResult)
        {
            identityResult.CheckErrors(LocalizationManager);
        }

        public async Task<GetRoleForEditOutput> GetRoleForEdit(EntityDto input)
        {
            var permissions = PermissionManager.GetAllPermissions();
            var role = await m_roleManager.GetRoleByIdAsync(input.Id);
            var grantedPermissions = (await m_roleManager.GetGrantedPermissionsAsync(role)).ToArray();
            var roleEditDto = ObjectMapper.Map<RoleEditDto>(role);

            return new GetRoleForEditOutput
            {
                Role = roleEditDto,
                Permissions = ObjectMapper.Map<List<FlatPermissionDto>>(permissions).OrderBy(p => p.DisplayName).ToList(),
                GrantedPermissionNames = grantedPermissions.Select(p => p.Name).ToList()
            };
        }
    }
}