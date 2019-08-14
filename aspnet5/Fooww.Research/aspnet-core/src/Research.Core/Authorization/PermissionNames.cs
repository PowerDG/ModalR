namespace Research.Authorization
{
    public static class PermissionNames
    {
        public const string Pages = "Pages";

        public const string Pages_Tenants = "Pages.Tenants";

        public const string Pages_Users = "Pages.Users";

        #region Staff

        public const string Pages_Pages2_Tasks = "Pages.Pages2.Tasks";
        public const string Identifications_Staff_Members = "Identifications.Staff.Members";
        public const string Identifications_Staff_Guest = "Identifications.Staff.Guest";
        public const string Identifications_Staff_Assistant = "Identifications.Staff.Assistant";
        public const string Identifications_Staff_Init = "Identifications.Staff.Init";
        public const string Identifications_Staff_Administrator = "Identifications.Staff.Administrator";

        #endregion Staff

        #region Book

        public const string Pages_BookInfo_Book_GetPages_Default = "Pages.BookInfo.Book.GetPages.Default";
        public const string Pages_BookInfo_Book_Create_Default = "Pages.BookInfo.Book.Create.Default";
        public const string Pages_BookInfo_Book_Update_Default = "Pages.BookInfo.Book.Update.Default";
        public const string Pages_BookInfo_Book_Borrow_Default = "Pages.BookInfo.Book.Borrow.Default";
        public const string Pages_BookInfo_Book_Return_Default = "Pages.BookInfo.Book.Return.Default";
        public const string Pages_BookInfo_Book_Delete_Default = "Pages.BookInfo.Book.Delete.Default";
        public const string Pages_BookInfo_Book_Get_Default = "Pages.BookInfo.Book.Get.Default";
        public const string Pages_BookInfo_Book_GetAll_Default = "Pages.BookInfo.Book.GetAll.Default";
        public const string Pages_BookInfo_Review_Create_Default = "Pages.BookInfo.Review.Create.Default";
        public const string Pages_BookInfo_Review_Create_Oneself = "Pages.BookInfo.Review.Create.Oneself";
        public const string Pages_BookInfo_Review_Create_Manager = "Pages.BookInfo.Review.Create.Manager";
        public const string Pages_BookInfo_Review_Update_Default = "Pages.BookInfo.Review.Update.Default";
        public const string Pages_BookInfo_Review_Update_Oneself = "Pages.BookInfo.Review.Update.Oneself";
        public const string Pages_BookInfo_Review_Update_Manager = "Pages.BookInfo.Review.Update.Manager";
        public const string Pages_BookInfo_Review_Delete_Default = "Pages.BookInfo.Review.Delete.Default";
        public const string Pages_BookInfo_Review_Get_Default = "Pages.BookInfo.Review.Get.Default";
        public const string Pages_BookInfo_Review_GetAll_Default = "Pages.BookInfo.Review.GetAll.Default";

        #endregion Book

        #region PartyInfo

        public const string Pages_PartyInfo_Entrance_GetPages_Default = "Pages.PartyInfo.Entrance.GetPages.Default";
        public const string Pages_PartyInfo_Party_Create_Default = "Pages.PartyInfo.Party.Create.Default";
        public const string Pages_PartyInfo_Party_Update_Default = "Pages.PartyInfo.Party.Update.Default";
        public const string Pages_PartyInfo_Party_Update_Oneself = "Pages.PartyInfo.Party.Update.Oneself";
        public const string Pages_PartyInfo_Party_Update_Manager = "Pages.PartyInfo.Party.Update.Manager";
        public const string Pages_PartyInfo_Party_Delete_Default = "Pages.PartyInfo.Party.Delete.Default";
        public const string Pages_PartyInfo_Party_Delete_Oneself = "Pages.PartyInfo.Party.Delete.Oneself";
        public const string Pages_PartyInfo_Party_Delete_Manager = "Pages.PartyInfo.Party.Delete.Manager";
        public const string Pages_PartyInfo_Party_Get_Default = "Pages.PartyInfo.Party.Get.Default";

        public const string Pages_PartyInfo_Party_Photo_Default = "Pages.PartyInfo.Party.Photo.Default";
        public const string Pages_PartyInfo_Party_Rate_Default = "Pages.PartyInfo.Party.Rate.Default";
        public const string Pages_PartyInfo_Party_Comment_Default = "Pages.PartyInfo.Party.Comment.Default";
        public const string Pages_PartyInfo_Party_GetAll_Default = "Pages.PartyInfo.Party.GetAll.Default";

        public const string Pages_PartyInfo_Fund_Create_Default = "Pages.PartyInfo.Fund.Create.Default";
        public const string Pages_PartyInfo_Fund_Update_Default = "Pages.PartyInfo.Fund.Update.Default";
        public const string Pages_PartyInfo_Fund_Delete_Default = "Pages.PartyInfo.Fund.Delete.Default";
        public const string Pages_PartyInfo_Fund_Get_Default = "Pages.PartyInfo.Fund.Get.Default";
        public const string Pages_PartyInfo_Fund_GetAll_Default = "Pages.PartyInfo.Fund.GetAll.Default";

        #endregion PartyInfo
    }
}