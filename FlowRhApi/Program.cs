using FlowRhApi.Data;
using FlowRhApi.Repositories.Avaliacao;
using FlowRhApi.Repositories.Beneficio;
using FlowRhApi.Repositories.BeneficiosFuncionarios;
using FlowRhApi.Repositories.Caixa;
using FlowRhApi.Repositories.Funcionario;
using FlowRhApi.Repositories.Usuario;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

//Os métodos da interface estão sendo implementados pelo services
builder.Services.AddScoped<IUsuarioInterface, UsuarioService>();
builder.Services.AddScoped<IFuncionarioInterface, FuncionarioService>();
builder.Services.AddScoped<ICaixaInterface, CaixaService>();
builder.Services.AddScoped<IBeneficioInterface, BeneficioService>();
builder.Services.AddScoped<IAvaliacaoInterface, AvaliacaoService>();
builder.Services.AddScoped<IBeneficiosFuncionariosInterface, BeneficiosFuncionariosService>();

string? connectionString = builder.Configuration.GetConnectionString("DefaultConnection");

// Substitua 'DbContext' pelo nome real do seu contexto, por exemplo, 'AppDbContext'
builder.Services.AddDbContext<AppDbContext>(options =>
{
    options.UseSqlServer(connectionString);
});


var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
