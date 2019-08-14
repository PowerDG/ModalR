namespace ImageService.Host.Result
{
    /// <summary>
    /// </summary>
    public class UploadResult
    {
        /// <summary>
        /// 结果状态
        /// </summary>
        public bool Success { get; set; }

        /// <summary>
        /// 原始图片地址
        /// </summary>
        public string OriginalUrl { get; set; }

        /// <summary>
        /// 缩略图地址
        /// </summary>
        public string ThumbUrl { get; set; }
    }
}