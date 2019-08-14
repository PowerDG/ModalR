using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace BookService.Host
{
    public class ResearchServiceConsts
    {
        public const string LocalizationSourceName = "PartyService";

        public const string ConnectionStringName = "Default";

        #region DomainField

        public const int DefaultPageSize = 10;
        public const int MaxPageSize = 1000;
        public const int MaxTitleSize = 60;
        public const int MaxFiledSize = 250;

        #endregion DomainField

        #region 图书Domain

        public const long DefaultBorrowBookMemberId = 0;

        public const byte IsCanBorrowBook = 0;
        public const byte IsBorrowedBook = 1;
        public const byte IsLostBook = 2;

        #endregion 图书Domain
    }
}