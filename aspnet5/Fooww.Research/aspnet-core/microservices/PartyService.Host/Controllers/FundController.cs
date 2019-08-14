using Abp.Application.Services.Dto;
using Abp.AspNetCore.Mvc.Controllers;
using Abp.AutoMapper;
using Abp.Domain.Repositories;
using Abp.Domain.Uow;
using Abp.Linq.Extensions;
using Abp.UI;
using Abp.Web.Models;
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

namespace PartyService.Host.Controllers
{
    [Route("api/[Controller]/[Action]")]
    public class FundController : AbpController
    {
        private readonly IUnitOfWorkManager m_unitOfWorkManager;
        protected IHttpContextAccessor m_accessor;
        private readonly IRepository<FundModel, long> m_fundRepository;

        public FundController(
            IUnitOfWorkManager unitOfWorkManager
            , IHttpContextAccessor accessor
            , IRepository<FundModel, long> fundRepository)
        {
            m_unitOfWorkManager = unitOfWorkManager;
            m_accessor = accessor;
            this.m_fundRepository = fundRepository;
        }

        [HttpPost]
        [AuthAttributeFilter(permissionName = PermissionNames.Fund_Create)]
        public bool CreateFund([FromBody]FundCreateDto request)
        {
            var fund = request.MapTo<FundModel>();
            var lastFund = DynamicQueryableExtensions.FirstOrDefault(m_fundRepository.GetAll().OrderBy("id desc "));
            fund.RemainMoney = ((FundModel)lastFund).RemainMoney + fund.OperateMoney;
            fund.LastModificationTime = DateTime.Now;

            fund.MemberId = GetCurrentUserId();

            m_fundRepository.Insert(fund);
            return true;
        }

        [HttpPut]
        [AuthAttributeFilter(permissionName = PermissionNames.Fund_Update)]
        public bool UpdateFund([FromBody]FundEditDto request)
        {
            var fund = m_fundRepository.FirstOrDefault(f => f.Id == request.Id);
            request.MemberId = GetCurrentUserId();
            request.MapTo(fund);
            m_fundRepository.Update(fund);
            return true;
        }

        [HttpDelete]
        [AuthAttributeFilter(permissionName = PermissionNames.Fund_Delete)]
        public bool DeleteFund(int fundId)
        {
            m_fundRepository.Delete(fundId);
            return true;
        }

        [HttpGet]
        [AuthAttributeFilter(permissionName = PermissionNames.Fund_GetAll)]
        public PagedResultDto<FundListDto> GetTotalFunds(FundPagedInput input)
        {
            var response = HttpHelper.Get("Fooww.Research.Web.Host", "api/services/app/User/GetAllUserName");
            var ajaxResponse = JsonConvert.DeserializeObject<AjaxResponse>(response.Result);
            UserNameHelper.UserSelectDtos =
                JsonConvert.DeserializeObject<Dictionary<long, string>>(ajaxResponse.Result.ToString());
            var query = m_fundRepository.GetAll();
            if (!string.IsNullOrEmpty(input.FilterText))
            {
                query = query.Where(input.FilterText);
            }
            var count = DynamicQueryableExtensions.Count(query);
            if (!string.IsNullOrEmpty(input.Sorting))
            {
                query = query.OrderBy(input.Sorting);
            }
            var fundListDtos = query.AsNoTracking().PageBy(input).ToImmutableList().MapTo<List<FundListDto>>();
            return new PagedResultDto<FundListDto>(count, fundListDtos);
        }

        [HttpGet]
        [AuthAttributeFilter(permissionName = PermissionNames.Fund_Get)]
        public FundListDto GetFund(long id)
        {
            return m_fundRepository.FirstOrDefault(fund => fund.Id == id).MapTo<FundListDto>();
        }

        [HttpGet]
        public decimal GetRemainMoney()
        {
            var record = m_fundRepository.GetAll().OrderByDescending(x => x.Id).FirstOrDefault();
            if (record == null)
            {
                return 0;
            }
            return record.RemainMoney;
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
    }

    #endregion Support field
}