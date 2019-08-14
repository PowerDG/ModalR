

namespace BookService.Host.Domain.Authorization
{
	/// <summary>
    /// 定义系统的权限名称的字符串常量。
    /// <see cref="BookReviewAuthorizationProvider" />中对权限的定义.
    ///</summary>
	public static  class BookReviewPermissions
	{
		/// <summary>
		/// BookReview权限节点
		///</summary>
		public const string Node = "Pages.BookReview";

		/// <summary>
		/// BookReview查询授权
		///</summary>
		public const string Query = "Pages.BookReview.Query";

		/// <summary>
		/// BookReview创建权限
		///</summary>
		public const string Create = "Pages.BookReview.Create";

		/// <summary>
		/// BookReview修改权限
		///</summary>
		public const string Edit = "Pages.BookReview.Edit";

		/// <summary>
		/// BookReview删除权限
		///</summary>
		public const string Delete = "Pages.BookReview.Delete";

        /// <summary>
		/// BookReview批量删除权限
		///</summary>
		public const string BatchDelete = "Pages.BookReview.BatchDelete";

		/// <summary>
		/// BookReview导出Excel
		///</summary>
		public const string ExportExcel="Pages.BookReview.ExportExcel";

		 
		 
         
    }

}

