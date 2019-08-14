using Abp.Application.Services.Dto;
using Abp.AutoMapper;
using Abp.Domain.Repositories;
using Abp.Linq.Extensions;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PartyService.Host.Models;
using PartyService.Host.Models.Dtos;
using PartyService.Host.Models.PageDto;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;

namespace PartyService.Host.Services
{
    /// <summary>
    /// Party应用层服务的接口实现方法
    ///</summary>
    //[AbpAuthorize]
    public class PartyTestAppService : IApplicationService
    {
        private readonly IRepository<Party, long> _entityRepository;

        //  private readonly IFundManager _entityManager;

        /// <summary>
        /// 构造函数
        ///</summary>
        public PartyTestAppService(
        IRepository<Party, long> entityRepository

        )
        {
            _entityRepository = entityRepository;
        }

        /// <summary>
        /// 获取FundModel的分页列表信息
        ///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
        ////[AbpAuthorize(FundModelPermissions.Query)]
        [HttpGet("{id:int}")]
        public async Task<PagedResultDto<PartyEditDto>> GetPaged(FundPagedInput input)
        {
            var query = _entityRepository.GetAll();
            // TODO:根据传入的参数添加过滤条件

            var count = await query.CountAsync();

            var entityList = await query
                .OrderBy(input.Sorting).AsNoTracking()
                .PageBy(input)
                .ToListAsync();

            // var entityListDtos = ObjectMapper.Map<List<PartyListDto>>(entityList);
            var entityListDtos = entityList.MapTo<List<PartyEditDto>>();

            return new PagedResultDto<PartyEditDto>(count, entityListDtos);
        }

        /// <summary>
        /// 通过指定id获取PartyListDto信息
        /// </summary>
        //[AbpAuthorize(PartyPermissions.Query)]
        public async Task<PartyEditDto> GetById(EntityDto<long> input)
        {
            var entity = await _entityRepository.GetAsync(input.Id);

            return entity.MapTo<PartyEditDto>();
        }

        /// <summary>
        /// 添加或者修改Party的公共方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
       // [AbpAuthorize(PartyPermissions.Create, PartyPermissions.Edit)]
        public async Task CreateOrUpdate(PartyCreateDto input)
        {
            if (input.Id.HasValue)
            {
                var edit = input.MapTo<PartyEditDto>();
                await Update(edit);
            }
            else
            {
                await Create(input);
            }
        }

        /// <summary>
        /// 新增Party
        /// </summary>
        //[AbpAuthorize(PartyPermissions.Create)]
        protected virtual async Task<PartyCreateDto> Create(PartyCreateDto input)
        {
            //TODO:新增前的逻辑判断，是否允许新增

            // var entity = ObjectMapper.Map <Party>(input);
            var entity = input.MapTo<Party>();

            entity = await _entityRepository.InsertAsync(entity);
            return entity.MapTo<PartyCreateDto>();
        }

        /// <summary>
        /// 编辑Party
        /// </summary>
       // [AbpAuthorize(PartyPermissions.Edit)]
        protected virtual async Task Update(PartyEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新

            var entity = await _entityRepository.GetAsync(input.Id);
            input.MapTo(entity);

            // ObjectMapper.Map(input, entity);
            await _entityRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// 删除FundModel信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(FundModelPermissions.Delete)]
        [HttpDelete("{id:int}")]
        public async Task Delete(EntityDto<int> input)
        {
            //TODO:删除前的逻辑判断，是否允许删除
            await _entityRepository.DeleteAsync(input.Id);
        }
    }
}