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
using Microsoft.AspNetCore.Http;
using Abp.Domain.Uow;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using ResearchService.Host.Web;
using Newtonsoft.Json;

namespace BookService.Host.Domain
{
    /// <summary>
    /// Book应用层服务的接口实现方法
    ///</summary>
    //[AbpAuthorize]
    public class BookAppService : BookAppServiceBase, IBookAppService
    {
        private readonly IRepository<Book, uint> m_entityRepository;

        private readonly BookManager m_entityManager;

        /// <summary>
        /// 构造函数
        ///</summary>
        public BookAppService(
        IRepository<Book, uint> entityRepository
            , IHttpContextAccessor accessor
        , BookManager entityManager
        )
        {
            m_accessor = accessor;
            m_entityRepository = entityRepository;
            m_entityManager = entityManager;
        }

        /// <summary>
        /// 获取Book的分页列表信息
        ///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
		//[AbpAuthorize(BookPermissions.Query)]
        public async Task<PagedResultDto<BookListDto>> GetPaged(GetBooksInput input)
        {
            var query = m_entityRepository.GetAll();
            // TODO:根据传入的参数添加过滤条件

            var count = await query.CountAsync();

            var entityList = await query
                    .OrderBy(input.Sorting).AsNoTracking()
                    .PageBy(input)
                    .ToListAsync();

            // var entityListDtos = ObjectMapper.Map<List<BookListDto>>(entityList);
            var entityListDtos = entityList.MapTo<List<BookListDto>>();

            return new PagedResultDto<BookListDto>(count, entityListDtos);
        }

        /// <summary>
        /// 通过指定id获取BookListDto信息
        /// </summary>
        //[AbpAuthorize(BookPermissions.Query)]
        public async Task<BookListDto> GetById(EntityDto<uint> input)
        {
            var entity = await m_entityRepository.GetAsync(input.Id);

            return entity.MapTo<BookListDto>();
        }

        /// <summary>
        /// 获取编辑 Book
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookPermissions.Create,BookPermissions.Edit)]
        public async Task<GetBookForEditOutput> GetForEdit(NullableIdDto<uint> input)
        {
            var output = new GetBookForEditOutput();
            BookEditDto editDto;

            if (input.Id.HasValue)
            {
                var entity = await m_entityRepository.GetAsync(input.Id.Value);

                editDto = entity.MapTo<BookEditDto>();

                //bookEditDto = ObjectMapper.Map<List<bookEditDto>>(entity);
            }
            else
            {
                editDto = new BookEditDto();
            }

            output.Book = editDto;
            return output;
        }

        /// <summary>
        /// 添加或者修改Book的公共方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookPermissions.Create,BookPermissions.Edit)]
        public async Task CreateOrUpdate(CreateOrUpdateBookInput input)
        {
            if (input.Book.Id.HasValue)
            {
                await UpdateBook(input.Book);
            }
            else
            {
                await CreateBook(input.Book);
            }
        }

        /// <summary>
        /// 新增Book
        /// </summary>
        //[AbpAuthorize(BookPermissions.Create)]
        protected virtual async Task<BookEditDto> CreateBook(BookEditDto input)
        {
            //TODO:新增前的逻辑判断，是否允许新增

            // var entity = ObjectMapper.Map <Book>(input);
            var entity = input.MapTo<Book>();

            entity = await m_entityRepository.InsertAsync(entity);
            return entity.MapTo<BookEditDto>();
        } /// <summary>

        /// 新增Book
        /// </summary>
        //[AbpAuthorize(BookPermissions.Create)]
        public virtual async Task<BookEditDto> Create(BookEditDto input)
        {
            //TODO:新增前的逻辑判断，是否允许新增

            // var entity = ObjectMapper.Map <Book>(input);
            var entity = input.MapTo<Book>();
            entity = await m_entityRepository.InsertAsync(entity);
            return entity.MapTo<BookEditDto>();
        }

        /// <summary>
        /// 编辑Book
        /// </summary>
        //[AbpAuthorize(BookPermissions.Edit)]
        protected virtual async Task UpdateBook(BookEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新

            var entity = await m_entityRepository.GetAsync(input.Id.Value);
            input.MapTo(entity);

            // ObjectMapper.Map(input, entity);
            await m_entityRepository.UpdateAsync(entity);
        }

        public virtual async Task Update(BookEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新

            var entity = await m_entityRepository.GetAsync(input.Id.Value);
            AutoMapper.Mapper.Map(input, entity);
            await m_entityRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// 借阅Book
        /// </summary>
        //[AbpAuthorize(BookPermissions.Edit)]
        [UnitOfWork]
        public virtual async Task BorrowBooks(BookNameEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新
            var entity = m_entityRepository.Get(input.Id.Value);
            if (CanBorrow(input))
            {
                entity.BorrowBooks();
                //entity.MemberId = GetCureentUserId();
                await m_entityRepository.UpdateAsync(entity);
            }
            else
            {
                throw new UserFriendlyException("当前图书不能被借阅");
            }
        }

        private bool CanBorrow(BookNameEditDto input)
        {
            return m_entityRepository.Get(input.Id.Value).State == BookServiceHostConsts.IsCanBorrowBook;
        }

        /// <summary>
        /// 图书归还
        /// </summary>
        /// <param name="bookId"></param>
        /// <returns></returns>
        public virtual async Task ReturnBooks(uint bookId)
        {
            //TODO:更新前的逻辑判断，是否允许更新
            m_entityManager.ReturnBooks(bookId);
        }

        /// <summary>
        /// 取消挂失
        /// </summary>
        /// <param name="bookId"></param>
        /// <returns></returns>
        public virtual async Task CancelReportLoss(uint bookId)
        {
            var entity = m_entityRepository.Get(bookId);
            entity.RemoveOfReportLoss();
            await m_entityRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// 图书挂失
        /// </summary>
        /// <param name="bookId"></param>
        /// <returns></returns>
        public virtual async Task ReportLoss(uint bookId)
        {
            var entity = m_entityRepository.Get(bookId);
            entity.ReportLoss();
            await m_entityRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// 删除Book信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookPermissions.Delete)]
        public async Task Delete(EntityDto<uint> input)
        {
            //TODO:删除前的逻辑判断，是否允许删除
            await m_entityRepository.DeleteAsync(input.Id);
        }

        [HttpGet("userId")]
        [Authorize]
        public string GetCurrentUserId()
        {
            string auth = m_accessor.HttpContext.Request.Headers["Authorization"];
            var token = JwtDecodeHelper.JWTDecoder(auth);
            var userToekn = JsonConvert.DeserializeObject<dynamic>(token);
            return userToekn.sub;
        }

        /// <summary>
        /// 批量删除Book的方法
        /// </summary>
        //[AbpAuthorize(BookPermissions.BatchDelete)]
        public async Task BatchDelete(List<uint> input)
        {
            // TODO:批量删除前的逻辑判断，是否允许删除
            await m_entityRepository.DeleteAsync(s => input.Contains(s.Id));
        }

        /// <summary>
        /// 导出Book为excel表,等待开发。
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