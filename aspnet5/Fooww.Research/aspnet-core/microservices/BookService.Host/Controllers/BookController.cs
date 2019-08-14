using Abp.Application.Services.Dto;
using Abp.AspNetCore.Mvc.Controllers;
using Abp.Domain.Repositories;
using Abp.Domain.Uow;
using Abp.Linq.Extensions;
using Abp.UI;
using Abp.Web.Models;
using AutoMapper;
using BookService.Host.Domain;
using BookService.Host.Domain.DomainService;
using BookService.Host.Domain.Dtos;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using ResearchService.Host.Web;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;

namespace BookService.Host.Controllers
{
    //[Route("api/[Controller]")]
    [Route("api/[Controller]/[Action]")]
    //[ApiController]
    public class BookController : AbpController
    {
        private readonly IUnitOfWorkManager m_unitOfWorkManager;
        protected IHttpContextAccessor m_accessor;
        private readonly IRepository<Book, uint> m_entityRepository;
        private readonly BookManager m_entityManager;

        /// <summary>
        /// 构造函数
        ///</summary>
        public BookController(
            IUnitOfWorkManager unitOfWorkManager
            , IRepository<Book, uint> entityRepository
            , IHttpContextAccessor accessor
            , BookManager entityManager
        )
        {
            m_unitOfWorkManager = unitOfWorkManager;
            m_accessor = accessor;
            m_entityRepository = entityRepository;
            m_entityManager = entityManager;
        }

        /// <summary>
        /// 获取Book的分页列表信息
        ///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
        [HttpGet]
        //[AbpAuthorize(BookPermissions.Query)]
        //[AuthAttributeFilter(permissionName = PermissionNames.Book_GetAll)]
        public async Task<PagedResultDto<BookListDto>> GetPaged(GetBooksInput input)
        {
            var response = HttpHelper.Get("Fooww.Research.Web.Host", "api/services/app/User/GetAllUserName");
            var ajaxResponse = JsonConvert.DeserializeObject<AjaxResponse>(response.Result);
            UserNameHelper.UserSelectDtos =
                JsonConvert.DeserializeObject<Dictionary<long, string>>(ajaxResponse.Result.ToString());

            //var query = m_entityRepository.GetAll()

            //    .Where(x => x.BookId == input.BookId); ;

            var query = ApplyTypeSorting(m_entityRepository.GetAll(), input);
            // TODO:根据传入的参数添加过滤条件
            var count = await query.CountAsync()
              //.WhereIf(string.IsNullOrWhiteSpace(input.FilterText), t => t.CreationTime == input.SkipCount)
              ;

            var entityList = await query
                    //.OrderBy(input.Sorting)
                    .AsNoTracking()
                    .PageBy(input)
                    .Distinct()
                    .ToListAsync();
            var entityListDtos = Mapper.Map<List<BookListDto>>(entityList);
            return new PagedResultDto<BookListDto>(count, entityListDtos);
        }

        /// <summary>
        /// 通过指定id获取BookListDto信息
        /// </summary>
        //[AbpAuthorize(BookPermissions.Query)]

        [HttpGet]
        [AuthAttributeFilter(permissionName = PermissionNames.Book_Get)]
        public async Task<BookListDto> GetById(EntityDto<uint> input)
        {
            var entity = await m_entityRepository
            .FirstOrDefaultAsync(x => x.Id == input.Id);
            return Mapper.Map<BookListDto>(entity);
        }

        /// <summary>
        /// 删除Book信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookPermissions.Delete)]

        [HttpDelete]
        [UnitOfWork(IsDisabled = true)]
        [AuthAttributeFilter(permissionName = PermissionNames.Book_Delete)]
        public async Task Delete(EntityDto<uint> input)
        {
            //TODO:删除前的逻辑判断，是否允许删除
            await m_entityRepository.DeleteAsync(x => x.Id == input.Id);
        }

        /// <summary>
        /// 新增Book
        /// </summary>
        //[AbpAuthorize(BookPermissions.Create)]

        [HttpPost]
        [UnitOfWork]
        [AuthAttributeFilter(permissionName = PermissionNames.Book_Create)]
        public virtual async Task<Book> Create([FromBody]BookEditDto input)
        {
            //TODO:新增前的逻辑判断，是否允许新增

            var entity = Mapper.Map<Book>(input);
            entity.Id = null;
            if (entity != null)
            {
                entity.MemberId = ResearchServiceConsts.DefaultBorrowBookMemberId;
                entity.CreatorUserId = GetCurrentUserId();
                entity.LastModifierUserId = GetCurrentUserId();
                var entityResult = await m_entityRepository.InsertAsync(entity);

                CurrentUnitOfWork.SaveChanges();
                return entityResult;
            }
            throw new UserFriendlyException("Sorry~ Create Failure");
        }

        [HttpPut]
        [AuthAttributeFilter(permissionName = PermissionNames.Book_Update)]
        public virtual async Task<Book> Update([FromBody]BookEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新
            //var entity = await m_entityRepository.GetAsync(input.Id.Value);

            var entity = await m_entityRepository
            .FirstOrDefaultAsync(x => x.Id == input.Id);
            Mapper.Map(input, entity);
            entity.LastModifierUserId = GetCurrentUserId();
            var entityResult = await m_entityRepository.UpdateAsync(entity);

            CurrentUnitOfWork.SaveChanges();
            return entityResult;
        }

        /// <summary>
        /// 借书
        /// </summary>
        //[AbpAuthorize(BookPermissions.Edit)]
        [UnitOfWork]
        [HttpPut]
        [AuthAttributeFilter(permissionName = PermissionNames.Book_Borrow)]
        public virtual async Task BorrowBook([FromBody]BookBriefEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新
            var entity = await m_entityRepository
            .FirstOrDefaultAsync(x => x.Id == input.Id);
            if (CanBorrowBookByCurrentUser(input))
            {
                entity.BorrowBooks();
                entity.MemberId = GetCurrentUserId();
                entity.LastModifierUserId = GetCurrentUserId();
                await m_entityRepository.UpdateAsync(entity);

                CurrentUnitOfWork.SaveChanges();
            }
            else
            {
                throw new UserFriendlyException("您不能被借阅该图书");
            }
        }

        /// <summary>
        /// 图书归还【暂不用】
        /// </summary>
        /// <param name="bookId"></param>
        /// <returns></returns>

        [HttpPut]
        [AuthAttributeFilter(permissionName = PermissionNames.Book_Borrow)]
        public virtual async Task ReturnBook(uint bookId)
        {
            //TODO:更新前的逻辑判断，是否允许更新
            m_entityManager.ReturnBooks(bookId);
        }

        [HttpGet]
        [AuthAttributeFilter(permissionName = PermissionNames.Book_Borrow)]
        public virtual bool CanBorrow()
        {
            return
                m_entityRepository.GetAll()
                    .Where(x => x.MemberId == GetCurrentUserId())
                    .Where(x => x.State == ResearchServiceConsts.IsBorrowedBook)
                    .Count() == 0
                    ? true
                    : false;
        }

        /// <summary>
        /// 挂失取消【暂不用】
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        [HttpPut]
        [AuthAttributeFilter(permissionName = PermissionNames.Book_Delete)]
        public virtual async Task RemoveOfReportLoss([FromBody]EntityDto<uint> input)
        {
            var entity = await m_entityRepository
            .FirstOrDefaultAsync(x => x.Id == input.Id);
            entity.LastModifierUserId = GetCurrentUserId();
            entity.RemoveOfReportLoss();
            await m_entityRepository.UpdateAsync(entity);
        }

        /// <summary>
        /// 图书挂失
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        [HttpPut]
        [AuthAttributeFilter(permissionName = PermissionNames.Book_Delete)]
        public virtual async Task ReportLoss([FromBody]BookReportLossDto input)
        {
            var entity = await m_entityRepository
            .FirstOrDefaultAsync(x => x.Id == input.Id);
            entity.ReportLoss();
            entity.LastModifierUserId = GetCurrentUserId();
            entity.LastBookReview = input.Reason;
            await m_entityRepository.UpdateAsync(entity);
        }

        #region Support field

        /// <summary>
        /// 获取书籍来源-集合
        /// </summary>
        /// <returns></returns>

        [HttpGet]
        public async Task<List<string>> GetResourceType()
        {
            var query = m_entityRepository.GetAll();
            var resourceQuery = (from entities in query
                                 group entities by entities.Resource into g
                                 orderby g.Count() descending
                                 select g.Key);
            var resourceList = resourceQuery.ToList();
            return resourceList;
        }

        [HttpGet]
        public virtual List<string> GetModuleNamePermissionsList()
        {
            var userId = GetCurrentUserId();
            var moduleName = "BookInfo";
            return PermissionFilter.GetModuleNamePermissionsList(userId, moduleName);
        }

        [HttpGet]
        public virtual Dictionary<string, bool> GetModuleNamePermissionsDict()
        {
            var userId = GetCurrentUserId();
            var moduleName = "BookInfo";
            return PermissionFilter.GetModuleNamePermissionsDict(userId, moduleName);
        }

        [HttpGet]
        public long GetCurrentUserId()
        {
            try
            {
                string auth = m_accessor.HttpContext.Request.Headers["Authorization"];
                var token = JwtDecodeHelper.JWTDecoder(auth);
                var userToekn = JsonConvert.DeserializeObject<dynamic>(token);
                string CurrentUserId = userToekn.sub;
                long.TryParse(CurrentUserId, out long userId);
                return userId;
            }
            catch (Exception)
            {
                throw new UserFriendlyException(403, "Could not Verify your identity");
            }
        }

        protected virtual bool BookCanBorrow(BookBriefEditDto input)
        {
            return m_entityRepository.FirstOrDefault(x => x.Id == input.Id)
                .State == ResearchServiceConsts.IsCanBorrowBook ? true :
                throw new UserFriendlyException("抱歉 当前书籍状态不可借");
        }

        protected virtual bool UserCanBorrow(BookBriefEditDto input)
        {
            return
                m_entityRepository.GetAll()
                .Where(x => x.MemberId == GetCurrentUserId())
                .Where(x => x.State == ResearchServiceConsts.IsBorrowedBook)
                .Count() == 0 ? true :
                throw new UserFriendlyException("您尚有图书需归还 无法借阅其他图书");
        }

        protected virtual bool CanBorrowBookByCurrentUser(BookBriefEditDto input)
        {
            return BookCanBorrow(input) && UserCanBorrow(input);
        }

        protected IQueryable<Book> ApplyTypeSorting(IQueryable<Book> query, GetBooksInput input)
        {
            if (string.IsNullOrWhiteSpace(input.QueryType) || input.QueryType == "all")
            {
                query = ApplySearch(query, input);
            }
            else
            {
                if ("myself".Equals(input.QueryType.ToLowerInvariant()))
                {
                    //当有读书记录or标识可将LastModifierUserId替换
                    query = query.Where(x => x.LastModifierUserId == GetCurrentUserId());
                }
                if ("canborrow".Equals(input.QueryType.ToLowerInvariant()))
                {
                    query = query.Where(x => x.State == ResearchServiceConsts.IsCanBorrowBook);
                }
                if ("host".Equals(input.QueryType.ToLowerInvariant()))
                {
                    query = query.OrderByDescending(t => t.LastModificationTime);
                }
            }
            query = (from entities in query
                     orderby (entities.State == 1 || entities.State == 0) ? 0 : 1
                     select entities).ThenByDescending(t => t.Id);
            return query;
        }

        protected IQueryable<Book> ApplySearch(IQueryable<Book> query, GetBooksInput input)
        {
            if (!string.IsNullOrEmpty(input.FilterText))
            {
                //query = query.Where(input.FilterText);
                var searchByAuthor = query.Where(s => s.Author.Contains(input.FilterText));
                var searchByName = query.Where(s => s.Name.Contains(input.FilterText));
                query = searchByAuthor.Union(searchByName);
            }
            return query;
        }

        #endregion Support field
    }
}