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
using Abp.Authorization;
using Abp.Linq.Extensions;
using Abp.Domain.Repositories;
using Abp.Application.Services;
using Abp.Application.Services.Dto;

using Research.Member.Members.Dtos;
using Research.Member.Members;

namespace Research.Member.Members
{
    /// <summary>
    /// MemberInfo应用层服务的接口方法
    ///</summary>
    public interface IMemberInfoAppService : IApplicationService
    {
        /// <summary>
		/// 获取MemberInfo的分页列表信息
		///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task<PagedResultDto<MemberInfoListDto>> GetPaged(GetMemberInfosInput input);

        /// <summary>
        /// 通过指定id获取MemberInfoListDto信息
        /// </summary>
        Task<MemberInfoListDto> GetById(EntityDto<long> input);

        /// <summary>
        /// 返回实体的EditDto
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task<GetMemberInfoForEditOutput> GetForEdit(NullableIdDto<long> input);

        /// <summary>
        /// 删除MemberInfo信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task Delete(EntityDto<long> input);

        /// <summary>
        /// 批量删除MemberInfo
        /// </summary>
        Task BatchDelete(List<long> input);

        /// <summary>
        /// 导出MemberInfo为excel表
        /// </summary>
        /// <returns></returns>
        //Task<FileDto> GetToExcel();
    }
}