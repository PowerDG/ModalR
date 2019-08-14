
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


using BookService.Host.Domain.Dtos;
using BookService.Host.Domain;

namespace BookService.Host.Domain
{
    /// <summary>
    /// BookTag应用层服务的接口方法
    ///</summary>
    public interface IBookTagAppService : IApplicationService
    {
        /// <summary>
		/// 获取BookTag的分页列表信息
		///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task<PagedResultDto<BookTagListDto>> GetPaged(GetBookTagsInput input);


		/// <summary>
		/// 通过指定id获取BookTagListDto信息
		/// </summary>
		Task<BookTagListDto> GetById(EntityDto<uint> input);


        /// <summary>
        /// 返回实体的EditDto
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task<GetBookTagForEditOutput> GetForEdit(NullableIdDto<uint> input);


        /// <summary>
        /// 添加或者修改BookTag的公共方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task CreateOrUpdate(CreateOrUpdateBookTagInput input);


        /// <summary>
        /// 删除BookTag信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task Delete(EntityDto<uint> input);


        /// <summary>
        /// 批量删除BookTag
        /// </summary>
        Task BatchDelete(List<uint> input);


		/// <summary>
        /// 导出BookTag为excel表
        /// </summary>
        /// <returns></returns>
		//Task<FileDto> GetToExcel();

    }
}
