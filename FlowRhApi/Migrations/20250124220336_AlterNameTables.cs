using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FlowRhApi.Migrations
{
    /// <inheritdoc />
    public partial class AlterNameTables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AvaliacoesFuncionarios_Funcionarios_IdFuncionarioId",
                table: "AvaliacoesFuncionarios");

            migrationBuilder.DropColumn(
                name: "NomeFuncionario",
                table: "AvaliacoesFuncionarios");

            migrationBuilder.RenameColumn(
                name: "IdFuncionarioId",
                table: "AvaliacoesFuncionarios",
                newName: "FuncionarioId");

            migrationBuilder.RenameIndex(
                name: "IX_AvaliacoesFuncionarios_IdFuncionarioId",
                table: "AvaliacoesFuncionarios",
                newName: "IX_AvaliacoesFuncionarios_FuncionarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_AvaliacoesFuncionarios_Funcionarios_FuncionarioId",
                table: "AvaliacoesFuncionarios",
                column: "FuncionarioId",
                principalTable: "Funcionarios",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AvaliacoesFuncionarios_Funcionarios_FuncionarioId",
                table: "AvaliacoesFuncionarios");

            migrationBuilder.RenameColumn(
                name: "FuncionarioId",
                table: "AvaliacoesFuncionarios",
                newName: "IdFuncionarioId");

            migrationBuilder.RenameIndex(
                name: "IX_AvaliacoesFuncionarios_FuncionarioId",
                table: "AvaliacoesFuncionarios",
                newName: "IX_AvaliacoesFuncionarios_IdFuncionarioId");

            migrationBuilder.AddColumn<string>(
                name: "NomeFuncionario",
                table: "AvaliacoesFuncionarios",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");

            migrationBuilder.AddForeignKey(
                name: "FK_AvaliacoesFuncionarios_Funcionarios_IdFuncionarioId",
                table: "AvaliacoesFuncionarios",
                column: "IdFuncionarioId",
                principalTable: "Funcionarios",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
