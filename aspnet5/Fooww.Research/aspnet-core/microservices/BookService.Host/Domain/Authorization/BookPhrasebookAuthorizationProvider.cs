using System.Linq;
using Abp.Authorization;
using Abp.Configuration.Startup;
using Abp.Localization;
using Abp.MultiTenancy;
using BookService.Host.Authorization;
using ResearchService.Host.Web;

namespace BookService.Host.Domain.Authorization
{
    /// <summary>
    /// 权限配置都在这里。
    /// 给权限默认设置服务
    /// See <see cref="BookPhrasebookPermissions" /> for all permission names. BookPhrasebook
    ///</summary>
    public class BookPhrasebookAuthorizationProvider : AuthorizationProvider
    {
        private readonly bool _isMultiTenancyEnabled;

        public BookPhrasebookAuthorizationProvider()
        {
        }

        public BookPhrasebookAuthorizationProvider(bool isMultiTenancyEnabled)
        {
            _isMultiTenancyEnabled = isMultiTenancyEnabled;
        }

        public BookPhrasebookAuthorizationProvider(IMultiTenancyConfig multiTenancyConfig)
        {
            _isMultiTenancyEnabled = multiTenancyConfig.IsEnabled;
        }

        public override void SetPermissions(IPermissionDefinitionContext context)
        {
            // 在这里配置了BookPhrasebook 的权限。
            var pages = context.GetPermissionOrNull(AppLtmPermissions.Pages) ?? context.CreatePermission(AppLtmPermissions.Pages, L("Pages"));

            var administration = pages.Children.FirstOrDefault(p => p.Name == AppLtmPermissions.Pages_Administration) ?? pages.CreateChildPermission(AppLtmPermissions.Pages_Administration, L("Administration"));

            var entityPermission = administration.CreateChildPermission(BookPhrasebookPermissions.Node, L("BookPhrasebook"));
            entityPermission.CreateChildPermission(BookPhrasebookPermissions.Query, L("QueryBookPhrasebook"));
            entityPermission.CreateChildPermission(BookPhrasebookPermissions.Create, L("CreateBookPhrasebook"));
            entityPermission.CreateChildPermission(BookPhrasebookPermissions.Edit, L("EditBookPhrasebook"));
            entityPermission.CreateChildPermission(BookPhrasebookPermissions.Delete, L("DeleteBookPhrasebook"));
            entityPermission.CreateChildPermission(BookPhrasebookPermissions.BatchDelete, L("BatchDeleteBookPhrasebook"));
            entityPermission.CreateChildPermission(BookPhrasebookPermissions.ExportExcel, L("ExportExcelBookPhrasebook"));
        }

        private static ILocalizableString L(string name)
        {
            return new LocalizableString(name, ResearchServiceConsts.LocalizationSourceName);
        }
    }
}