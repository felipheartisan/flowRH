using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace FlowRhApi.Migrations
{
    /// <inheritdoc />
    public partial class AlterTables : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "IdFuncionario",
                table: "AvaliacoesFuncionarios",
                newName: "IdFuncionarioId");

            migrationBuilder.CreateIndex(
                name: "IX_AvaliacoesFuncionarios_IdFuncionarioId",
                table: "AvaliacoesFuncionarios",
                column: "IdFuncionarioId");

            migrationBuilder.AddForeignKey(
                name: "FK_AvaliacoesFuncionarios_Funcionarios_IdFuncionarioId",
                table: "AvaliacoesFuncionarios",
                column: "IdFuncionarioId",
                principalTable: "Funcionarios",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_AvaliacoesFuncionarios_Funcionarios_IdFuncionarioId",
                table: "AvaliacoesFuncionarios");

            migrationBuilder.DropIndex(
                name: "IX_AvaliacoesFuncionarios_IdFuncionarioId",
                table: "AvaliacoesFuncionarios");

            migrationBuilder.RenameColumn(
                name: "IdFuncionarioId",
                table: "AvaliacoesFuncionarios",
                newName: "IdFuncionario");
        }
    }
}
