using System;
using System.Data;
using System.IO;
using System.Linq;
using System.Linq.Dynamic;
using System.Linq.Expressions;
using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using Abp.Linq;
using Abp.Linq.Extensions;
using Abp.Extensions;
using Abp.UI;
using Abp.Domain.Repositories;
using Abp.Domain.Services;

using BookService.Host;
using BookService.Host.Domain;

namespace BookService.Host.Domain.DomainService
{
    /// <summary>
    /// BookPhrasebook领域层的业务管理
    ///</summary>
    public class BookPhrasebookManager : BookDomainServiceBase, IBookPhrasebookManager
    {
        private readonly IRepository<BookPhrasebook, uint> _repository;

        /// <summary>
        /// BookPhrasebook的构造方法
        ///</summary>
        public BookPhrasebookManager(
            IRepository<BookPhrasebook, uint> repository
        )
        {
            _repository = repository;
        }

        /// <summary>
        /// 初始化
        ///</summary>
        public void InitBookPhrasebook()
        {
            throw new NotImplementedException();
        }

        // TODO:编写领域业务代码
    }
}