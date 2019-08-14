using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ResearchHome.Areas.Book.Models;
using ResearchHome.Areas.Introduction.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.Introduction.Controllers
{
    [Area("Introduction")]
    public class ReadBooksController : BaseController
    {
        private readonly IDatabase database;
        private IHostingEnvironment environment;
        private readonly IConfiguration configuration;

        public ReadBooksController(IDatabase database, IHostingEnvironment hostingEnvironment, IConfiguration configuration)
        {
            this.database = database;
            this.environment = hostingEnvironment;
            this.configuration = configuration;
        }

        public async Task<JsonResult> GetReadBooks(int memberId, int page, int limit)
        {
            string sql = $@"SELECT book_comment.id AS Id,book.`Name` AS Name,book.Photo,book.PhotoHD,book.Author,
                        book_comment.create_time ,book_comment.member_id AS MemberId,book_comment.`comment` AS Commentary
                         FROM book_comment,book WHERE member_id ={memberId} AND book_comment.book_id=book.Id
                          ORDER BY create_time DESC LIMIT {(page - 1) * limit}, {limit}";
            var records = database.QueryListSQL<ReadBooks>(sql).ToList();
            string sqlCount = $"SELECT COUNT(*) AS Count FROM book_comment WHERE member_id= {memberId}";
            var count = await database.ExecuteScalarAsync(sqlCount);
            return Json(new { code = 0, msg = "查询成功", count, data = records });
        } 
        public int IsAdminClaim(string memberId)
        {
            string sql = $@"SELECT  IsAdmin FROM members WHERE id= {memberId}";
            var isAdmin = database.Single<int>(sql);
            return isAdmin;
        }

        [HttpPost]
        public async Task<JsonResult> CommentExtraBook(BookModel book)
        {
            int score = 5;
            int? bookId = 0;

            #region AddBookExtra

            bool result = false;
            if (!string.IsNullOrEmpty(book.Photo))
            {
                var photo = PictureHelper.UploadPicture("FileUpload", book.Photo, configuration, environment);
                book.Photo = photo.Item2;
                book.PhotoHD = photo.Item1;
            }
            var memberId = GetCurrentUserClaim("Id");
            if (book.Id > 0)
            {
                result = EditReadBook(book, memberId, out int book_Id);
                bookId = book_Id;
            }
            else
            {
                bookId = await AddReadBookAsync(book, memberId);
                result = bookId != 0;
            }
            if (!result)
            {
                return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
            }

            #endregion AddBookExtra

            book.Id = bookId.Value;
            result = CommentWithoutScore(book, score);
            return Json(new { success = result, message = result ? "操作成功" : "操作失败" });
        }
 
        public bool CommentWithoutScore(BookModel book, int score)
        {
            int book_Id = book.Id;
            bool result = false; 
            string bookSql   = $@"UPDATE book_comment SET comment ='{book.LastComment}'  WHERE book_id={book_Id}";
            result = database.ExecuteSQL(bookSql); 
            return result;
        }

        public IActionResult EditReadBook(int memberId, int bookId)
        {
            string sql = $@"SELECT * FROM book WHERE book.Id=
                        ( SELECT book_id FROM book_comment
                        WHERE book_comment.member_id= {memberId}
                          AND book_comment.id={bookId}
                        )";
            var book = database.Single<BookModel>(sql);
            return View(book);
        }

        public bool CanEditBook(BookModel book, string memberId, out int bookId)
        {
            string sql = $@"SELECT * FROM book WHERE book.Id=
                        ( SELECT book_id FROM book_comment WHERE book_comment.member_id= {memberId}
                          AND   book_comment.book_id={book.Id} ORDER BY book_comment.modified_time  LIMIT 1
                        )";
            var _book = database.Single<BookModel>(sql);
            bookId = _book != null ? _book.Id : 0;
            if (_book == null || _book.State != AppConsts.BookType_CommentExtra)
            {
                return false;
            }
            return true;
        }

        [HttpPost]
        public bool EditReadBook(BookModel book, string memberId, out int bookId)
        {
            bool result;
            if (!(result = CanEditBook(book, memberId, out bookId)))
            {
                return result;
            }
            System.Text.StringBuilder m_sql = new System.Text.StringBuilder(
                    $"UPDATE book SET Name = '{book.Name}', Author = '{book.Author}', last_comment = '{book.LastComment}'");
            if (!string.IsNullOrEmpty(book.Photo))
            {
                m_sql.Append($", Photo = '{book.Photo}', PhotoHD = '{book.PhotoHD}'");
            }
            m_sql.Append($" WHERE Id = {book.Id}");
            result = database.ExecuteSQL(m_sql.ToString()); 
            return result;
        }

        public async Task<int> AddReadBookAsync(BookModel book, string memberId)
        {
            bool result = false;
            book.CreateTime = DateTime.Now;
            book.State = AppConsts.BookType_CommentExtra;
            var m_readBookId = await database.CreateAsync<BookModel>(book);
            int m_bookId = m_readBookId != null ? m_readBookId.Value : 0; 
            if (!(m_bookId > 0))
            {
                return 0;
            } 
            #region AddCommnet 
            book.LastComment = String.IsNullOrWhiteSpace(book.LastComment) ?
                "默认好评" : book.LastComment;
            string submitComment = $@"INSERT INTO book_comment SET book_id={m_bookId},member_id={memberId},
                                                               comment='{ book.LastComment}',score={5}";
            result = database.ExecuteSQL(submitComment); 
            #endregion AddCommnet 
            return result ? m_bookId : 0;
        }

        [HttpPost]
        public JsonResult DeleteBook(int id)
        {
            bool result = false;
            var memberId = GetCurrentUserClaim("Id");
            var isAdmin = IsAdminClaim(memberId);
            string sql = $@"SELECT * FROM book WHERE book.Id=
                        ( SELECT 	book_id FROM book_comment
                        WHERE (	book_comment.member_id= {memberId} or {isAdmin} =1)
                          AND   book_comment.id={id}
                        )";
            var book = database.Single<BookModel>(sql);
            if (book == null || book.State != AppConsts.BookType_CommentExtra)
            {
                return Json(new { success = result, message = "您无权删除该书评" });
            }
            sql = $@"DELETE FROM book
	                        WHERE book.Id={book.Id}"; 
            if (!database.ExecuteSQL(sql))
            {
                return Json(new { success = result, message = "操作失败" });
            }
            sql = $@"DELETE FROM book_comment
                        WHERE  book_comment.id= {id}";
            result = database.ExecuteSQL(sql);
            return Json(new { success = result, message = result ? "删除成功" : "删除失败" });
        }
    }
}