

namespace BookService.Host.Domain.Authorization
{
	/// <summary>
    /// 定义系统的权限名称的字符串常量。
    /// <see cref="BookPhrasebookAuthorizationProvider" />中对权限的定义.
    ///</summary>
	public static  class BookPhrasebookPermissions
	{
		/// <summary>
		/// BookPhrasebook权限节点
		///</summary>
		public const string Node = "Pages.BookPhrasebook";

		/// <summary>
		/// BookPhrasebook查询授权
		///</summary>
		public const string Query = "Pages.BookPhrasebook.Query";

		/// <summary>
		/// BookPhrasebook创建权限
		///</summary>
		public const string Create = "Pages.BookPhrasebook.Create";

		/// <summary>
		/// BookPhrasebook修改权限
		///</summary>
		public const string Edit = "Pages.BookPhrasebook.Edit";

		/// <summary>
		/// BookPhrasebook删除权限
		///</summary>
		public const string Delete = "Pages.BookPhrasebook.Delete";

        /// <summary>
		/// BookPhrasebook批量删除权限
		///</summary>
		public const string BatchDelete = "Pages.BookPhrasebook.BatchDelete";

		/// <summary>
		/// BookPhrasebook导出Excel
		///</summary>
		public const string ExportExcel="Pages.BookPhrasebook.ExportExcel";

		 
		 
         
    }

}

