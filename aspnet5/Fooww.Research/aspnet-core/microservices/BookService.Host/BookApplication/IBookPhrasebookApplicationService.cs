
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
    /// BookPhrasebook应用层服务的接口方法
    ///</summary>
    public interface IBookPhrasebookAppService : IApplicationService
    {
        /// <summary>
		/// 获取BookPhrasebook的分页列表信息
		///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task<PagedResultDto<BookPhrasebookListDto>> GetPaged(GetBookPhrasebooksInput input);


		/// <summary>
		/// 通过指定id获取BookPhrasebookListDto信息
		/// </summary>
		Task<BookPhrasebookListDto> GetById(EntityDto<uint> input);


        /// <summary>
        /// 返回实体的EditDto
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task<GetBookPhrasebookForEditOutput> GetForEdit(NullableIdDto<uint> input);


        /// <summary>
        /// 添加或者修改BookPhrasebook的公共方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task CreateOrUpdate(CreateOrUpdateBookPhrasebookInput input);


        /// <summary>
        /// 删除BookPhrasebook信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task Delete(EntityDto<uint> input);


        /// <summary>
        /// 批量删除BookPhrasebook
        /// </summary>
        Task BatchDelete(List<uint> input);


		/// <summary>
        /// 导出BookPhrasebook为excel表
        /// </summary>
        /// <returns></returns>
		//Task<FileDto> GetToExcel();

    }
}
