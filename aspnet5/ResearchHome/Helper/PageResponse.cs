namespace ResearchHome.Helper
{
    /// <summary>
    /// LayUi Table 分页类
    /// </summary>
    public class PageResponse
    {
        public PageResponse()
        {
        }

        public PageResponse(dynamic Data, long Count = 0, int Code = 0, string Msg = "")
        {
            count = Count;
            data = Data;
            code = Code;
            msg = Msg;
        }
        
        /// <summary>
        /// 状态码 默认为0 非必填
        /// </summary>
        public int code { get; set; }

        /// <summary>
        /// 消息
        /// </summary>
        public string msg { get; set; }

        public long count { get; set; }

        public dynamic data { get; set; }
    }
}
