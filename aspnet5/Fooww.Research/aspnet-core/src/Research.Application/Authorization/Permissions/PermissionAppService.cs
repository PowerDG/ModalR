using Abp.Application.Services;
using Abp.Authorization;
using Abp.Runtime.Session;
using AutoMapper;
using Research.Authorization.Users;
using Research.Roles.Dto;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Research.Authorization.Permissions
{
    public class PermissionAppService : ResearchAppServiceBase, IApplicationService
    {
        private readonly IAbpSession m_abpSession;
        private readonly UserManager m_userManager;
        private readonly IPermissionManager m_permissionManager;

        public PermissionAppService(
            IPermissionManager permissionManager,
            IAbpSession abpSession,
            UserManager userManager
            )
        {
            m_abpSession = abpSession;
            m_userManager = userManager;
            m_permissionManager = permissionManager;
        }

        public virtual Task<Dictionary<string, bool>> ModuleNamePermissionsDict(long userId, string moduleName)
        {
            return m_userManager.CheckModulePermissionDictAsync(userId, moduleName);
        }

        public virtual Task<List<string>> ModuleNamePermissionsList(long userId, string moduleName)
        {
            return m_userManager.CheckModulePermissionListAsync(userId, moduleName);
        }

        public virtual Task<bool> CheckGrantedPermissionsAsync(string permissionName)
        {
            return PermissionChecker.IsGrantedAsync(permissionName);
        }

        public virtual async Task<bool> CheckAssignedPermissionsAsync(long userId, string permissionName)
        {
            return await m_userManager.IsGrantedAsync(userId, permissionName);
        }

        public virtual async Task<List<PermissionDto>> GetGrantedCurrentPermissionsAsync()
        {
            var userId = AbpSession.UserId.Value;
            var permissionList = new List<PermissionDto>();
            foreach (var permission in m_permissionManager.GetAllPermissions())
            {
                if (await m_userManager.IsGrantedAsync(userId, permission))
                {
                    permissionList.Add(Mapper.Map<PermissionDto>(permission));
                }
            }
            return permissionList;
        }

        public virtual async Task<List<PermissionDto>> GetGrantedAllPermissionsAsync(long userId)
        {
            var permissionList = new List<PermissionDto>();
            foreach (var permission in m_permissionManager.GetAllPermissions())
            {
                if (await m_userManager.IsGrantedAsync(userId, permission))
                {
                    permissionList.Add(Mapper.Map<PermissionDto>(permission));
                }
            }
            return permissionList;
        }
    }
}