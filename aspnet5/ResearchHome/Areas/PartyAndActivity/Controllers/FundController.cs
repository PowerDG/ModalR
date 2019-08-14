using Microsoft.AspNetCore.Mvc;
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
    public class FundController : BaseController
    {
        private readonly IDatabase m_database;

        public FundController(IDatabase database)
        {
            m_database = database;
        }

        public IActionResult CreateFund(int? fundId)
        {
            if (fundId != null)
            {
                string fundSql = $@"SELECT * FROM fund WHERE Id={fundId}";
                var fund = m_database.Single<FundModel>(fundSql);
                FundModel fundModel = fund;
                return View(fundModel);
            }
            return View(new FundModel());
        }

        [HttpPost]
        public JsonResult CreateFund(FundModel request)
        {
            bool result = false;
            decimal? remainMoney = 0;
            string remainMoneySql = $@"SELECT RemainMoney FROM fund  ORDER BY InsertTime DESC LIMIT 1";
            remainMoney = m_database.Single<decimal>(remainMoneySql);
            string msg = "";
            if (!RequestVertify(request, out msg))
            {
                return Json(new { Result=result, Msg=msg });
            }
            remainMoney += request.OperatMoney;

            if (request.Id > 0)
            {
                string updateSql = $@"UPDATE Fund SET Description='{request.Description}',ItemName='{request.ItemName}'
                                      WHERE Id ={request.Id}";
                result = m_database.ExecuteSQL(updateSql);
            }
            else
            {
                string memberId = GetCurrentUserClaim("Id");
                result = m_database.TransactionInsertSQL("Fund", new DataColumn("InsertTime", DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")),
                                                new DataColumn("Description", request.Description),
                                                new DataColumn("ItemName", request.ItemName),
                                                new DataColumn("OperatMoney", request.OperatMoney),
                                                new DataColumn("RemainMoney", remainMoney), new DataColumn("MemberId", memberId));
            }
            return Json(new { Result=result });
        }

        private bool RequestVertify(FundModel request, out string msg)
        {
            msg = "";
            if (request.ItemName == null || request.ItemName.Length > 24)
            {
                msg = "请输入恰当简短的描述 !";
                return false;
            }
            if (!(request.OperatMoney < 1000000 && request.OperatMoney > -100000))
            {
                msg = "确定有这么多钱?！";
                return false;
            }
            if (request.Description != null && request.Description.Length > 250)
            {
                msg = "备注太长了哦！";
                return false;
            }
            return true;
        }

        [HttpPost]
        public JsonResult DeleteFund(int fundId)
        {
            string deletePartySql = $@"DELETE FROM fund WHERE Id={fundId}";
            bool result = m_database.ExecuteSQL(deletePartySql);
            return Json(new { Result=result });
        }

        public JsonResult GetFunds(int page, int limit, string queryType)
        {
            var funds = new List<dynamic>();
            int resultCount = 0;
            List<dynamic> result = new List<dynamic>();
            switch (queryType)
            {
                case "thisYearFunds":
                    funds = GetThisYearFunds(page, limit, out resultCount);
                    break;

                default:
                    funds = GetAllFunds(page, limit, out resultCount);
                    break;
            }
            if (resultCount == 0)
            {
                return Json(new PageResponse(result, resultCount));
            }
            GeneratefundsResponse(funds, ref result);

            return Json(new PageResponse(result, resultCount));
        }

        private void GeneratefundsResponse(List<dynamic> funds, ref List<dynamic> result)
        {
            foreach (var fund in funds)
            {
                bool canOperat = GetCurrentUserClaim("IsAdmin") == "True" ? true : false;
                result.Add(new
                {
                    fund.Id,
                    fund.Name,
                    fund.ItemName,
                    fund.Description,
                    fund.OperatMoney,
                    fund.RemainMoney,
                    fund.InsertTime,
                    canOperat
                });
            }
        }

        private List<dynamic> GetThisYearFunds(int page, int limit, out int fundsCount)
        {
            string sql = $@"SELECT fund.Id,fund.Description,fund.InsertTime,fund.ItemName,fund.OperatMoney,
                                   fund.RemainMoney,members.`Name` FROM fund
                            LEFT JOIN members ON fund.MemberId=members.Id
                            WHERE YEAR(InsertTime)=YEAR(NOW())
                            ORDER BY fund.InsertTime DESC
                            LIMIT {limit * (page - 1)},{limit}";

            var funds = m_database.QueryListSQL<dynamic>(sql).ToList();
            string sqlCount = $@"SELECT COUNT(*) FROM fund WHERE YEAR(InsertTime)=YEAR(NOW())";
            fundsCount = m_database.QuerySQL<int>(sqlCount);

            return funds;
        }

        private List<dynamic> GetAllFunds(int page, int limit, out int fundsCount)
        {
            string sql = $@"SELECT fund.Id,fund.Description,fund.InsertTime,fund.ItemName,fund.OperatMoney,
                            fund.RemainMoney,members.Name AS Name FROM fund
                            LEFT JOIN members ON fund.MemberId=members.Id
                            ORDER BY fund.InsertTime DESC
                            LIMIT {limit * (page - 1)},{limit}";
            var funds = m_database.QueryListSQL<dynamic>(sql).ToList();

            string sqlCount = $@"SELECT COUNT(*) FROM fund";
            fundsCount = m_database.QuerySQL<int>(sqlCount);

            return funds;
        }
    }
}