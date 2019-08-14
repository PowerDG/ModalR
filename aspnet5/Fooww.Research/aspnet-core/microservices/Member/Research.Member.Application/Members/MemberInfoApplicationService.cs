using System;
using System.Data;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;
using System.Threading.Tasks;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

using Abp.UI;

//using Abp.AutoMapper;
using Abp.Extensions;
using Abp.Authorization;
using Abp.Domain.Repositories;
using Abp.Application.Services.Dto;
using Abp.Linq.Extensions;

using Research.Member.Members;
using Research.Member.Members.Dtos;
using Research.Member.Members.DomainService;
using Research.Member.Web;

using AutoMapper;
using Abp.AutoMapper;

namespace Research.Member.Members
{
    /// <summary>
    /// MemberInfo应用层服务的接口实现方法
    ///</summary>
    [AbpAuthorize]
    public class MemberInfoAppService : MemberAppServiceBase, IMemberInfoAppService
    {
        private readonly IRepository<MemberInfo, long> _entityRepository;

        private readonly IMemberInfoManager _entityManager;

        /// <summary>
        /// 构造函数
        ///</summary>
        public MemberInfoAppService(
        IRepository<MemberInfo, long> entityRepository
        , IMemberInfoManager entityManager
        )
        {
            _entityRepository = entityRepository;
            _entityManager = entityManager;
        }

        /// <summary>
        /// 获取MemberInfo的分页列表信息
        ///</summary>
        /// <param name="input"></param>
        /// <returns></returns>

        public async Task<PagedResultDto<MemberInfoListDto>> GetPaged(GetMemberInfosInput input)
        {
            var query = _entityRepository.GetAll();
            // TODO:根据传入的参数添加过滤条件

            var count = await query.CountAsync();

            var entityList = await query
                    .OrderBy(input.Sorting).AsNoTracking()
                    .PageBy(input)
                    .ToListAsync();

            // var entityListDtos = ObjectMapper.Map<List<MemberInfoListDto>>(entityList);
            var entityListDtos = entityList.MapTo<List<MemberInfoListDto>>();

            return new PagedResultDto<MemberInfoListDto>(count, entityListDtos);
        }

        /// <summary>
        /// 通过指定id获取MemberInfoListDto信息
        /// </summary>

        public async Task<MemberInfoListDto> GetById(EntityDto<long> input)
        {
            var entity = await _entityRepository.GetAsync(input.Id);

            return entity.MapTo<MemberInfoListDto>();
        }

        /// <summary>
        /// 获取编辑 MemberInfo
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>

        public async Task<GetMemberInfoForEditOutput> GetForEdit(NullableIdDto<long> input)
        {
            var output = new GetMemberInfoForEditOutput();
            MemberInfoEditDto editDto;

            if (input.Id.HasValue)
            {
                var entity = await _entityRepository.GetAsync(input.Id.Value);

                editDto = entity.MapTo<MemberInfoEditDto>();

                //memberInfoEditDto = ObjectMapper.Map<List<memberInfoEditDto>>(entity);
            }
            else
            {
                editDto = new MemberInfoEditDto();
            }

            output.MemberInfo = editDto;
            return output;
        }

        /// <summary>
        /// 添加或者修改MemberInfo的公共方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>

        /// <summary>
        /// 新增MemberInfo
        /// </summary>

        protected virtual async Task<MemberInfoEditDto> Create(MemberInfoCreateDto input)
        {
            //TODO:新增前的逻辑判断，是否允许新增
            var entity = input.MapTo<MemberInfo>();

            //var userAccount = new CreateUserWithSingleRoleInput();
            //Mapper.Map(input, userAccount);
            var userUserName = new CreateUserWithSingleRoleInput()
            {
                UserName = input.UserName,
                Surname = input.Surname,
                Password = input.Password,
                Name = input.Name,
                RoleNames = string.IsNullOrWhiteSpace(input.Title) ? "研究员角色名" : input.Title,
                IsActive = true
            };

            var response = HttpHelper.ResultPost("Fooww.Research.Web.Host", userUserName);
            if (!response.Success)
            {
                throw new UserFriendlyException("创建错误，请重试");
            }

            entity = await _entityRepository.InsertAsync(entity);
            return entity.MapTo<MemberInfoEditDto>();
        }

        /// <summary>
        /// 编辑MemberInfo
        /// </summary>

        protected virtual async Task Update(MemberInfoEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新

            var entity = await _entityRepository.GetAsync(input.Id.Value);
            input.MapTo(entity);

            // ObjectMapper.Map(input, entity);
            await _entityRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// 编辑MemberInfo
        /// </summary>

        protected virtual async Task UpdateMemberAccount(MemberInfoEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新
            var entity = await _entityRepository.GetAsync(input.Id.Value);
            input.MapTo(entity);

            // ObjectMapper.Map(input, entity);
            await _entityRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// 删除MemberInfo信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>

        public async Task Delete(EntityDto<long> input)
        {
            //TODO:删除前的逻辑判断，是否允许删除
            await _entityRepository.DeleteAsync(input.Id);
        }

        /// <summary>
        /// 批量删除MemberInfo的方法
        /// </summary>

        public async Task BatchDelete(List<long> input)
        {
            // TODO:批量删除前的逻辑判断，是否允许删除
            await _entityRepository.DeleteAsync(s => input.Contains(s.Id));
        }

        /// <summary>
        /// 导出MemberInfo为excel表,等待开发。
        /// </summary>
        /// <returns></returns>
        //public async Task<FileDto> GetToExcel()
        //{
        //	var users = await UserManager.Users.ToListAsync();
        //	var userListDtos = ObjectMapper.Map<List<UserListDto>>(users);
        //	await FillRoleNames(userListDtos);
        //	return _userListExcelExporter.ExportToFile(userListDtos);
        //}
    }
}