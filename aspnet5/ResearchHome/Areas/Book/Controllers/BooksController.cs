using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using ResearchHome.Areas.Book.Models;
using ResearchHome.Controllers;
using ResearchHome.DataBase;
using ResearchHome.Helper;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ResearchHome.Areas.Book.Controllers
{
    [Area("Book")]
    public class BooksController : BaseController
    {
        private readonly IDatabase m_database;
        private IHostingEnvironment m_environment;
        private readonly IConfiguration m_configuration;

        public BooksController(IDatabase database, IHostingEnvironment hostingEnvironment, IConfiguration configuration)
        {
            m_database = database;
            m_environment = hostingEnvironment;
            m_configuration = configuration;
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult EditBook(int bookId)
        {
            string bookSql = $@"SELECT Id,Name,Photo,PhotoHD,Author,create_time,average_score,last_comment,state,MemberId,
                                        resource   FROM book WHERE Id={bookId}";
            var book = m_database.Single<BookModel>(bookSql);
            return View(book);
        }

        public IActionResult CommentBook(int bookId)
        {
            ViewBag.bookId = bookId;
            return View();
        }

        [HttpPost]
        public JsonResult CommentBook(int bookId, string comment, int score)
        {
            if (comment.Length < 1 || score < 1)
            {
                return Json(new { result = false, msg = "一点评价都没有，你确定读过了？" });
            }
            var memberId = GetCurrentUserClaim("Id");
            string submitComment = $@"INSERT INTO book_comment SET book_id={bookId},member_id={memberId},
                                                               comment='{comment}',score={score}";
            bool result = m_database.ExecuteSQL(submitComment);

            if (result)
            {    
                string scoreSql = $@"SELECT score FROM book_comment WHERE book_id={bookId}";
                List<dynamic> scores = m_database.QueryListSQL<dynamic>(scoreSql).ToList();
                int totalScore = 0;

                foreach (var itemscore in scores)
                {
                    totalScore += itemscore.score;
                }
                score = (totalScore + score) / (scores.Count + 1);
                string bookSql = $@"UPDATE book SET last_comment='{comment}',average_score={score},
                                                state=0,MemberId=0 WHERE Id={bookId}";
                result = m_database.ExecuteSQL(bookSql);
            }

            return Json(new { Result=result });
        }

        public IActionResult AddBook()
        {
            return View(new BookModel());
        }

        [HttpPost]
        public async Task<JsonResult> AddBook(BookModel book)
        {
            bool result = false;
            if (!ModelState.IsValid)
            {
                return Json(new { result, msg = "请填写正确的信息！" });
            }
            if (!string.IsNullOrEmpty(book.Photo))
            {
                var photo = PictureHelper.UploadPicture("FileUpload", book.Photo, m_configuration, m_environment);
                book.Photo = photo.Item2;
                book.PhotoHD = photo.Item1;
            }
            if (book.Id > 0)
            {
                System.Text.StringBuilder sql = new System.Text.StringBuilder(
                               $"UPDATE book SET Name = '{book.Name}', Author = '{book.Author}', resource = '{book.Resource}' ");
                if (!string.IsNullOrEmpty(book.Photo))
                {
                    sql.Append($", Photo = '{book.Photo}', PhotoHD = '{book.PhotoHD}'");
                }
                sql.Append($" WHERE Id = {book.Id}");
                result = m_database.ExecuteSQL(sql.ToString());
            }
            else
            {
                book.CreateTime = DateTime.Now;
                result = await m_database.CreateAsync<BookModel>(book) > 0;
            }
            return Json(new { Result=result, Msg="成功" });
        }

        [HttpPost]
        public JsonResult GetReadingBookMember(int memberId)
        {
            string readBookSql = $@"SELECT Photo FROM members WHERE Id={memberId}";
            string photo = m_database.Single<string>(readBookSql);
            return Json(new { Photo=photo });
        }

        [HttpPost]
        public JsonResult GetReadBookMembers(int bookId)
        {
            string readBookSql = $@"SELECT Photo FROM members
                                    WHERE members.Id in (SELECT DISTINCT member_id FROM book_comment WHERE book_id={bookId})";
            List<dynamic> photos = m_database.QueryListSQL<dynamic>(readBookSql).ToList();
            return Json(new { Photos=photos });
        }

        [HttpPost]
        public JsonResult GetBookComments(int bookId)
        {
            string bookSql = $@"SELECT member_id,book_comment.create_time,score,`comment`,members.`Name` FROM book_comment
                                    LEFT JOIN members ON member_id=members.Id WHERE book_id={bookId}";
            List<dynamic> comments = m_database.QueryListSQL<dynamic>(bookSql).ToList();
            return Json(new { Comments=comments });
        }

        public JsonResult GetBookCommentsTable(int bookId, int page, int limit)
        {
            string bookSql = $@"SELECT member_id,book_comment.create_time,score,`comment`,members.`Name` FROM book_comment
                                    LEFT JOIN members ON member_id=members.Id WHERE book_id={bookId}
                                    ORDER BY book_comment.create_time DESC LIMIT {limit * (page - 1)},{limit}";
            List<dynamic> comments = m_database.QueryListSQL<dynamic>(bookSql).ToList();

            string countSql = $@"SELECT count(*) FROM book_comment WHERE book_id={bookId}";
            int commentsCount = m_database.Single<int>(countSql);
            return Json(new PageResponse(comments, commentsCount));
        }

        [HttpPost]
        public JsonResult LostBook(int bookId, string lostCause)
        {
            lostCause = "丢失原因:" + lostCause;
            string lostBookSql = $@"UPDATE book SET state=2,last_comment='{lostCause}',MemberId=0 WHERE Id={bookId}";
            bool result = m_database.ExecuteSQL(lostBookSql);

            return Json(new { Result=result });
        }

        [HttpPost]
        public JsonResult BorrowBook(int bookId)
        {
            var memberId = GetCurrentUserClaim("Id");
            string memberSql = $@"SELECT MemberId FROM book WHERE Id={bookId}";
            int member = m_database.Single<int>(memberSql);
            if (member > 0)
            {//避免两个人同时请求一本书
                return Json(new { result = false });
            }
            string borrowBookSql = $@"UPDATE book SET MemberId={memberId} ,state=1 WHERE Id={bookId}";
            bool result = m_database.ExecuteSQL(borrowBookSql);

            return Json(new { Result=result });
        }

        public JsonResult GetBooks(int page, int limit, string queryType, string search)
        {
            var books = new List<dynamic>();
            int booksCount = 0;

            if (search != null)
            {
                books = GetSearchBooks(search, page, limit, out booksCount);
            }
            else
            {
                switch (queryType)
                {
                    case "Borrow":
                        books = GetBorrowBooks(page, limit, out booksCount);
                        break;

                    default:
                        books = GetAllBooks(page, limit, out booksCount);
                        break;
                }
            }
            books = GenerateBookResponse(books);

            return Json(new PageResponse(books, booksCount));
        }

        private List<dynamic> GetSearchBooks(string search, int page, int limit, out int booksCount)
        {
            string searchSql = $@"SELECT Id,Name,Photo,PhotoHD,Author,create_time,average_score,last_comment,state,MemberId
                                  FROM book
                                  WHERE  state!={AppConsts.BookType_CommentExtra}  AND  (name LIKE '%{search}%' OR author LIKE '%{search}%')
                                  ORDER BY  (CASE WHEN state=2 then 1 ELSE 0 END)
                                            ,create_time DESC LIMIT {limit * (page - 1)},{limit}";
            string sqlCount = $@"SELECT COUNT(*) FROM book 
            WHERE state!={AppConsts.BookType_CommentExtra} AND  (name LIKE '%{search}%' OR author LIKE '%{search}%')  ";
            booksCount = m_database.QuerySQL<int>(sqlCount);
            var books = m_database.QueryListSQL<dynamic>(searchSql).ToList();
            return books;
        }

        private List<dynamic> GenerateBookResponse(List<dynamic> books)
        {
            List<dynamic> result = new List<dynamic>();
            string sqlMember = $@"SELECT DISTINCT members.Id, members.Photo FROM members,book
                                         WHERE members.Id=book.MemberId";
            var members = m_database.QueryListSQL<dynamic>(sqlMember).ToList();
            foreach (var book in books)
            {
                var member = members.Where(m => m.Id == book.MemberId).Select(m => new { m.Id, m.Photo }).ToList();
                result.Add(new
                {
                    isCanBorrow = CanBorrow(),
                    book.Id, book.Name,book.Photo, book.PhotoHD,book.Author, book.create_time,
                    book.average_score, book.last_comment,book.state, member
                });
            }
            return result;
        }

        private bool CanBorrow()
        {
            string sql = $@"SELECT count(*) FROM book WHERE MemberId={GetCurrentUserClaim("Id")}    AND  state!={AppConsts.BookType_CommentExtra}";
            bool result = m_database.Single<int>(sql) == 0;

            return result;
        }

        private List<dynamic> GetBorrowBooks(int page, int limit, out int booksCount)
        {
            string sql = $@"SELECT Id,Name,Photo,PhotoHD,Author,create_time,average_score,last_comment,state,MemberId
                            FROM book  WHERE state=0 AND MemberId=0
                            ORDER BY create_time DESC  LIMIT {limit * (page - 1)},{limit}";
            string sqlCount = $@"SELECT COUNT(*) FROM book  WHERE state=0 AND MemberId=0";
            booksCount = m_database.QuerySQL<int>(sqlCount);
            var book = m_database.QueryListSQL<dynamic>(sql).ToList();
            return book;
        }

        private List<dynamic> GetAllBooks(int page, int limit, out int booksCount)
        {
            string sql = $@"SELECT Id,Name,Photo,PhotoHD,Author,create_time,average_score,last_comment,state,MemberId
                            FROM book where  state!={AppConsts.BookType_CommentExtra}
                                    ORDER BY (CASE WHEN state=2 then 1 ELSE 0 END)
                                                , create_time DESC LIMIT {limit * (page - 1)},{limit}";
            var book = m_database.QueryListSQL<dynamic>(sql).ToList();
            string sqlCount = $@"SELECT COUNT(*) FROM book  where  state!={AppConsts.BookType_CommentExtra} ";
            booksCount = m_database.QuerySQL<int>(sqlCount);
            return book;
        }
    }
}