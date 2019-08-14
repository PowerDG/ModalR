using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ResearchHome.Areas.PartyAndActivity.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ResearchHome.Areas.PartyAndActivity.Controllers
{
    [Area("PartyAndActivity")]
    public class PartiesController : BaseController
    {
        private readonly IConfiguration m_configuration;
        private IHostingEnvironment m_environment;
        private readonly IDatabase m_database;

        public PartiesController(IConfiguration config, IDatabase db, IHostingEnvironment environ)
        {
            m_configuration = config;
            m_database = db;
            m_environment = environ;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult OptionPartyImg(int partyId)
        {
            return View(new PartyImgModel() { PartyId = partyId });
        }

        public IActionResult CreateParty(int? partyId)
        {
            if (partyId != null)
            {
                string partySql = $@"SELECT * FROM parties WHERE Id={partyId}";
                var party = m_database.Single<PartyModel>(partySql);
                PartyModel partyModel = party;
                return View(partyModel);
            }
            return View(new PartyModel());
        }

        [HttpPost]
        public JsonResult CreateParty(PartyModel request)
        {
            bool result = false;
            string msg = "";
            if (!RequestVertify(request, ref msg))
            {
                return Json(new { result, msg });
            }
            string memberId = GetCurrentUserClaim("Id");
            if (request.Id > 0)
            {
                result = m_database.ExecuteSQL($@"UPDATE parties SET PartyName='{request.PartyName}',Address='{request.Address}',
                        MemberId={memberId}, Tel='{request.Tel}', StartTime='{request.StartTime}',EndTime='{request.EndTime}',
                        PartyPlace='{request.PartyPlace}',MoneyResource={request.MoneyResource},Number={request.Number},
                        Longitude={request.Longitude},Latitude={request.Latitude}  WHERE Id ={request.Id}");
            }
            else
            {
                result = m_database.TransactionInsertSQL("parties", new DataColumn("PartyName", request.PartyName),
                         new DataColumn("Address", request.Address), new DataColumn("MemberId", memberId),
                         new DataColumn("Tel", request.Tel), new DataColumn("StartTime", request.StartTime),
                         new DataColumn("EndTime", request.EndTime), new DataColumn("PartyPlace", request.PartyPlace),
                         new DataColumn("Longitude", request.Longitude), new DataColumn("Latitude", request.Latitude),
                         new DataColumn("Money", request.Money), new DataColumn("MoneyResource", request.MoneyResource),
                         new DataColumn("LikeLevel", request.LikeLevel), new DataColumn("Number", request.Number));
            }
            if (request.MoneyResource == 1 && request.Id == 0)
            {
                AddFundItem(request);
            }
            return Json(new { Result = result, Msg = msg });
        }

        private bool RequestVertify(PartyModel request, ref string msg)
        {
            if (!(request.Money < 1000000 && request.Money > 0))
            {
                msg = "请输入正确的金额";
                return false;
            }
            else if (!(request.Number < 10000 && request.Number > 0))
            {
                msg = "请输入正确的人数";
                return false;
            }
            if (request.StartTime > request.EndTime)
            {
                msg = "请输入正确的时间！";
                return false;
            }
            return true;
        }

        private void AddFundItem(PartyModel request)
        {
            string remainMoneySql = $@"SELECT RemainMoney FROM fund
                                    ORDER BY InsertTime DESC
                                    LIMIT 1";
            decimal? remainMoney = m_database.Single<decimal>(remainMoneySql);
            remainMoney -= request.Money;
            decimal? money = request.Money * -1;
            string memberId = GetCurrentUserClaim("Id");
            var result = m_database.TransactionInsertSQL("Fund",
                         new DataColumn("InsertTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")), new DataColumn("Description", request.PartyPlace),
                         new DataColumn("ItemName", request.PartyName), new DataColumn("OperatMoney", money),
                         new DataColumn("RemainMoney", remainMoney), new DataColumn("MemberId", memberId));
        }

        [HttpPost]
        public JsonResult DeleteReview(int partyId)
        {
            string deletePartySql = $@"DELETE FROM parties WHERE Id={partyId}";
            bool result = m_database.ExecuteSQL(deletePartySql);
            string deleteReviewSql = $@"DELETE FROM partiesreviews WHERE PartyId={partyId}";
            if (result)
            {
               m_database.ExecuteSQL(deleteReviewSql);
            }
            return Json(new { result });
        }

        [HttpPost]
        public JsonResult UpdatePartyLikeLevel(int value, int partyId)
        {
            string getCurrentValue = $@"SELECT  LikeLevel FROM parties WHERE Id={partyId}";
            double currValue = (double)m_database.Single<decimal>(getCurrentValue);
            string reviewTimesSql = $@"SELECT  ReviewTimes FROM parties WHERE Id={partyId}";
            int reviewTimes = m_database.Single<int>(reviewTimesSql);

            double newValue = (currValue * reviewTimes + value) / (reviewTimes + 1.0);

            string updateValue = $@"UPDATE  parties SET LikeLevel={newValue},ReviewTimes={reviewTimes + 1} WHERE Id={partyId}";
            bool result = m_database.ExecuteSQL(updateValue);

            return Json(new { Result = result });
        }

        [HttpPost]
        public JsonResult ShowMoreReview(int partyId)
        {
            string allReviewSql = $@"SELECT Review FROM partiesreviews WHERE PartyId={partyId} ORDER BY ReviewTime DESC";
            var reviews = m_database.QueryListSQL<dynamic>(allReviewSql).ToList();

            return Json(new { Reviews = reviews });
        }

        [HttpPost]
        public JsonResult SubmitReview(int partyId, string text)
        {
            if (text == null || text == "")
            {
                return Json(new { result = false });
            }
            string memberId = GetCurrentUserClaim("Id");
            string submitReview = $@"INSERT INTO partiesreviews SET PartyId={partyId},MemberId={memberId},
                                                                Review='{text}',ReviewTime= now()";
            bool result = m_database.ExecuteSQL(submitReview);

            return Json(new { Result = result });
        }

        public JsonResult GetParties(int page, int limit, string queryType, string search)
        {
            var parties = new List<dynamic>();
            string sqlCount = $@"SELECT COUNT(*) FROM parties";
            int partiesCount = m_database.QuerySQL<int>(sqlCount);
            if (search != null)
            {
                parties = GetSearchParties(search, page, limit);
                sqlCount = $@"SELECT COUNT(*) FROM parties WHERE PartyName LIKE '%{search}%' OR PartyPlace LIKE '%{search}%'";
                partiesCount = m_database.QuerySQL<int>(sqlCount);
            }
            else
            {
                switch (queryType)
                {
                    case "HighPraiseParties":
                        parties = GetHighPraiseParties(page, limit);
                        break;

                    case "MostTime":
                        parties = GetMostTimeParties(page, limit);
                        break;

                    default:
                        parties = GetAllParties(page, limit);
                        break;
                }
            }
            parties = GeneratePartyResponse(parties);

            return Json(new PageResponse(parties, partiesCount));
        }

        private List<dynamic> GetSearchParties(string search, int page, int limit)
        {
            string searchSql = $@"SELECT * FROM parties
                                  WHERE PartyName LIKE '%{search}%' OR PartyPlace LIKE '%{search}%'
                                  ORDER BY EndTime DESC LIMIT {limit * (page - 1)},{limit}";

            var parties = m_database.QueryListSQL<dynamic>(searchSql).ToList();
            return parties;
        }

        private List<dynamic> GeneratePartyResponse(List<dynamic> parties)
        {
            string sqlPic = $@"SELECT * FROM partyphotos AS b WHERE	b.PartyId IN (SELECT PartyId FROM partyphotos)
                                ";//GROUP BY   CONCAT(b.PartyId, b.Id % 3)
            var picInfo = m_database.QueryListSQL<dynamic>(sqlPic).ToList();

            List<dynamic> result = new List<dynamic>();
            foreach (var party in parties)
            {
                var pics = picInfo.Where(m => m.PartyId == party.Id).Select(m =>
                                        new { m.PartyId, m.ImgUrl, m.ImgUrlPart, m.ImgDescription }).ToList();
                string sqlReview = $@"SELECT Review FROM partiesreviews WHERE PartyId={party.Id} ORDER BY ReviewTime DESC LIMIT 3";
                var reviews = m_database.QueryListSQL<dynamic>(sqlReview).ToList().Select(m => new { m.Review }).ToList();
                int likeLevel = decimal.ToInt32(party.LikeLevel + new decimal(0.5));
                result.Add(new
                {
                    isCanEdit = IsCanEdit(),
                    isCanDelete = IsCanDelete(party.MemberId),
                    party.Id,
                    party.Address,
                    party.EndTime,
                    LikeLevel = likeLevel,
                    party.ReviewTimes,
                    party.Money,
                    party.MoneyResource,
                    party.Number,
                    party.PartyName,
                    party.PartyPlace,
                    party.Longitude,
                    party.Latitude,
                    party.StartTime,
                    party.Tel,
                    pics,
                    reviews
                });
            }
            return result;
        }

        private bool IsCanEdit()
        {
            return !string.IsNullOrEmpty(GetCurrentUserClaim("Id"));
        }

        private bool IsCanDelete(int creatorId)
        {
            bool canDelete = GetCurrentUserClaim("Id") == creatorId.ToString();
            return canDelete = GetCurrentUserClaim("IsAdmin") == "True" ? true : canDelete;
        }

        private List<dynamic> GetHighPraiseParties(int page, int limit)
        {
            string sql = $@"SELECT *
                            FROM parties
                            ORDER BY LikeLevel DESC
                            LIMIT {limit * (page - 1)},{limit}";

            var parties = m_database.QueryListSQL<dynamic>(sql).ToList();
            return parties;
        }

        private List<dynamic> GetAllParties(int page, int limit)
        {
            string sql = $@"SELECT * FROM parties  ORDER BY EndTime DESC LIMIT {limit * (page - 1)},{limit}";
            var parties = m_database.QueryListSQL<dynamic>(sql).ToList();
            return parties;
        }

        private List<dynamic> GetMostTimeParties(int page, int limit)
        {
            string sql = $@"SELECT *,COUNT(PartyPlace) AS MostTime
                            FROM parties
                            GROUP BY PartyPlace
                            ORDER BY MostTime DESC
                            LIMIT {limit * (page - 1)},{limit}";

            var parties = m_database.QueryListSQL<dynamic>(sql).ToList();
            return parties;
        }

        [HttpPost]
        public JsonResult InsertPartyImg(PartyImgModel picturesModel)
        {
            var effectCount = false;
            var memberId = GetCurrentUserClaim("Id");
            if (string.IsNullOrEmpty(memberId))
            {
                return Json(new { Result = false, Msg = "请先登录" });
            }
            if (string.IsNullOrEmpty(picturesModel.ImgUrl))
            {
                return Json(new { Result = false, Msg = "请上传图片" });
            }
            if (string.IsNullOrEmpty(picturesModel.ImgDescription) || picturesModel.ImgDescription.Length > 40)
            {
                return Json(new { Result = false, Msg = "描述不能为空,且不能超过40个字" });
            }
            var imgUrlResult = PictureHelper.UploadPicture("FileUpload", picturesModel.ImgUrl, m_configuration, m_environment);
            var additionalInformation = imgUrlResult.Item2;
            if (imgUrlResult.Item1 == null)
            {
                return Json(new { Result = false, Msg = $@"{additionalInformation},请通知管理员查看！" });
            }
            effectCount = m_database.InsertSQL($@"partyphotos",
            new DataColumn("ImgUrl", imgUrlResult.Item1), new DataColumn("ImgDescription", picturesModel.ImgDescription),
            new DataColumn("ImgUrlPart", additionalInformation), new DataColumn("PartyId", picturesModel.PartyId));
            m_database.InsertSQL($@"Pictures", new DataColumn("Url", imgUrlResult.Item1),
            new DataColumn("PartialPictureUrl", additionalInformation), new DataColumn("Description", picturesModel.ImgDescription),
            new DataColumn("UpdatedTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")), new DataColumn("MemberId", memberId));
            return Json(new { Result = effectCount, Msg = "" });
        }
    }
}