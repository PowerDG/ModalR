using Dapper;
using ResearchHome.Areas.Book.Models;
using ResearchHome.Areas.Introduction.Models;

namespace ResearchHome.Helper
{
    public class ColumnMapper
    {
        public static void SetMapper()
        {
            //由于数据库规范和c#规范不一致，所以手动添加（数据库字段-model属性）映射关系
            SqlMapper.SetTypeMap(typeof(ReadBooks), new ColumnAttributeTypeMapper<ReadBooks>());
            SqlMapper.SetTypeMap(typeof(BookModel), new ColumnAttributeTypeMapper<BookModel>());

        }
    }
}
