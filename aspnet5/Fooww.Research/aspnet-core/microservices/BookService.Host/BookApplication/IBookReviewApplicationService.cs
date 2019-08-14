
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
    /// BookReview应用层服务的接口方法
    ///</summary>
    public interface IBookReviewAppService : IApplicationService
    {
        /// <summary>
		/// 获取BookReview的分页列表信息
		///</summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task<PagedResultDto<BookReviewListDto>> GetPaged(GetBookReviewsInput input);


		/// <summary>
		/// 通过指定id获取BookReviewListDto信息
		/// </summary>
		Task<BookReviewListDto> GetById(EntityDto<uint> input);


        /// <summary>
        /// 返回实体的EditDto
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task<GetBookReviewForEditOutput> GetForEdit(NullableIdDto<uint> input);


        /// <summary>
        /// 添加或者修改BookReview的公共方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task CreateOrUpdate(CreateOrUpdateBookReviewInput input);


        /// <summary>
        /// 删除BookReview信息的方法
        /// </summary>
        /// <param name="input"></param>
        /// <returns></returns>
        Task Delete(EntityDto<uint> input);


        /// <summary>
        /// 批量删除BookReview
        /// </summary>
        Task BatchDelete(List<uint> input);


		/// <summary>
        /// 导出BookReview为excel表
        /// </summary>
        /// <returns></returns>
		//Task<FileDto> GetToExcel();

    }
}
