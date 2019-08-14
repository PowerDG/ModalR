using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Abp.AspNetCore.Mvc.Controllers;
using Abp.Domain.Repositories;
using BookService.Host.Domain;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;

//using Abp.AutoMapper;
using AutoMapper;
using Abp.Domain.Uow;

namespace BookService.Host.Controllers

{
    [Route("api/[Controller]")]
    //    [Route("api/[controller]")]
    //    [ApiController]
    public class AfficheInfoController : AbpController
    {
        private readonly IRepository<AfficheInfo, int> _AfficheRepository;

        public AfficheInfoController(IRepository<AfficheInfo, int> afficheRepository)
        {
            _AfficheRepository = afficheRepository;
        }

        [HttpPost("Create")]
        public void CreateMission(AfficheDto input)
        {
            var task = Mapper.Map<AfficheInfo>(input);
            task.Id = null;
            //if (task != null)
            //{ var result = _AfficheRepository.Insert(task); }

            _AfficheRepository.Insert(task);
        }

        [HttpPost("CreateQ")]
        [UnitOfWork]
        public int? CreateMissionQ(AfficheDto input)
        {
            var task = Mapper.Map<AfficheInfo>(input);
            task.Id = null;
            if (task != null)
            {
                var result = _AfficheRepository.Insert(task);
                CurrentUnitOfWork.SaveChanges();

                return result.Id;
            }
            else
            { return 0; }
        }

        [HttpPut("Update")]
        public void UpdateMission(AfficheDto input)
        {
            // var task = _AfficheRepository.GetAll().FirstOrDefault(t => t.CargoID == input.CargoID);
            var result = Mapper.Map<AfficheInfo>(input);

            if (result != null)
            { _AfficheRepository.Update(result); }
        }

        [HttpDelete("Delete")]
        public void DeleteMission(int taskId)
        {
            var task = _AfficheRepository.FirstOrDefault(t => t.Id == taskId);
            if (task != null)
            { _AfficheRepository.Delete(task); }
        }

        //public PagedResultDto<AfficheDto> GetPagedAfficheInfos(SearchAfficheInput input)
        //{
        //    //初步过滤
        //    var query = _AfficheRepository.GetAll().OrderByDescending(t => t.CreationTime).ToList();
        //    //.WhereIf(input.BranchID.HasValue, t => t.BranchID == input.BranchID.Value)
        //    //.WhereIf(!input.CargoName.IsNullOrEmpty(), t => t.CargoName.Contains(input.CargoName));
        //    //排序
        //    //query = !string.IsNullOrEmpty(input.Sorting) ? query.OrderBy(input.Sorting) : query.OrderByDescending(t => t.CreationTime);
        //    // query= query.ToList();
        //    //获取总数
        //    var tasksCount = query.Count;
        //    //默认的分页方式 source.Skip(pageIndex * pageSize).Take(pageSize).ToList();
        //    var taskList = query.Skip((input.pageIndex - 1) * input.pageSize).Take(input.pageSize).ToList();
        //    //ABP提供了扩展方法PageBy分页方式
        //    //var taskList = query.PageBy(input).ToList();
        //    return new PagedResultDto<AfficheDto>(tasksCount, taskList.MapTo<List<AfficheDto>>());
        //}

        [HttpGet("GetPaged")]
        public IList<AfficheDto> GetAllMissions()
        {
            var task = _AfficheRepository.GetAll().OrderByDescending(t => t.Id).ToList();
            return Mapper.Map<List<AfficheDto>>(task);
        }

        [HttpGet("Get")]
        public AfficheDto GetMissionById(int taskId)
        {
            var task = _AfficheRepository.FirstOrDefault(t => t.Id == taskId);
            var result = Mapper.Map<AfficheDto>(task);
            //if (task != null)
            //{ return result; }
            //else
            //{ //throw new NotImplementedException();
            //}
            return result;
        }
    }
}