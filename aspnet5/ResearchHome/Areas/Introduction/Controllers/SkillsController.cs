using Microsoft.AspNetCore.Mvc;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.Areas.SkillsAndMedals.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Text;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public class SkillsController : BaseController
    {
        private readonly IDatabase database;
        public SkillsController(IDatabase database)
        {
            this.database = database;
        }

        public IActionResult EditSkill(int memberId)
        {
            ViewBag.MemberId = memberId;
            return View();
        }

        [HttpPost]
        public JsonResult SaveSkill(int[] ids, int memberId)
        {
            string queryExist = $"SELECT * FROM memberskills WHERE MemberId = {memberId}";
            var esistSkills = database.QueryListSQL<MemberSkills>(queryExist).Select(s => s.SkillId);
            var except = esistSkills.Except(ids);//数据库里存在，本次未选中，需要删除
            var exist = esistSkills.Intersect(ids);//数据库已存在，本次已选中，不做操作
            var newids = ids.Except(exist);//数据库不存在，本次已选中，需添加

            StringBuilder deleteSql = new StringBuilder();
            if (except.Count() > 0)
            {
                deleteSql.Append($"DELETE FROM memberskills WHERE MemberId = {memberId} AND SkillId IN ( ");
                foreach (var o in except)
                {
                    deleteSql.Append($"{o},");
                }
                deleteSql.Remove(deleteSql.Length - 1, 1).Append(")");
            }

            StringBuilder insertSql = new StringBuilder();
            if (newids.Count() > 0)
            {
                insertSql.Append("INSERT INTO memberskills (SkillId, MemberId, GainDate) VALUES ");
                foreach (int id in newids)
                {
                    insertSql.Append($"({id},{memberId},'{DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")}'),");
                }
                insertSql.Remove(insertSql.Length - 1, 1);
            }

            bool result = database.RunInTransaction(() =>
            {
                if (!string.IsNullOrEmpty(deleteSql.ToString()))
                {
                    database.TransactionExecuteSQL(deleteSql.ToString());
                }
                if (!string.IsNullOrEmpty(insertSql.ToString()))
                {
                    database.TransactionExecuteSQL(insertSql.ToString());
                }
            });
            return Json(new { success = result, message = result ? "授予成功" : "操作失败" });
        }

        public async Task<JsonResult> GetSkillTreeData(int memberId)
        {
            string queryExist = $"SELECT * FROM memberskills WHERE MemberId = {memberId}";
            var esistSkills = database.QueryListSQL<MemberSkills>(queryExist).Select(s => s.SkillId).ToList();
            List<SkillTree> skills = await GetTreeData(esistSkills, null, null);
            return Json(skills);
        }

        private async Task<List<SkillTree>> GetTreeData(List<int> esistSkills, List<SkillTree> skills = null, SkillTree skill = null)
        {
            List<SkillTree> childs = new List<SkillTree>();
            if (skills == null)
            {
                skills = GetSkillTree();
                childs = skills.Where(s => s.ParentId == 1).ToList();
            }
            else
            {
                childs = skills.Where(s => s.ParentId == skill.Value).ToList();
            }
            List<SkillTree> result = new List<SkillTree>();
            foreach (var child in childs)
            {
                SkillTree s = new SkillTree();
                s.ParentId = child.ParentId;
                s.Title = child.Title;
                s.Value = child.Value;
                if(esistSkills.Count > 0)
                {
                    s.Checked = esistSkills.Exists(t => t == child.Value) ? true : false;
                }
                s.Data = await GetTreeData(esistSkills, skills, child);
                result.Add(s);
            }
            return result;
        }

        private List<SkillTree> GetSkillTree()
        {
            return database.QueryListSQL<SkillTree>("SELECT Id as Value, Name as Title, ParentId FROM skills").ToList();
        }


        public async Task<JsonResult> GetMemberSkills(int id)
        {
            //TODO:待优化-li
            string sql = $"SELECT * FROM memberskills WHERE memberId = {id}";
            var queryMemberSkills = database.QueryListSQL<MemberSkills>(sql);
            List<MemberSkills> memberSkills = queryMemberSkills.ToList();
            if (memberSkills == null || memberSkills.Count == 0)
            {
                return Json(null);
            }
            var queryAllSkill = await database.QueryList<Skills>();
            List<Skills> allSkills = queryAllSkill.ToList();
            List<Skills> mSkills = new List<Skills>();
            foreach (var memberSkill in memberSkills)
            {
                var skill = allSkills.SingleOrDefault(s => s.Id == memberSkill.SkillId);
                skill.MemberSkillsId = memberSkill.Id;
                skill.GainDate = memberSkill.GainDate;
                skill.MemberId = memberSkill.MemberId;
                var parent = GetSkills(allSkills, skill);
                if (!mSkills.Exists(s => s.Id == parent.Id))
                {
                    mSkills.Add(parent);
                }
            }
            var result = allSkills.SingleOrDefault(s => s.ParentId == 0);
            result.Childs = mSkills;
            var data = new { skillCount = memberSkills.Count, skills = result };
            return Json(data);
        }

        private Skills GetSkills(List<Skills> skills, Skills skill)
        {
            var parent = skills.SingleOrDefault(s => s.Id == skill.ParentId);
            if (parent != null)
            {
                if (parent.Childs == null) parent.Childs = new List<Skills>();
                parent.Childs.Add(skill);
                GetSkills(skills, parent);
            }
            return parent;
        }
    }
}
