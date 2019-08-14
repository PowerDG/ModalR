using System.Linq;
using Abp.Authorization;
using Abp.Configuration.Startup;
using Abp.Localization;
using Abp.MultiTenancy;
using BookService.Host;
using BookService.Host.Authorization;
using ResearchService.Host.Web;

namespace BookService.Host.Domain.Authorization
{
    /// <summary>
    /// 权限配置都在这里。
    /// 给权限默认设置服务
    /// See <see cref="BookReviewPermissions" /> for all permission names. BookReview
    ///</summary>
    public class BookReviewAuthorizationProvider : AuthorizationProvider
    {
        private readonly bool _isMultiTenancyEnabled;

        public BookReviewAuthorizationProvider()
        {
        }

        public BookReviewAuthorizationProvider(bool isMultiTenancyEnabled)
        {
            _isMultiTenancyEnabled = isMultiTenancyEnabled;
        }

        public BookReviewAuthorizationProvider(IMultiTenancyConfig multiTenancyConfig)
        {
            _isMultiTenancyEnabled = multiTenancyConfig.IsEnabled;
        }

        public override void SetPermissions(IPermissionDefinitionContext context)
        {
            // 在这里配置了BookReview 的权限。
            var pages = context.GetPermissionOrNull(AppLtmPermissions.Pages) ?? context.CreatePermission(AppLtmPermissions.Pages, L("Pages"));

            var administration = pages.Children.FirstOrDefault(p => p.Name == AppLtmPermissions.Pages_Administration) ?? pages.CreateChildPermission(AppLtmPermissions.Pages_Administration, L("Administration"));

            var entityPermission = administration.CreateChildPermission(BookReviewPermissions.Node, L("BookReview"));
            entityPermission.CreateChildPermission(BookReviewPermissions.Query, L("QueryBookReview"));
            entityPermission.CreateChildPermission(BookReviewPermissions.Create, L("CreateBookReview"));
            entityPermission.CreateChildPermission(BookReviewPermissions.Edit, L("EditBookReview"));
            entityPermission.CreateChildPermission(BookReviewPermissions.Delete, L("DeleteBookReview"));
            entityPermission.CreateChildPermission(BookReviewPermissions.BatchDelete, L("BatchDeleteBookReview"));
            entityPermission.CreateChildPermission(BookReviewPermissions.ExportExcel, L("ExportExcelBookReview"));
        }

        private static ILocalizableString L(string name)
        {
            return new LocalizableString(name, ResearchServiceConsts.LocalizationSourceName);
        }
    }
}