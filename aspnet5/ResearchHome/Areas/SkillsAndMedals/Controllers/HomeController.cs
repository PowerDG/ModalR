using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ResearchHome.Areas.SkillsAndMedals.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.SkillsAndMedals.Controllers
{
    [Area("SkillsAndMedals")]
    [AuthorizeFilter]
    public class HomeController : BaseController
    {
        private readonly IDatabase database;
        private IHostingEnvironment environment;
        private readonly IConfiguration configuration;

        public HomeController(IDatabase database, IHostingEnvironment hostingEnvironment, IConfiguration configuration)
        {
            this.database = database;
            this.environment = hostingEnvironment;
            this.configuration = configuration;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult MedaledMemberTable()
        {
            return View();
        }

        public IActionResult EditSkills(int id)
        {
            //TODO:待优化
            var skill = database.QuerySQL<Skills>($"SELECT * FROM skills WHERE id = {id}");
            if (skill != null)
            {
                skill.Parent = database.QuerySQL<Skills>($"SELECT * FROM skills WHERE id = {skill.ParentId}");
            }
            return View(skill);
        }

        public IActionResult AddSkills(int id)
        {
            var skill = database.QuerySQL<Skills>($"SELECT * FROM skills WHERE id = {id}");
            return View(skill);
        }

        public JsonResult GetDescription(string path)
        {
            var urlPath = $"{environment.WebRootPath}{configuration[$"Paths:{path}"]}";
            var introductionXmlInfo = XmlHelper.ReadXmlData(urlPath);
            return Json(new { title = introductionXmlInfo.Title, content = introductionXmlInfo.Content });
        }

        public IActionResult EditDescription(string id)
        {
            ViewBag.Id = id;
            var urlPath = $"{environment.WebRootPath}{configuration[$"Paths:{id}"]}";
            var introductionXmlInfo = XmlHelper.ReadXmlData(urlPath);
            return View(introductionXmlInfo);
        }

        [HttpPost]
        public JsonResult SaveDescription(string id, Introduction.Models.IntroductionsModel model)
        {
            var urlPath = $"{environment.WebRootPath}{configuration[$"Paths:{id}"]}";
            var result = XmlHelper.WriteXmlData("Introduction", urlPath, model, out string errorMsg);
            return Json(new { success = result, message = result ? "操作成功" : $@"操作失败【{errorMsg}】" });
        }

        public IActionResult MedalList()
        {
            string sql = "SELECT * FROM medals WHERE  IsDiscard = 0";
            var medals = database.QueryListSQL<Medals>(sql);
            return PartialView(medals);
        }

        public JsonResult List()
        {
            string sql = @"SELECT Id,Icon, Name, Description,medal_count.Count,IsDiscard,CreatedTime, DiscardTime,Grade
                            FROM medals LEFT JOIN (SELECT MedalId, COUNT(1) as Count FROM MemberMedals LEFT JOIN Members
                                ON MemberMedals.MemberId = members.Id
                                WHERE IsLeave = 0 GROUP BY MedalId) as medal_count ON medal_count.MedalId = medals.Id
                            WHERE IsDiscard = 0 ORDER BY CreatedTime DESC";
            var medals = database.QueryListSQL<Medals>(sql).ToList();

            foreach (var medal in medals)
            {
                medal.Grade = NumberHelper.NumberToChinese(medal.Grade);
            }
            return Json(medals);
        }

        public JsonResult DiscardMedalList()
        {
            string sql = "SELECT * FROM medals WHERE  IsDiscard = 1  ORDER BY DiscardTime DESC";
            var medals = database.QueryListSQL<Medals>(sql);
            return Json(medals);
        }

        public IActionResult EditMedal(int id)
        {
            var medal = database.QuerySQL<Medals>($"SELECT * FROM medals WHERE id = {id}");
            return View(medal);
        }

        public async Task<JsonResult> GetSkills()
        {
            List<Skills> all = new List<Skills>();
            var skills = await GetSkills(null, null);
            Skills skill = database.Single<Skills>("SELECT * FROM skills WHERE parentId = 0");
            skill.Childs = skills;
            all.Add(skill);
            return Json(all);
        }

        public async Task<JsonResult> GetSkillsData()
        {
            List<Skills> skills = await GetSkills(null, null);
            Skills skill = new Skills();
            skill = database.Single<Skills>("SELECT * FROM skills WHERE parentId = 0");
            skill.Childs = skills;
            return Json(skill);
        }

        private async Task<List<Skills>> GetSkills(List<Skills> skills = null, Skills skill = null)
        {
            List<Skills> childs = new List<Skills>();
            if (skills == null)
            {
                var all = await database.QueryList<Skills>();
                skills = all.ToList();
                childs = skills.Where(s => s.ParentId == 1).ToList();
            }
            else
            {
                childs = skills.Where(s => s.ParentId == skill.Id).ToList();
            }
            List<Skills> result = new List<Skills>();
            foreach (var child in childs)
            {
                Skills s = new Skills()
                {
                    Id = child.Id,
                    ParentId = child.ParentId,
                    Name = child.Name,
                    Level = child.Level,
                    Childs = await GetSkills(skills, child)
                };
                result.Add(s);
            }
            return result;
        }

        [HttpPost]
        public async Task<JsonResult> EditSkills(Skills skill)
        {
            bool result = false;
            var isExist = await IsExistSkillName(skill);
            if (isExist)
            {
                return Json(new { success = false, message = "技能已存在" });
            }
            if (skill.Id > 0)
            {
                result = await database.UpdateAsync(skill);
            }
            else
            {
                result = await database.CreateAsync(skill) > 0;
            }
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }

        [HttpPost]
        public async Task<JsonResult> AddSkills(Skills skill)
        {
            var isExist = await IsExistSkillName(skill);
            if (isExist)
            {
                return Json(new { success = false, message = "技能已存在" });
            }
            skill.CreatedTime = DateTime.Now;
            bool result = await database.CreateAsync(skill) > 0;
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }

        private async Task<bool> IsExistSkillName(Skills skill)
        {
            string sql = $"SELECT COUNT(*) FROM skills WHERE Name = '{skill.Name}' AND Id != {skill.Id}";
            var count = await database.ExecuteScalarAsync(sql);
            if (Convert.ToInt32(count) > 0)
            {
                return true;
            }
            return false;
        }

        public JsonResult DeleteSkills(int id)
        {
            bool result = false;
            var skill = database.QuerySQL<Skills>($"SELECT * FROM Skills WHERE Id = {id}");
            var idList = new List<int>();//需要删除的技能id
            if (skill.Level == 1)
            {
                return Json(new { success = false, message = "顶级节点不可删除" });
            }
            else if (skill.Level == 2)
            {
                string query = $"SELECT Id FROM skills WHERE ParentId = {id}";
                idList = database.QueryListSQL<Skills>(query).Select(s => s.Id).ToList();
            }
            else
            {
                idList.Add(id);
            }
            result = database.RunInTransaction(() =>
            {
                if (idList.Count > 0)
                {
                    System.Text.StringBuilder str = new System.Text.StringBuilder();
                    foreach (int t in idList)
                    {
                        str.Append(t + ",");
                    }
                    str = str.Remove(str.Length - 1, 1);
                    database.ExecuteSQL($"DELETE FROM memberskills WHERE SkillId in ({str})");
                }
                bool deleteSkillResult = database.ExecuteSQL($"DELETE FROM skills WHERE Id = {id} or ParentId = {id}");
                if (!deleteSkillResult)
                {
                    throw new Exception("事务执行失败");
                }
            });
            return Json(new { success = result, message = result ? "删除成功" : "删除失败" });
        }

        [HttpPost]
        public async Task<JsonResult> EditMedal(Medals medal)
        {
            if (!string.IsNullOrEmpty(medal.Icon))
            {
                var photoName = PictureHelper.UploadOriginPicture("MedalIconPath", medal.Icon, configuration, environment);
                medal.Icon = photoName;
            }
            bool result = false;
            if (medal.Id > 0)
            {
                //string sqlStr = $"SELECT Icon FROM medals WHERE Id = {medal.Id}";
                //dynamic oldMedal = database.Single<dynamic>(sqlStr);

                System.Text.StringBuilder sql = new System.Text.StringBuilder($"UPDATE medals SET Name = '{medal.Name}',Grade={medal.Grade}, Description = '{medal.Description}' ");
                if (!string.IsNullOrEmpty(medal.Icon))
                {
                    sql.Append($" ,Icon = '{medal.Icon}' ");
                }
                sql.Append($" WHERE Id = {medal.Id}");
                result = database.ExecuteSQL(sql.ToString());
                //删除旧勋章图片
                if (!string.IsNullOrEmpty(medal.Icon) && result)
                {
                    PictureHelper.DeletePicture($"{environment.WebRootPath}{medal.CurrentPath}");
                }
            }
            else
            {
                medal.CreatedTime = DateTime.Now;
                result = await database.CreateAsync(medal) > 0;
            }
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }

        [HttpPost]
        public JsonResult DeleteMedal(int id)
        {
            bool result = false;
            string sql = $"DELETE  FROM membermedals    WHERE   membermedals.MedalId =   { id}";
            result = database.ExecuteSQL(sql);
            if (result)
            {
                sql = $"DELETE FROM medals WHERE Id = {id}";
                result = database.ExecuteSQL(sql);
            }
            return Json(new { success = result, message = result ? "删除成功" : "删除失败" });
        }

        [HttpPost]
        public JsonResult GetMedaledMemberTableData(int page, int limit, int medalId, string sortField, string sortType)
        {
            var sqlStr = $@"SELECT Members.Name,MemberMedals.GainDate,MemberMedals.Reason FROM MemberMedals
                            LEFT JOIN Members
                            ON MemberMedals.MemberId = members.Id
                             WHERE MedalId = {medalId} AND IsLeave=0
                            ORDER BY  {sortField} {sortType} LIMIT {limit * (page - 1)},{limit}";
            var sqlCountStr = $@"SELECT COUNT(1) FROM MemberMedals
                            LEFT JOIN Members
                            ON MemberMedals.MemberId = members.Id
                             WHERE IsLeave=0 AND MedalId = {medalId}";
            var result = database.QueryListSQL<dynamic>(sqlStr);
            var resultCount = database.QuerySQL<int>(sqlCountStr);
            return Json(new PageResponse(result, resultCount));
        }

        [HttpPost]
        public JsonResult DiscardMedal(int id)
        {
            bool result = false;
            string sql = $"UPDATE medals SET IsDiscard = 1, DiscardTime = '{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}' WHERE Id = {id}";
            result = database.ExecuteSQL(sql);
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }
    }
}