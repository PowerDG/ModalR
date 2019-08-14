using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Abp.Authorization;
using Abp.Domain.Entities;
using Abp.Domain.Repositories;
using Abp.Extensions;
using Abp.IdentityFramework;
using Abp.Linq.Extensions;
using Abp.Localization;
using Abp.Runtime.Session;
using Abp.UI;
using Research.Authorization;
using Research.Authorization.Accounts;
using Research.Authorization.Roles;
using Research.Authorization.Users;
using Research.Roles.Dto;
using Research.Users.Dto;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Abp.Runtime.Caching;
using AutoMapper;
using Abp.Domain.Uow;

namespace Research.Users
{
    //[AbpAuthorize(PermissionNames.Pages_Users)]
    public class UserAppService : AsyncCrudAppService<User, UserDto, long, PagedUserResultRequestDto, CreateUserDto, UserDto>, IUserAppService
    {
        private readonly IRepository<User, long> m_userRepository;
        private readonly UserManager m_userManager;
        private readonly RoleManager m_roleManager;
        private readonly IRepository<Role> m_roleRepository;
        private readonly IPasswordHasher<User> m_passwordHasher;
        private readonly IAbpSession m_abpSession;
        private readonly LogInManager m_logInManager;
        private readonly ICacheManager m_cacheManager;

        public UserAppService(
            IRepository<User, long> userRepository,
            IRepository<User, long> repository,
            UserManager userManager,
            RoleManager roleManager,
            IRepository<Role> roleRepository,
            IPasswordHasher<User> passwordHasher,
            IAbpSession abpSession,
            ICacheManager cacheManager,
        LogInManager logInManager
            )
            : base(repository)
        {
            m_userRepository = userRepository;
            m_userManager = userManager;
            m_roleManager = roleManager;
            m_roleRepository = roleRepository;
            m_passwordHasher = passwordHasher;
            m_abpSession = abpSession;
            m_cacheManager = cacheManager;
            m_logInManager = logInManager;
        }

        [UnitOfWork]
        public override async Task<UserDto> Create(CreateUserDto input)
        {
            CheckCreatePermission();

            var user = ObjectMapper.Map<User>(input);

            user.TenantId = AbpSession.TenantId;
            user.IsEmailConfirmed = true;

            await m_userManager.InitializeOptionsAsync(AbpSession.TenantId);

            CheckErrors(await m_userManager.CreateAsync(user, input.Password));

            if (input.RoleNames != null)
            {
                CheckErrors(await m_userManager.SetRoles(user, input.RoleNames));
            }

            CurrentUnitOfWork.SaveChanges();

            return MapToEntityDto(user);
        }

        public async Task CreateUserWithoutRole(CreateUserInput input)
        {
            CheckCreatePermission();
            var user = ObjectMapper.Map<User>(input);
            user.TenantId = AbpSession.TenantId;
            user.Password = m_passwordHasher.HashPassword(user, input.Password);
            user.IsEmailConfirmed = true;

            CheckErrors(await m_userManager.CreateAsync(user));
        }

        public async Task<UserDto> CreateUserWithSingleRole(CreateUserWithSingleRoleInput input)
        {
            CheckCreatePermission();
            var user = ObjectMapper.Map<User>(input);
            user.TenantId = AbpSession.TenantId;
            user.Password = m_passwordHasher.HashPassword(user, input.Password);
            user.IsEmailConfirmed = true;

            CheckErrors(await m_userManager.CreateAsync(user));
            if (input.RoleNames != null)
            {
                await SetRoles(user, input.RoleNames);
            }
            CurrentUnitOfWork.SaveChanges();
            return MapToEntityDto(user);
        }

        public async Task<UserDto> AddRoleToUser(long userId, string RoleName)
        {
            var user = await m_userManager.FindByIdAsync(userId.ToString());
            await SetRoles(user, RoleName);
            CurrentUnitOfWork.SaveChanges();
            return MapToEntityDto(user);
        }

        public async Task RemoveFromRole(long userId, string roleName)
        {
            var user = await m_userManager.FindByIdAsync(userId.ToString());
            CheckErrors(await m_userManager.RemoveFromRoleAsync(user, roleName));
        }

        private async Task SetRoles(User user, string oldRoleName)
        {
            var roleName = new string[] { oldRoleName };
            CheckErrors(await m_userManager.SetRoles(user, roleName));
        }

        public override async Task<UserDto> Update(UserDto input)
        {
            CheckUpdatePermission();

            var user = await m_userManager.GetUserByIdAsync(input.Id);

            MapToEntity(input, user);

            CheckErrors(await m_userManager.UpdateAsync(user));

            if (input.RoleNames != null)
            {
                CheckErrors(await m_userManager.SetRoles(user, input.RoleNames));
            }

            return await Get(input);
        }

        public async Task<UserDto> UpdateUserWithoutRole(UserWithoutRoleDto input)
        {
            CheckUpdatePermission();

            var user = await m_userManager.GetUserByIdAsync(input.Id);

            Mapper.Map(input, user);

            CheckErrors(await m_userManager.UpdateAsync(user));

            return await Get(input);
        }

        [UnitOfWork]
        public async Task UpdateUserRole(long userId, string oldRoleName, string newRoleName)
        {
            var user = await m_userManager.FindByIdAsync(userId.ToString());
            CheckErrors(await m_userManager.RemoveFromRoleAsync(user, oldRoleName));
            await SetRoles(user, newRoleName);

            CurrentUnitOfWork.SaveChanges();
        }

        public override async Task Delete(EntityDto<long> input)
        {
            var user = await m_userManager.GetUserByIdAsync(input.Id);
            await m_userManager.DeleteAsync(user);
        }

        public async Task<ListResultDto<RoleDto>> GetRoles()
        {
            var roles = await m_roleRepository.GetAllListAsync();
            return new ListResultDto<RoleDto>(ObjectMapper.Map<List<RoleDto>>(roles));
        }

        public async Task ChangeLanguage(ChangeUserLanguageDto input)
        {
            await SettingManager.ChangeSettingForUserAsync(
                AbpSession.ToUserIdentifier(),
                LocalizationSettingNames.DefaultLanguage,
                input.LanguageName
            );
        }

        /// <summary>
        /// Grants a permission for a user if not already granted.
        /// 授予个人权限
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public async Task GrantPermissionAsync(ProhibitPermissionInput input)
        {
            var user = await m_userManager.GetUserByIdAsync(input.UserId);
            var permission = PermissionManager.GetPermission(input.PermissionName);

            await m_userManager.GrantPermissionAsync(user, permission);
        }

        /// <summary>
        /// 禁止个人权限
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        public async Task ProhibitPermission(ProhibitPermissionInput input)
        {
            var user = await m_userManager.GetUserByIdAsync(input.UserId);
            var permission = PermissionManager.GetPermission(input.PermissionName);

            await m_userManager.ProhibitPermissionAsync(user, permission);
        }

        //Example for primitive method parameters.

        public async Task<ListResultDto<UserListDto>> GetUsers()
        {
            var users = await m_userRepository.GetAllListAsync();

            return new ListResultDto<UserListDto>(
                ObjectMapper.Map<List<UserListDto>>(users)
                );
        }

        protected override User MapToEntity(CreateUserDto createInput)
        {
            var user = ObjectMapper.Map<User>(createInput);
            user.SetNormalizedNames();
            return user;
        }

        protected override void MapToEntity(UserDto input, User user)
        {
            ObjectMapper.Map(input, user);
            user.SetNormalizedNames();
        }

        protected override UserDto MapToEntityDto(User user)
        {
            var roles = m_roleManager.Roles.Where(r => user.Roles.Any(ur => ur.RoleId == r.Id)).Select(r => r.NormalizedName);
            var userDto = base.MapToEntityDto(user);
            userDto.RoleNames = roles.ToArray();
            return userDto;
        }

        protected override IQueryable<User> CreateFilteredQuery(PagedUserResultRequestDto input)
        {
            return Repository.GetAllIncluding(x => x.Roles)
                .WhereIf(!input.Keyword.IsNullOrWhiteSpace(), x => x.UserName.Contains(input.Keyword) || x.Name.Contains(input.Keyword) || x.EmailAddress.Contains(input.Keyword))
                .WhereIf(input.IsActive.HasValue, x => x.IsActive == input.IsActive);
        }

        protected override async Task<User> GetEntityByIdAsync(long id)
        {
            var user = await Repository.GetAllIncluding(x => x.Roles).FirstOrDefaultAsync(x => x.Id == id);

            if (user == null)
            {
                throw new EntityNotFoundException(typeof(User), id);
            }

            return user;
        }

        public IEnumerable<UserBriefDto> GetAllUserBrief()
        {
            //var cacheStore= m_cacheManager.GetCache("CacheName").Get("KeyName",
            //     () => Repository.GetAll().ToList());
            var userList = m_cacheManager.GetCache("ControllerCache").Get("AllUsers",
                        () => Repository.GetAll()) as ListResultDto<UserListDto>;

            var userInfoes = (from users in Repository.GetAll()
                              where (users.IsActive == true)
                              select new UserBriefDto
                              {
                                  Id = users.Id,
                                  Name = users.Name,
                                  Surname = users.Surname,
                                  EmailAddress = users.EmailAddress,
                                  NormalizedUserName = users.NormalizedUserName
                              }).ToList();
            if (userInfoes == null)
            {
                throw new UserFriendlyException("UserInfoes is empty");
            }

            return userInfoes;
        }

        public SortedDictionary<long, string> GetAllUserName()
        {
            var userInfo = (from userDtos in Repository.GetAll()
                            where (userDtos.IsActive == true)
                            select new UserNameDto
                            {
                                Id = userDtos.Id,
                                Name = userDtos.Name
                            }).ToList();
            if (userInfo == null)
            {
                throw new UserFriendlyException("UserInfoes is empty");
            }
            SortedDictionary<long, string> users = new SortedDictionary<long, string>();
            foreach (UserNameDto user in userInfo)
            {
                users[user.Id] = user.Name;
            }

            return users;
        }

        protected override IQueryable<User> ApplySorting(IQueryable<User> query, PagedUserResultRequestDto input)
        {
            return query.OrderBy(r => r.UserName);
        }

        protected virtual void CheckErrors(IdentityResult identityResult)
        {
            identityResult.CheckErrors(LocalizationManager);
        }

        public async Task<bool> ChangePassword(ChangePasswordDto input)
        {
            if (m_abpSession.UserId == null)
            {
                throw new UserFriendlyException("Please log in before attemping to change password.");
            }
            long userId = m_abpSession.UserId.Value;
            var user = await m_userManager.GetUserByIdAsync(userId);
            var loginAsync = await m_logInManager.LoginAsync(user.UserName, input.CurrentPassword, shouldLockout: false);
            if (loginAsync.Result != AbpLoginResultType.Success)
            {
                throw new UserFriendlyException("Your 'Existing Password' did not match the one on record.  Please try again or contact an administrator for assistance in resetting your password.");
            }
            if (!new Regex(AccountAppService.PasswordRegex).IsMatch(input.NewPassword))
            {
                throw new UserFriendlyException("Passwords must be at least 8 characters, contain a lowercase, uppercase, and number.");
            }
            user.Password = m_passwordHasher.HashPassword(user, input.NewPassword);
            CurrentUnitOfWork.SaveChanges();
            return true;
        }

        public async Task<bool> ResetPassword(ResetPasswordDto input)
        {
            if (m_abpSession.UserId == null)
            {
                throw new UserFriendlyException("Please log in before attemping to reset password.");
            }
            long currentUserId = m_abpSession.UserId.Value;
            var currentUser = await m_userManager.GetUserByIdAsync(currentUserId);
            var loginAsync = await m_logInManager.LoginAsync(currentUser.UserName, input.AdminPassword, shouldLockout: false);
            if (loginAsync.Result != AbpLoginResultType.Success)
            {
                throw new UserFriendlyException("Your 'Admin Password' did not match the one on record.  Please try again.");
            }
            if (currentUser.IsDeleted || !currentUser.IsActive)
            {
                return false;
            }
            var roles = await m_userManager.GetRolesAsync(currentUser);
            if (!roles.Contains(StaticRoleNames.Tenants.Admin))
            {
                throw new UserFriendlyException("Only administrators may reset passwords.");
            }

            var user = await m_userManager.GetUserByIdAsync(input.UserId);
            if (user != null)
            {
                user.Password = m_passwordHasher.HashPassword(user, input.NewPassword);
                CurrentUnitOfWork.SaveChanges();
            }

            return true;
        }
    }
}