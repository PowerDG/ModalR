using Abp.Authorization;
using Abp.Authorization.Users;
using Abp.Collections.Extensions;
using Abp.Configuration;
using Abp.Domain.Repositories;
using Abp.Domain.Uow;
using Abp.Organizations;
using Abp.Runtime.Caching;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Research.Authorization.Roles;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Research.Authorization.Users
{
    public class UserManager : AbpUserManager<Role, User>
    {
        private IPermissionManager m_permissionManager;

        public UserManager(
            RoleManager roleManager,
            UserStore store,
            IOptions<IdentityOptions> optionsAccessor,
            IPasswordHasher<User> passwordHasher,
            IEnumerable<IUserValidator<User>> userValidators,
            IEnumerable<IPasswordValidator<User>> passwordValidators,
            ILookupNormalizer keyNormalizer,
            IdentityErrorDescriber errors,
            IServiceProvider services,
            ILogger<UserManager<User>> logger,
            IPermissionManager permissionManager,
            IUnitOfWorkManager unitOfWorkManager,
            ICacheManager cacheManager,
            IRepository<OrganizationUnit, long> organizationUnitRepository,
            IRepository<UserOrganizationUnit, long> userOrganizationUnitRepository,
            IOrganizationUnitSettings organizationUnitSettings,
            ISettingManager settingManager)
            : base(
                roleManager,
                store,
                optionsAccessor,
                passwordHasher,
                userValidators,
                passwordValidators,
                keyNormalizer,
                errors,
                services,
                logger,
                permissionManager,
                unitOfWorkManager,
                cacheManager,
                organizationUnitRepository,
                userOrganizationUnitRepository,
                organizationUnitSettings,
                settingManager)
        {
            m_permissionManager = permissionManager;
        }

        public virtual IEnumerable<Permission> GetModuleNamePermissions(string moduleName)
        {
            var moduleNameDict = new Dictionary<string, string>()
            {
                { "BookInfo" ,"Pages.BookInfo" },
                { "PartyInfo" ,"Pages.PartyInfo" },
            };
            var Permissions = m_permissionManager.GetAllPermissions()
                .WhereIf((!string.IsNullOrWhiteSpace(moduleName)) && moduleNameDict.ContainsKey(moduleName),
                                     x => x.Name.StartsWith(moduleNameDict[moduleName]));

            return Permissions;
        }

        public virtual async Task<Dictionary<string, bool>> CheckModulePermissionDictAsync(long userId, string moduleName)
        {
            // var userId = AbpSession.UserId.Value;

            var Permissions = GetModuleNamePermissions(moduleName);
            var permissionNameDict = new Dictionary<string, bool>();
            foreach (var permission in Permissions)
            {
                if (await IsGrantedAsync(userId, permission))
                {
                    permissionNameDict.Add(permission.Name, true);
                }
                else
                {
                    permissionNameDict.Add(permission.Name, false);
                }
            }

            return permissionNameDict;
        }

        public virtual async Task<List<string>> CheckModulePermissionListAsync(long userId, string moduleName)
        {
            //var userId = AbpSession.UserId.Value;

            var Permissions = GetModuleNamePermissions(moduleName);
            var permissionNameList = new List<string>();
            foreach (var permission in Permissions)
            {
                if (await IsGrantedAsync(userId, permission))
                {
                    permissionNameList.Add(permission.Name);
                }
            }

            return permissionNameList;
        }
    }
}