namespace ResearchService.Host.Web
{
    public static class PermissionNames
    {
        public const string Pages = "Pages";

        public const string Pages_Tenants = "Pages.Tenants";

        public const string Pages_Users = "Pages.Users";

        //Green Channel
        public const string Green_Channel = "Green.Channel";

        #region Book

        public const string BookInfo_Entrance_GetPages = "Pages.BookInfo.Book.GetPages.Default";
        public const string Book_Create = "Pages.BookInfo.Book.Create.Default";
        public const string Book_Update = "Pages.BookInfo.Book.Update.Default";
        public const string Book_Borrow = "Pages.BookInfo.Book.Borrow.Default";
        public const string Book_Return = "Pages.BookInfo.Book.Return.Default";
        public const string Book_Delete = "Pages.BookInfo.Book.Delete.Default";
        public const string Book_Get = "Pages.BookInfo.Book.Get.Default";
        public const string Book_GetAll = "Pages.BookInfo.Book.GetAll.Default";
        public const string Review_Create = "Pages.BookInfo.Review.Create.Default";
        public const string Review_Create_Oneself = "Pages.BookInfo.Review.Create.Oneself";
        public const string Review_Create_Manager = "Pages.BookInfo.Review.Create.Manager";
        public const string Review_Update = "Pages.BookInfo.Review.Update.Default";
        public const string Review_Update_Oneself = "Pages.BookInfo.Review.Update.Oneself";
        public const string Review_Update_Manager = "Pages.BookInfo.Review.Update.Manager";
        public const string Review_Delete = "Pages.BookInfo.Review.Delete.Default";
        public const string Review_Get = "Pages.BookInfo.Review.Get.Default";
        public const string Review_GetAll = "Pages.BookInfo.Review.GetAll.Default";

        #endregion Book
    }
}