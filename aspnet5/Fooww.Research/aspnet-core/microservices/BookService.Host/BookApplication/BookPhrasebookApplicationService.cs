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
using Abp.AutoMapper;
using Abp.Extensions;
using Abp.Authorization;
using Abp.Domain.Repositories;
using Abp.Application.Services.Dto;
using Abp.Linq.Extensions;

using BookService.Host.Domain;
using BookService.Host.Domain.Dtos;
using BookService.Host.Domain.DomainService;
using BookService.Host.Domain.Authorization;

namespace BookService.Host.Domain
{
    /// <summary>
    /// BookPhrasebook应用层服务的接口实现方法
    ///</summary>
    //[AbpAuthorize]
    public class BookPhrasebookAppService : BookAppServiceBase, IBookPhrasebookAppService
    {
        private readonly IRepository<BookPhrasebook, uint> _entityRepository;

        private readonly IBookPhrasebookManager _entityManager;

        /// <summary>
        /// 构造函数
        ///</summary>
        public BookPhrasebookAppService(
        IRepository<BookPhrasebook, uint> entityRepository
        , IBookPhrasebookManager entityManager
        )
        {
            _entityRepository = entityRepository;
            _entityManager = entityManager;
        }

        /// <summary>
        /// 获取BookPhrasebook的分页列表信息
        ///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
		//[AbpAuthorize(BookPhrasebookPermissions.Query)]
        public async Task<PagedResultDto<BookPhrasebookListDto>> GetPaged(GetBookPhrasebooksInput input)
        {
            var query = _entityRepository.GetAll();
            // TODO:根据传入的参数添加过滤条件

            var count = await query.CountAsync();

            var entityList = await query
                    .OrderBy(input.Sorting).AsNoTracking()
                    .PageBy(input)
                    .ToListAsync();

            // var entityListDtos = ObjectMapper.Map<List<BookPhrasebookListDto>>(entityList);
            var entityListDtos = entityList.MapTo<List<BookPhrasebookListDto>>();

            return new PagedResultDto<BookPhrasebookListDto>(count, entityListDtos);
        }

        /// <summary>
        /// 通过指定id获取BookPhrasebookListDto信息
        /// </summary>
        //[AbpAuthorize(BookPhrasebookPermissions.Query)]
        public async Task<BookPhrasebookListDto> GetById(EntityDto<uint> input)
        {
            var entity = await _entityRepository.GetAsync(input.Id);

            return entity.MapTo<BookPhrasebookListDto>();
        }

        /// <summary>
        /// 获取编辑 BookPhrasebook
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookPhrasebookPermissions.Create,BookPhrasebookPermissions.Edit)]
        public async Task<GetBookPhrasebookForEditOutput> GetForEdit(NullableIdDto<uint> input)
        {
            var output = new GetBookPhrasebookForEditOutput();
            BookPhrasebookEditDto editDto;

            if (input.Id.HasValue)
            {
                var entity = await _entityRepository.GetAsync(input.Id.Value);

                editDto = entity.MapTo<BookPhrasebookEditDto>();

                //bookPhrasebookEditDto = ObjectMapper.Map<List<bookPhrasebookEditDto>>(entity);
            }
            else
            {
                editDto = new BookPhrasebookEditDto();
            }

            output.BookPhrasebook = editDto;
            return output;
        }

        /// <summary>
        /// 添加或者修改BookPhrasebook的公共方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookPhrasebookPermissions.Create,BookPhrasebookPermissions.Edit)]
        public async Task CreateOrUpdate(CreateOrUpdateBookPhrasebookInput input)
        {
            if (input.BookPhrasebook.Id.HasValue)
            {
                await Update(input.BookPhrasebook);
            }
            else
            {
                await Create(input.BookPhrasebook);
            }
        }

        /// <summary>
        /// 新增BookPhrasebook
        /// </summary>
        //[AbpAuthorize(BookPhrasebookPermissions.Create)]
        protected virtual async Task<BookPhrasebookEditDto> Create(BookPhrasebookEditDto input)
        {
            //TODO:新增前的逻辑判断，是否允许新增

            // var entity = ObjectMapper.Map <BookPhrasebook>(input);
            var entity = input.MapTo<BookPhrasebook>();

            entity = await _entityRepository.InsertAsync(entity);
            return entity.MapTo<BookPhrasebookEditDto>();
        }

        /// <summary>
        /// 编辑BookPhrasebook
        /// </summary>
        //[AbpAuthorize(BookPhrasebookPermissions.Edit)]
        protected virtual async Task Update(BookPhrasebookEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新

            var entity = await _entityRepository.GetAsync(input.Id.Value);
            input.MapTo(entity);

            // ObjectMapper.Map(input, entity);
            await _entityRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// 删除BookPhrasebook信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookPhrasebookPermissions.Delete)]
        public async Task Delete(EntityDto<uint> input)
        {
            //TODO:删除前的逻辑判断，是否允许删除
            await _entityRepository.DeleteAsync(input.Id);
        }

        /// <summary>
        /// 批量删除BookPhrasebook的方法
        /// </summary>
        //[AbpAuthorize(BookPhrasebookPermissions.BatchDelete)]
        public async Task BatchDelete(List<uint> input)
        {
            // TODO:批量删除前的逻辑判断，是否允许删除
            await _entityRepository.DeleteAsync(s => input.Contains(s.Id));
        }

        /// <summary>
        /// 导出BookPhrasebook为excel表,等待开发。
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