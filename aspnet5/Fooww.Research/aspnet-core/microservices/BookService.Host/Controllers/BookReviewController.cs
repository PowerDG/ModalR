using Abp.Application.Services.Dto;
using Abp.AspNetCore.Mvc.Controllers;
using Abp.AutoMapper;
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
    [Route("api/[Controller]/[Action]")]
    //[ApiController]
    public class BookReviewController : AbpController
    {
        private readonly IRepository<BookReview, uint> m_entityRepository;
        protected IHttpContextAccessor m_accessor;
        private readonly BookReviewManager m_entityManager;

        public BookReviewController(
             IRepository<BookReview, uint> entityRepository
            , IHttpContextAccessor accessor
            , BookReviewManager entityManager
        )
        {
            m_accessor = accessor;
            m_entityRepository = entityRepository;
            m_entityManager = entityManager;
        }

        /// <summary>
        /// 获取BookReview的分页列表信息
        ///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookReviewPermissions.Query)]
        [HttpGet]
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
        /// 根据BookeID获取阅读人的列表信息
        ///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
        [HttpGet]
        public async Task<JsonResult> GetUserBriefOfReview(GetBookReviewsInput input)
        {
            return Json("");
        }

        /// <summary>
        /// 根据BookeID获取BookReview的分页列表信息
        ///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
        [HttpGet]
        public async Task<PagedResultDto<BookReviewListDto>> GetReviewPaged(GetBookReviewsInput input)
        {
            var response = HttpHelper.Get("Fooww.Research.Web.Host", "api/services/app/User/GetAllUserName");
            var ajaxResponse = JsonConvert.DeserializeObject<AjaxResponse>(response.Result);
            UserNameHelper.UserSelectDtos =
                JsonConvert.DeserializeObject<Dictionary<long, string>>(ajaxResponse.Result.ToString());

            var query = m_entityRepository.GetAll()

                .Where(x => x.BookId == input.BookId); ;
            // TODO:根据传入的参数添加过滤条件
            var count = await query.CountAsync();

            var entityList = await query
                    .OrderByDescending(x => x.Id).AsNoTracking()
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
        [HttpGet]
        public async Task<BookReviewListDto> GetById(EntityDto<uint> input)
        {
            var entity = await m_entityRepository.GetAsync(input.Id);

            return entity.MapTo<BookReviewListDto>();
        }

        //[AbpAuthorize(BookReviewPermissions.Create)]

        [UnitOfWork]
        [HttpPut]
        [AuthAttributeFilter(permissionName = PermissionNames.Book_Borrow)]
        public virtual async Task<BookReviewEditDto> ReturnBookWithReview([FromBody]BookReviewEditDto input)
        {
            //TODO:新增前的逻辑判断，是否允许新增
            var entity = input.MapTo<BookReview>();

            entity.CreatorUserId = GetCurrentUserId();
            entity.LastModifierUserId = GetCurrentUserId();
            entity = await m_entityRepository.InsertAsync(entity);
            await m_entityManager.ReturnBookWithBookReview(entity);

            CurrentUnitOfWork.SaveChanges();
            return entity.MapTo<BookReviewEditDto>();
        }

        /// <summary>
        /// 新增BookReview
        /// </summary>
        //[AbpAuthorize(BookReviewPermissions.Create)]
        [UnitOfWork]
        [HttpPost]
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
        [HttpPut]
        public virtual async Task Update(BookReviewEditDto input)
        {
            //TODO:更新前的逻辑判断，是否允许更新
            var entity = await m_entityRepository.GetAsync(input.Id.Value);
            Mapper.Map(input, entity);
            await m_entityRepository.UpdateAsync(entity);
            await m_entityManager.UpdateLastBookReview(entity);
            CurrentUnitOfWork.SaveChanges();
        }

        /// <summary>
        /// 删除BookReview信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        //[AbpAuthorize(BookReviewPermissions.Delete)]
        [HttpDelete]
        public async Task Delete(EntityDto<uint> input)
        {
            //TODO:删除前的逻辑判断，是否允许删除
            await m_entityRepository.DeleteAsync(input.Id);
        }

        #region Support field

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

        #endregion Support field
    }
}