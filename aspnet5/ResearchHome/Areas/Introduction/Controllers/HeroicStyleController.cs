using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using ResearchHome.Models;
using System;
using System.Diagnostics;
using System.Linq;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public partial class HeroicStyleController : BaseController
    {
        private readonly IConfiguration _configuration;
        private readonly IDatabase _database;
        private IHostingEnvironment _environment;

        public HeroicStyleController(IConfiguration configuration, IDatabase database, IHostingEnvironment environment)
        {
            _configuration = configuration;
            _database = database;
            _environment = environment;
        }

        public IActionResult HeroicStyle()
        {
            return View();
        }

        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }

        public IActionResult MoreHeroicStyle()
        {
            return View();
        }

        [HttpPost]
        public JsonResult GetHeroicStyleData(string showStyle)
        {
            var sqlLimitStr = showStyle == "showPart" ? " LIMIT 20" : "";
            var picturesModel = _database.QueryListSQL<PicturesModel>($@"SELECT Id,Url,Description,PartialPictureUrl,MemberId FROM Pictures
                                                                          ORDER BY UpdatedTime DESC {sqlLimitStr}");
            return Json(picturesModel);
        }

        [HttpPost]
        public JsonResult GetHeroicStyleByPaging(int page, int limit)
        {
            string sql = $@"SELECT Id,Url,Description,PartialPictureUrl,MemberId
                            FROM Pictures
                            ORDER BY UpdatedTime DESC LIMIT {limit * (page - 1)},{limit}";
            var picturesModel = _database.QueryListSQL<PicturesModel>(sql);
            return Json(picturesModel);
        }

        [HttpPost]
        public JsonResult GetHeroicStylePicturesCount(int page, int limit)
        {
            var picturesCount = _database.Single<int>($@"SELECT COUNT(Id) FROM Pictures");
            return Json(new { picturesCount });
        }

        /// <summary>
        /// 获取轮播图片
        /// </summary>
        /// <param name="currentPicId"></param>
        /// <param name="showStyle"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult GetHeroicStylePic(int currentPicId, string showStyle)
        {
            var sqlLimitStr = showStyle == "showPart" ? " LIMIT 20" : "";
            var picturesModel = _database.QueryListSQL<PicturesModel>($@"SELECT Id,Url,Description,PartialPictureUrl,MemberId FROM Pictures
                                                                          ORDER BY UpdatedTime DESC {sqlLimitStr}");

            var query = from pic in picturesModel
                        select new
                        {
                            alt = pic.Description,
                            pid = pic.Id,
                            src = pic.Url,
                            thumb = pic.PartialPictureUrl
                        };
            var result = new { title = "英雄风采", id = currentPicId, start = currentPicId, data = query.ToList() };
            return Json(result);
        }

        /// <summary>
        /// 跳转到编辑界面
        /// </summary>
        public IActionResult OptionHeroicStyle(long pictureId)
        {
            if (pictureId > 0)
            {
                var picturesModel = _database.QuerySQL<PicturesModel>($@"SELECT Id,Url,PartialPictureUrl,Description FROM Pictures WHERE Id = {pictureId}");
                return View(picturesModel);
            }
            else
            {
                return View(new PicturesModel());
            }
        }

        [HttpPost]
        public JsonResult DeleteHeroicStyle(long pictureId)
        {
            var memberId = GetCurrentUserClaim("Id");
            if (string.IsNullOrEmpty(memberId))
            {
                return Json(false);
            }
            var effectCount = _database.ExecuteSQL($"DELETE FROM Pictures WHERE Id = {pictureId}");
            return Json(effectCount);
        }

        [HttpPost]
        public JsonResult UpdateHeroicStyle(PicturesModel picturesModel)
        {
            var effectCount = false;
            var memberId = GetCurrentUserClaim("Id");
            if (string.IsNullOrEmpty(memberId))
            {
                return Json(new { result = false, msg = "请先登录" });
            }

            if (string.IsNullOrEmpty(picturesModel.UploadImg))
            {
                effectCount = _database.UpdateSQL($@"Pictures",
                                            new DataColumn("Description", picturesModel.Description),
                                            new DataColumn("UpdatedTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")),
                                            new DataColumn("MemberId", memberId),
                                            new DataColumn("Id", picturesModel.Id, true));
                return Json(new { result = effectCount, msg = "" });
            }

            var imgUrlResult = PictureHelper.UploadPicture("FileUpload", picturesModel.UploadImg, _configuration, _environment);
            var imgUrl = imgUrlResult.Item1;
            var additionalInformation = imgUrlResult.Item2;
            if (imgUrl == null)
            {
                return Json(new { result = false, msg = $@"{additionalInformation},请通知管理员查看！" });
            }
            effectCount = _database.UpdateSQL($@"Pictures",
                                            new DataColumn("Url", imgUrl),
                                            new DataColumn("PartialPictureUrl", additionalInformation),
                                            new DataColumn("Description", picturesModel.Description),
                                            new DataColumn("UpdatedTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")),
                                            new DataColumn("MemberId", memberId),
                                            new DataColumn("Id", picturesModel.Id, true));
            if (effectCount)
            {
                PictureHelper.DeletePicture($"{_environment.WebRootPath}{picturesModel.Url}");
                PictureHelper.DeletePicture($"{_environment.WebRootPath}{picturesModel.PartialPictureUrl}");
            }
            return Json(new { result = effectCount, msg = "" });
        }

        [HttpPost]
        public JsonResult InsertHeroicStyle(PicturesModel picturesModel)
        {
            var effectCount = false;
            var memberId = GetCurrentUserClaim("Id");
            if (string.IsNullOrEmpty(memberId))
            {
                return Json(new { result = false, msg = "请先登录" });
            }

            if (string.IsNullOrEmpty(picturesModel.UploadImg))
            {
                return Json(new { result = false, msg = "请上传图片" });
            }

            if (string.IsNullOrEmpty(picturesModel.Description) || picturesModel.Description.Length > 40)
            {
                return Json(new { result = false, msg = "描述不能为空,且不能超过40个字" });
            }

            var imgUrlResult = PictureHelper.UploadPicture("FileUpload", picturesModel.UploadImg, _configuration, _environment);
            var imgUrl = imgUrlResult.Item1;
            var additionalInformation = imgUrlResult.Item2;
            if (imgUrl == null)
            {
                return Json(new { result = false, msg = $@"{additionalInformation},请通知管理员查看！" });
            }

            effectCount = _database.InsertSQL($@"Pictures",
                                                new DataColumn("Url", imgUrl),
                                                new DataColumn("PartialPictureUrl", additionalInformation),
                                                new DataColumn("Description", picturesModel.Description),
                                                new DataColumn("UpdatedTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")),
                                                new DataColumn("MemberId", memberId)
                                            );
            return Json(new { result = effectCount, msg = "" });
        }
    }
}