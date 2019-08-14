using Newtonsoft.Json;
namespace ResearchHome.Models
{
    /// <summary>
    /// 图片实体
    /// </summary>
    public class UploadPictureModel
    {
        [JsonProperty("Src")]
        public string Src { get; set; }

        [JsonProperty("Name")]
        public string Name { get; set; }

        [JsonProperty("Type")]
        public string Type { get; set; }
    }
}
