namespace ImageService.Host.Dtos
{
    /// <summary>
    /// 文件上传的信息
    /// </summary>
    public class FileDtos
    {
        /// <summary>
        /// 文件目录类型
        /// </summary>
        public string FileType { get; set; }

        /// <summary>
        /// 是否需要缩略图
        /// </summary>
        public bool NeedThumb { get; set; }

        /// <summary>
        /// base64String
        /// </summary>
        public string Base64String { get; set; }
    }
}