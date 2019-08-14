namespace ResearchService.Host.Web
{
    public static class PermissionNames
    {
        public const string Pages = "Pages";

        public const string Pages_Tenants = "Pages.Tenants";

        public const string Pages_Users = "Pages.Users";
        //Green Channel

        public const string Green_Channel = "Green.Channel";

        #region Party活动林    权限名

        public const string Entrance_GetPages = "Pages.PartyInfo.Entrance.GetPages.Default";
        public const string Party_Create = "Pages.PartyInfo.Party.Create.Default";
        public const string Party_Update = "Pages.PartyInfo.Party.Update.Default";
        public const string Party_Update_Oneself = "Pages.PartyInfo.Party.Update.Oneself";
        public const string Party_Update_Manager = "Pages.PartyInfo.Party.Update.Manager";
        public const string Party_Delete = "Pages.PartyInfo.Party.Delete.Default";
        public const string Party_Delete_Oneself = "Pages.PartyInfo.Party.Delete.Oneself";
        public const string Party_Delete_Manager = "Pages.PartyInfo.Party.Delete.Manager";
        public const string Party_Get = "Pages.PartyInfo.Party.Get.Default";
        public const string Party_GetAll = "Pages.PartyInfo.Party.GetAll.Default";

        public const string Party_Rate = "Pages.PartyInfo.Party.Rate.Default";

        public const string Party_Photo = "Pages.PartyInfo.Party.Photo.Default";
        public const string Party_Comment = "Pages.PartyInfo.Party.Comment.Default";

        public const string Fund_Create = "Pages.PartyInfo.Fund.Create.Default";
        public const string Fund_Update = "Pages.PartyInfo.Fund.Update.Default";
        public const string Fund_Delete = "Pages.PartyInfo.Fund.Delete.Default";
        public const string Fund_Get = "Pages.PartyInfo.Fund.Get.Default";
        public const string Fund_GetAll = "Pages.PartyInfo.Fund.GetAll.Default";

        #endregion Party活动林    权限名
    }
}