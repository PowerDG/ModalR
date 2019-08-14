using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Research.Roles.Dto;
using Research.Users.Dto;

namespace  Research.Users
{
    public interface IUserAppService : IAsyncCrudAppService<UserDto, long, PagedUserResultRequestDto, CreateUserDto, UserDto>
    {
        Task<ListResultDto<RoleDto>> GetRoles();

        Task ChangeLanguage(ChangeUserLanguageDto input);

        #region 新模板功能

        Task ProhibitPermission(ProhibitPermissionInput input);

        Task RemoveFromRole(long userId, string roleName);

        Task<ListResultDto<UserListDto>> GetUsers();

        Task CreateUserWithoutRole(CreateUserInput input);
        #endregion
    }
}
