using Abp.Application.Services.Dto;
using Abp.AspNetCore.Mvc.Controllers;
using Abp.AutoMapper;
using Abp.Domain.Repositories;
using Abp.Domain.Uow;
using Abp.Linq.Extensions;
using Abp.UI;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using PartyService.Host.Models;
using PartyService.Host.Models.Dtos;
using PartyService.Host.Models.PageDto;
using ResearchService.Host.Web;
using System;
using System.Collections.Generic;
using System.Collections.Immutable;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;

namespace PartyService.Host.Controllers
{
    [Route("api/[Controller]/[Action]")]
    //[Authorize]
    public class PartyController : AbpController
    {
        private readonly IUnitOfWorkManager m_unitOfWorkManager;
        protected IHttpContextAccessor m_accessor;
        private readonly IRepository<Party, long> m_partyRepository;
        private readonly IRepository<PartyPhoto, long> m_partyPictureRepository;
        private readonly IRepository<PartyComment, long> m_partyCommentRepository;
        private readonly IRepository<FundModel, long> m_fundRepository;

        /// <summary>
        /// 构造函数
        ///</summary>
        public PartyController(IUnitOfWorkManager unitOfWorkManager
            , IHttpContextAccessor accessor
            , IRepository<Party, long> partyRepository
            , IRepository<PartyPhoto, long> partyPictureRepository
            , IRepository<PartyComment, long> partyCommentRepository
            , IRepository<FundModel, long> fundRepository
        )
        {
            m_unitOfWorkManager = unitOfWorkManager;
            m_accessor = accessor;
            m_partyRepository = partyRepository;
            m_partyPictureRepository = partyPictureRepository;
            m_partyCommentRepository = partyCommentRepository;
            m_fundRepository = fundRepository;
        }

        /// <summary>
        /// 获取FundModel的分页列表信息
        ///</summary>
        /// <param name="input"></param>
        /// <returns></returns>

        [HttpGet]
        [AuthAttributeFilter(permissionName = PermissionNames.Party_GetAll)]
        public async Task<PagedResultDto<PartyListDto>> GetPaged(PartyPagedInput input)
        {
            var query = ApplyTypeSorting(m_partyRepository.GetAll(), input);
            var count = query.Count();
            if (count > 0)
            {
                var partyListDtos = query.AsNoTracking().PageBy(input).ToImmutableList().MapTo<List<PartyListDto>>();
                foreach (var partyListDto in partyListDtos)
                {
                    partyListDto.PartyCommentDtos = m_partyCommentRepository.GetAll().Where(p => p.PartyId == partyListDto.Id)
                        .OrderBy("Id desc")
                        .Take(3).ToList().MapTo<List<PartyCommentDto>>();
                    partyListDto.PartyPhotoDtos = m_partyPictureRepository.GetAll().Where(p => p.PartyId == partyListDto.Id)
                        .OrderBy("Id desc")
                        .Take(3).ToList().MapTo<List<PartyPhotoDto>>();
                }
                return new PagedResultDto<PartyListDto>(count, partyListDtos);
            }
            return null;
        }

        /// <summary>
        /// 通过指定id获取PartyListDto信息
        /// </summary>
        [AuthAttributeFilter(permissionName = PermissionNames.Party_Get)]
        [HttpGet]
        public async Task<PartyEditDto> GetById(EntityDto<long> input)
        {
            var entity = await m_partyRepository.GetAsync(input.Id);

            return entity.MapTo<PartyEditDto>();
        }

        /// <summary>
        /// 添加或者修改Party的公共方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        // [AbpAuthorize(PartyPermissions.Create, PartyPermissions.Edit)]
        [HttpPost]
        public async Task CreateOrUpdate([FromBody]PartyCreateDto input)
        {
            input.MemberId = GetCurrentUserId();
            if (input.EndTime < input.StartTime)
            {
                throw new UserFriendlyException(400, "活动结束时间必须大于开始时间！");
            }
            if (input.Id.HasValue)
            {
                var edit = input.MapTo<PartyEditDto>();
                //Mapper.Map(input, edit);

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
        [AuthAttributeFilter(permissionName = PermissionNames.Party_Create)]
        [UnitOfWork]
        protected virtual async Task Create(PartyCreateDto input)
        {
            var entity = input.MapTo<Party>();
            var dateNow = DateTime.Now;
            entity.LastModificationTime = dateNow;
            if (entity.Source == 1)
            {
                var fund = new FundModel()
                {
                    Description = entity.Place,
                    ItemName = entity.Title,
                    MemberId = entity.MemberId,
                    CreationTime = dateNow,
                    OperateMoney = -entity.Cost,
                    InsertTime = dateNow,
                };
                var lastFund = DynamicQueryableExtensions.FirstOrDefault(m_fundRepository.GetAll().OrderBy("id desc "));
                fund.RemainMoney = ((FundModel)lastFund).RemainMoney + fund.OperateMoney;
                fund.LastModificationTime = dateNow;
                m_fundRepository.Insert(fund);
            }
            await m_partyRepository.InsertAsync(entity);
            CurrentUnitOfWork.SaveChanges();
        }

        /// <summary>
        /// 编辑Party
        /// </summary>
        [AuthAttributeFilter(permissionName = PermissionNames.Party_Update)]
        protected virtual async Task Update(PartyEditDto input)
        {
            var entity = await m_partyRepository.FirstOrDefaultAsync(x => x.Id == input.Id);
            input.MapTo(entity);
            if (PermissionFilter.IsGrantedAsync(GetCurrentUserId(), PermissionNames.Party_Update_Oneself))
            {
                if (entity.MemberId != GetCurrentUserId())
                {
                    throw new UserFriendlyException(403, "Your 'permissions' could not match the one on record");
                }
            }
            await m_partyRepository.UpdateAsync(entity);
        }

        [HttpDelete]
        [AuthAttributeFilter(permissionName = PermissionNames.Party_Delete)]
        public async Task Delete(EntityDto<int> input)
        {
            var entity = await m_partyRepository.FirstOrDefaultAsync(x => x.Id == input.Id);
            if (PermissionFilter.IsGrantedAsync(GetCurrentUserId(), PermissionNames.Party_Delete_Oneself))
            {
                if (entity.MemberId != GetCurrentUserId())
                {
                    throw new UserFriendlyException(403, "Your 'permissions' could not match the one on record");
                }
            }
            await m_partyRepository.DeleteAsync(x => x.Id == input.Id);
        }

        [HttpPost]
        [AuthAttributeFilter(permissionName = PermissionNames.Party_Photo)]
        public bool InsertPartyImg([FromBody]PartyPhotoDto partyPhotoCreateDto)
        {
            var partyPhoto = partyPhotoCreateDto.MapTo<PartyPhoto>();
            partyPhoto.LastModificationTime = DateTime.Now;
            m_partyPictureRepository.Insert(partyPhoto);
            return true;
        }

        [HttpPut]
        [AuthAttributeFilter(permissionName = PermissionNames.Party_Rate)]
        public bool UpdateLikeLevel([FromBody]PartyLevelDto partyLevelDto)
        {
            var party = m_partyRepository.FirstOrDefault(p => p.Id == partyLevelDto.Id);
            double currValue = (double)party.LikeLevel;
            int reviewTimes = party.LikeCount;
            party.LikeCount++;
            party.LikeLevel = (decimal)((currValue * reviewTimes + partyLevelDto.Score) / party.LikeCount);
            m_partyRepository.Update(party);
            return true;
        }

        [HttpGet]
        public List<PartyCommentDto> GetComments(int partyId)
        {
            var comments = m_partyCommentRepository.GetAll().Where($"PartyId = {partyId}").OrderBy("id desc").ToList();
            return comments.MapTo<List<PartyCommentDto>>();
        }

        [HttpPost]
        [AuthAttributeFilter(permissionName = PermissionNames.Party_Create)]
        public async Task<bool> CreateComment([FromBody]PartyCommentDto partyCommentDto)
        {
            var comment = partyCommentDto.MapTo<PartyComment>();
            //comment.MemberId = Convert.ToInt64(User.FindFirst("sub").Value);
            comment.MemberId = GetCurrentUserId();
            await m_partyCommentRepository.InsertAsync(comment);
            return true;
        }

        #region Support field

        [HttpGet]
        public virtual List<string> GetModuleNamePermissionsList(string moduleName)
        {
            var userId = GetCurrentUserId();
            return PermissionFilter.GetModuleNamePermissionsList(userId, moduleName);
        }

        [HttpGet]
        public virtual Dictionary<string, bool> GetModuleNamePermissionsDict(string moduleName)
        {
            var userId = GetCurrentUserId();
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

        protected IQueryable<Party> ApplyTypeSorting(IQueryable<Party> query, PartyPagedInput input)
        {
            if (string.IsNullOrWhiteSpace(input.QueryType) || input.QueryType == "all")
            {
                query = ApplySearch(query, input);
                query = query.OrderByDescending(t => t.CreationTime);
            }
            else if ("most".Equals(input.QueryType.ToLowerInvariant()))
            {
                query = ApplyFrequency(query, input);
            }
            else if ("high".Equals(input.QueryType.ToLowerInvariant()))
            {
                query = query.OrderByDescending(t => t.LikeLevel);
            }

            return query;
        }

        protected IQueryable<Party> ApplySearch(IQueryable<Party> query, PartyPagedInput input)
        {
            if (!string.IsNullOrWhiteSpace(input.FilterText))
            {
                var searchByTitle = query.Where(x => x.Title.Contains(input.FilterText));
                var searchByPlace = query.Where(x => x.Place.Contains(input.FilterText));

                query = searchByTitle.Union(searchByPlace).Distinct();
            }
            return query;
        }

        protected IQueryable<Party> ApplyFrequency(IQueryable<Party> query, PartyPagedInput input)
        {
            var partyPlaceListQuery = (from entities in query
                                       group entities by entities.Place into g
                                       orderby g.Count() descending
                                       select g.Key);
            var partyPlaceList = partyPlaceListQuery.ToList();
            var partyPlaceSortedDict = new Dictionary<string, int>();
            foreach (var item in partyPlaceList)
            {
                partyPlaceSortedDict.Add(item, partyPlaceList.IndexOf(item));
            }
            query = query.OrderBy(x => partyPlaceSortedDict[x.Place]);

            return query;
        }

        #endregion Support field
    }
}