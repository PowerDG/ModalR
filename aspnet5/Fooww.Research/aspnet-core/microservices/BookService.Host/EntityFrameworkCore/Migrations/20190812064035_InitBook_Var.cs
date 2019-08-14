using System;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Migrations;

namespace BookService.Host.EntityFrameworkCore.Migrations
{
    public partial class InitBook_Var : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "book",
                columns: table => new
                {
                    id = table.Column<uint>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    name = table.Column<string>(type: "VARCHAR(64)", maxLength: 60, nullable: false),
                    member_id = table.Column<long>(nullable: true),
                    author = table.Column<string>(type: "VARCHAR(64)", maxLength: 60, nullable: true),
                    photo = table.Column<string>(nullable: true),
                    photo_hd = table.Column<string>(nullable: true),
                    entry_time = table.Column<DateTime>(nullable: false),
                    average_score = table.Column<decimal>(nullable: false),
                    number_of_book_review = table.Column<uint>(nullable: false),
                    resource = table.Column<string>(type: "VARCHAR(64)", maxLength: 60, nullable: true),
                    state = table.Column<byte>(nullable: false),
                    last_book_review = table.Column<string>(type: "VARCHAR(254)", maxLength: 250, nullable: true),
                    is_active = table.Column<bool>(nullable: false),
                    creator_user_id = table.Column<long>(nullable: true),
                    create_time = table.Column<DateTime>(nullable: false),
                    last_modifier_user_id = table.Column<long>(nullable: true),
                    modified_time = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_book", x => x.id);
                });

            migrationBuilder.CreateTable(
                name: "book_review",
                columns: table => new
                {
                    id = table.Column<uint>(nullable: false)
                        .Annotation("MySql:ValueGenerationStrategy", MySqlValueGenerationStrategy.IdentityColumn),
                    book_id = table.Column<uint>(nullable: false),
                    review = table.Column<string>(type: "VARCHAR(254)", maxLength: 250, nullable: true),
                    score = table.Column<uint>(nullable: false),
                    is_active = table.Column<bool>(nullable: false),
                    creator_user_id = table.Column<long>(nullable: true),
                    create_time = table.Column<DateTime>(nullable: false),
                    last_modifier_user_id = table.Column<long>(nullable: true),
                    modified_time = table.Column<DateTime>(nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_book_review", x => x.id);
                });
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "book");

            migrationBuilder.DropTable(
                name: "book_review");
        }
    }
}
