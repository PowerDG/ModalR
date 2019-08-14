using Abp.Authorization;
using Abp.Localization;
using Abp.MultiTenancy;

namespace Research.Authorization
{
    public class ResearchAuthorizationProvider : AuthorizationProvider
    {
        public override void SetPermissions(IPermissionDefinitionContext context)
        {
            //Common permissions
            var pages = context.GetPermissionOrNull(PermissionNames.Pages);
            if (pages == null)
            {
                pages = context.CreatePermission(PermissionNames.Pages, L("Pages"));
            }

            //context.CreatePermission(PermissionNames.Pages_DNA, L("DNA"));

            var users = pages.CreateChildPermission(PermissionNames.Pages_Users, L("Users"));

            //Host permissions
            var tenants = pages.CreateChildPermission(PermissionNames.Pages_Tenants, L("Tenants"), multiTenancySides: MultiTenancySides.Host);
            pages.CreateChildPermission(PermissionNames.Pages_Pages2_Tasks, L(PermissionNames.Pages_Pages2_Tasks));

            #region Staff

            var identifications = context.CreatePermission(PermissionNames.Identifications_Staff_Init, L(PermissionNames.Identifications_Staff_Init));
            identifications.CreateChildPermission(PermissionNames.Identifications_Staff_Members, L(PermissionNames.Identifications_Staff_Members));
            identifications.CreateChildPermission(PermissionNames.Identifications_Staff_Guest, L(PermissionNames.Identifications_Staff_Guest));
            identifications.CreateChildPermission(PermissionNames.Identifications_Staff_Assistant, L(PermissionNames.Identifications_Staff_Assistant));
            identifications.CreateChildPermission(PermissionNames.Identifications_Staff_Administrator, L(PermissionNames.Identifications_Staff_Administrator));

            #endregion Staff

            #region Book

            var pageBook = pages.CreateChildPermission(PermissionNames.Pages_BookInfo_Book_GetPages_Default, L(PermissionNames.Pages_BookInfo_Book_GetPages_Default));

            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Book_Create_Default, L(PermissionNames.Pages_BookInfo_Book_Create_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Book_Update_Default, L(PermissionNames.Pages_BookInfo_Book_Update_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Book_Borrow_Default, L(PermissionNames.Pages_BookInfo_Book_Borrow_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Book_Return_Default, L(PermissionNames.Pages_BookInfo_Book_Return_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Book_Delete_Default, L(PermissionNames.Pages_BookInfo_Book_Delete_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Book_Get_Default, L(PermissionNames.Pages_BookInfo_Book_Get_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Book_GetAll_Default, L(PermissionNames.Pages_BookInfo_Book_GetAll_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Review_Create_Default, L(PermissionNames.Pages_BookInfo_Review_Create_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Review_Create_Oneself, L(PermissionNames.Pages_BookInfo_Review_Create_Oneself));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Review_Create_Manager, L(PermissionNames.Pages_BookInfo_Review_Create_Manager));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Review_Update_Default, L(PermissionNames.Pages_BookInfo_Review_Update_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Review_Update_Oneself, L(PermissionNames.Pages_BookInfo_Review_Update_Oneself));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Review_Update_Manager, L(PermissionNames.Pages_BookInfo_Review_Update_Manager));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Review_Delete_Default, L(PermissionNames.Pages_BookInfo_Review_Delete_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Review_Get_Default, L(PermissionNames.Pages_BookInfo_Review_Get_Default));
            pageBook.CreateChildPermission(PermissionNames.Pages_BookInfo_Review_GetAll_Default, L(PermissionNames.Pages_BookInfo_Review_GetAll_Default));

            #endregion Book

            #region MyRegion

            var pageParty = pages.CreateChildPermission(PermissionNames.Pages_PartyInfo_Entrance_GetPages_Default, L(PermissionNames.Pages_BookInfo_Book_GetPages_Default));

            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Create_Default, L(PermissionNames.Pages_PartyInfo_Party_Create_Default));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Update_Default, L(PermissionNames.Pages_PartyInfo_Party_Update_Default));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Update_Oneself, L(PermissionNames.Pages_PartyInfo_Party_Update_Oneself));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Update_Manager, L(PermissionNames.Pages_PartyInfo_Party_Update_Manager));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Delete_Default, L(PermissionNames.Pages_PartyInfo_Party_Delete_Default));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Delete_Oneself, L(PermissionNames.Pages_PartyInfo_Party_Delete_Oneself));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Delete_Manager, L(PermissionNames.Pages_PartyInfo_Party_Delete_Manager));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Get_Default, L(PermissionNames.Pages_PartyInfo_Party_Get_Default));

            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Photo_Default, L(PermissionNames.Pages_PartyInfo_Party_Photo_Default));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Rate_Default, L(PermissionNames.Pages_PartyInfo_Party_Rate_Default));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_Comment_Default, L(PermissionNames.Pages_PartyInfo_Party_Comment_Default));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Party_GetAll_Default, L(PermissionNames.Pages_PartyInfo_Party_GetAll_Default));

            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Fund_Create_Default, L(PermissionNames.Pages_PartyInfo_Fund_Create_Default));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Fund_Update_Default, L(PermissionNames.Pages_PartyInfo_Fund_Update_Default));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Fund_Delete_Default, L(PermissionNames.Pages_PartyInfo_Fund_Delete_Default));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Fund_Get_Default, L(PermissionNames.Pages_PartyInfo_Fund_Get_Default));
            pageParty.CreateChildPermission(PermissionNames.Pages_PartyInfo_Fund_GetAll_Default, L(PermissionNames.Pages_PartyInfo_Fund_GetAll_Default));

            #endregion MyRegion
        }

        private static ILocalizableString L(string name)
        {
            return new LocalizableString(name, ResearchConsts.LocalizationSourceName);
        }
    }
}