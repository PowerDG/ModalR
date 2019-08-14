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

using BookService.Host.Domain.Dtos;
using BookService.Host.Domain.DomainService;
using BookService.Host.Domain.Authorization;
using Abp.Domain.Uow;

namespace BookService.Host.Domain
{
    /// <summary>
    /// BookReview应用层服务的接口实现方法
    ///</summary>
    //[AbpAuthorize]
    public class BookReviewAppService : BookAppServiceBase, IBookReviewAppService
    {
        private readonly IRepository<BookReview, uint> m_entityRepository;

        private readonly BookReviewManager m_entityManager;

        /// <summary>
        /// 构造函数
        ///</summary>
        public BookReviewAppService(
        IRepository<BookReview, uint> entityRepository
        , BookReviewManager entityManager
        )
        {
            m_entityRepository = entityRepository;
            m_entityManager = entityManager;
        }

        /// <summary>
        /// 获取BookReview的分页列表信息
        ///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
		//[AbpAuthorize(BookReviewPermissions.Query)]
        public async Task<PagedResultDto<BookReviewListDto>> GetPaged(GetBookReviewsInput input)
        {
            var query = m_entityRepository.GetAll();
            // TODO:根据传入的参数添加过滤条件

            var count = await query.CountAsync();

            var entityList = await query
                    .OrderBy(input.Sorting).AsNoTracking()
                    .PageBy(input)
                    .ToListAsync();

            // var entityListDtos = ObjectMapper.Map<List<BookReviewListDto>>(entityList);
            var entityListDtos = entityList.MapTo<List<BookReviewListDto>>();

            return new PagedResultDto<BookReviewListDto>(count, entityListDtos);
        }

        /// <summary>
        /// 通过指定id获取BookReviewListDto信息
        /// </summary>
        //[AbpAuthorize(BookReviewPermissions.Query)]
        public async Task<BookReviewListDto> GetById(EntityDto<uint> input)
        {
            var entity = await m_entityRepository.GetAsync(input.Id);

            return entity.MapTo<BookReviewListDto>();
        }

        [UnitOfWork]
        public virtual async Task<BookReviewEditDto> ReturnBookWithReview(BookReviewEditDto input)
        {
            //TODO:新增前的逻辑判断，是否允许新增
            var entity = input.MapTo<BookReview>();
            entity = await m_entityRepository.InsertAsync(entity);

            await m_entityManager.ReturnBooksWithBookReview(entity);
            CurrentUnitOfWork.SaveChanges();
            return entity.MapTo<BookReviewEditDto>();
        }

        /// <summary>
        /// 新增BookReview
        /// </summary>
        //[AbpAuthorize(BookReviewPermissions.Create)]

        [UnitOfWork]
        public virtual async Task<BookReviewEditDto> Create(BookReviewEditDto input)
        {
            //TODO:新增前的逻辑判断，是否允许新增

            var entity = input.MapTo<BookReview>();
            entity = await m_entityRepository.InsertAsync(entity);

            await m_entityManager.UpdateLastBookReview(entity);
            CurrentUnitOfWork.SaveChanges();
            return entity.MapTo<BookReviewEditDto>();
        }

        /// <summary>
        /// 编辑BookReview
        /// </summary>
        //[AbpAuthorize(BookReviewPermissions.Edit)]
        [UnitOfWork]
        public virtual async Task Update(BookReviewEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新
            var entity = await m_entityRepository.GetAsync(input.Id.Value);
            AutoMapper.Mapper.Map(input, entity);
            await m_entityRepository.UpdateAsync(entity);
            await m_entityManager.UpdateLastBookReview(entity);
            CurrentUnitOfWork.SaveChanges();
        }

        /// <summary>
        /// 获取编辑 BookReview
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookReviewPermissions.Create,BookReviewPermissions.Edit)]
        public async Task<GetBookReviewForEditOutput> GetForEdit(NullableIdDto<uint> input)
        {
            var output = new GetBookReviewForEditOutput();
            BookReviewEditDto editDto;

            if (input.Id.HasValue)
            {
                var entity = await m_entityRepository.GetAsync(input.Id.Value);

                editDto = entity.MapTo<BookReviewEditDto>();

                //bookReviewEditDto = ObjectMapper.Map<List<bookReviewEditDto>>(entity);
            }
            else
            {
                editDto = new BookReviewEditDto();
            }

            output.BookReview = editDto;
            return output;
        }

        /// <summary>
        /// 添加或者修改BookReview的公共方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookReviewPermissions.Create,BookReviewPermissions.Edit)]
        public async Task CreateOrUpdate(CreateOrUpdateBookReviewInput input)
        {
            if (input.BookReview.Id.HasValue)
            {
                await UpdateBook(input.BookReview);
            }
            else
            {
                await CreateBook(input.BookReview);
            }
        }

        /// <summary>
        /// 新增BookReview
        /// </summary>
        //[AbpAuthorize(BookReviewPermissions.Create)]
        protected virtual async Task<BookReviewEditDto> CreateBook(BookReviewEditDto input)
        {
            //TODO:新增前的逻辑判断，是否允许新增

            // var entity = ObjectMapper.Map <BookReview>(input);
            var entity = input.MapTo<BookReview>();

            entity = await m_entityRepository.InsertAsync(entity);
            return entity.MapTo<BookReviewEditDto>();
        }

        /// <summary>
        /// 编辑BookReview
        /// </summary>
        //[AbpAuthorize(BookReviewPermissions.Edit)]
        protected virtual async Task UpdateBook(BookReviewEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新

            var entity = await m_entityRepository.GetAsync(input.Id.Value);
            input.MapTo(entity);

            // ObjectMapper.Map(input, entity);
            await m_entityRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// 删除BookReview信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookReviewPermissions.Delete)]
        public async Task Delete(EntityDto<uint> input)
        {
            //TODO:删除前的逻辑判断，是否允许删除
            await m_entityRepository.DeleteAsync(input.Id);
        }

        /// <summary>
        /// 批量删除BookReview的方法
        /// </summary>
        //[AbpAuthorize(BookReviewPermissions.BatchDelete)]
        public async Task BatchDelete(List<uint> input)
        {
            // TODO:批量删除前的逻辑判断，是否允许删除
            await m_entityRepository.DeleteAsync(s => input.Contains(s.Id));
        }

        /// <summary>
        /// 导出BookReview为excel表,等待开发。
        /// </summary>
        /// <returns></returns>
        //public async Task<FileDto> GetToExcel()
        //{
        //	var users = await UserManager.Users.ToListAsync();
        //	var userListDtos = ObjectMapper.Map<List<UserListDto>>(users);
        //	await FillRoleNames(userListDtos);
        //	return m_userListExcelExporter.ExportToFile(userListDtos);
        //}
    }
}