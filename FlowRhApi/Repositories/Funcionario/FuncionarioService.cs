using Azure;
using FlowRhApi.Data;
using FlowRhApi.Dto.Funcionario;
using FlowRhApi.Models;
using FlowRhApi.Repositories.Funcionario;
using Microsoft.EntityFrameworkCore;

namespace FlowRhApi.Repositories.Usuario
{
    public class FuncionarioService : IFuncionarioInterface
    {
        private readonly AppDbContext _context;
        public FuncionarioService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<ResponseModel<FuncionarioModel>> BuscarFuncionarioPorId(int idFuncionario)
        {
            ResponseModel<FuncionarioModel> response = new ResponseModel<FuncionarioModel>();

            try
            {
                var funcionario = await _context.Funcionarios.FirstOrDefaultAsync(x => x.Id == idFuncionario);  
                if (funcionario == null)
                {
                    response.Mensagem = "Funcionário não encontrado";
                    response.Status = true;
                    return response;
                }

                response.Dados = funcionario;
                response.Status = true;
                response.Mensagem = "Funcionário encontrado com sucesso";
                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<FuncionarioModel>>> CriarFuncionario(FuncionarioCriacaoDto funcionarioCriacaoDto)
        {
            ResponseModel<List<FuncionarioModel>> response = new ResponseModel<List<FuncionarioModel>>();

            try
            {
                var novoFuncionario = new FuncionarioModel()
                {
                    Nome = funcionarioCriacaoDto.Nome,
                    DataNascimento = funcionarioCriacaoDto.DataNascimento,
                    Salario = funcionarioCriacaoDto.Salario,
                    Cargo = funcionarioCriacaoDto.Cargo,
                    Departamento = funcionarioCriacaoDto.Departamento,
                    Cpf = funcionarioCriacaoDto.Cpf,
                    Rg = funcionarioCriacaoDto.Rg,
                    Telefone = funcionarioCriacaoDto.Telefone,
                    Rua = funcionarioCriacaoDto.Rua,
                    NumeroCasa = funcionarioCriacaoDto.NumeroCasa,
                    Bairro = funcionarioCriacaoDto.Bairro,
                    Cidade = funcionarioCriacaoDto.Cidade,
                    Email = funcionarioCriacaoDto.Email            
                   
                };

                 _context.Funcionarios.Add(novoFuncionario);
                await _context.SaveChangesAsync();

                var funcionarios = await _context.Funcionarios.ToListAsync();

                response.Dados = funcionarios;
                response.Status = true;
                response.Mensagem = "Funcionários listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<FuncionarioModel>>> DeletarFuncionario(int idFuncionario)
        {
            ResponseModel<List<FuncionarioModel>> response = new ResponseModel<List<FuncionarioModel>>();

            try
            {
                var funcionario = await _context.Funcionarios.FirstOrDefaultAsync(x => x.Id == idFuncionario);  
                if (funcionario == null)
                {
                    response.Mensagem = "Funcionário não encontrado";
                    response.Status = true;
                    return response;
                }

                _context.Funcionarios.Remove(funcionario);
                await _context.SaveChangesAsync();

                var funcionarios = await _context.Funcionarios.ToListAsync();

                response.Dados = funcionarios;
                response.Status = true;
                response.Mensagem = "Funcionários listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<FuncionarioModel>>> EditarFuncionario(FuncionarioEdicaoDto funcionarioEdicaoDto)
        {
            ResponseModel<List<FuncionarioModel>> response = new ResponseModel<List<FuncionarioModel>>();

            try
            {
                var funcionario = await _context.Funcionarios.FirstOrDefaultAsync(x => x.Id == funcionarioEdicaoDto.Id);  
                if (funcionario == null)
                {
                    response.Mensagem = "Funcionário não encontrado";
                    response.Status = true;
                    return response;
                }

                funcionario.Nome = funcionarioEdicaoDto.Nome;
                funcionario.Email = funcionarioEdicaoDto.Email;
                funcionario.Cpf = funcionarioEdicaoDto.Cpf;
                funcionario.Cargo = funcionarioEdicaoDto.Cargo;
                funcionario.Salario = funcionarioEdicaoDto.Salario;
                funcionario.Bairro = funcionarioEdicaoDto.Bairro;
                funcionario.Cidade = funcionarioEdicaoDto.Cidade;
                funcionario.Rua = funcionarioEdicaoDto.Rua;
                funcionario.Rg = funcionarioEdicaoDto.Rg;
                funcionario.Telefone = funcionarioEdicaoDto.Telefone;
                funcionario.NumeroCasa = funcionarioEdicaoDto.NumeroCasa;
                funcionario.Departamento = funcionarioEdicaoDto.Departamento;
                funcionario.DataNascimento = funcionarioEdicaoDto.DataNascimento;

                _context.Funcionarios.Update(funcionario);
                await _context.SaveChangesAsync();

                var funcionarios = await _context.Funcionarios.ToListAsync();
    

                response.Dados = funcionarios;
                response.Status = true;
                response.Mensagem = "Funcionários listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<FuncionarioModel>>> ListarFuncionario()
        {
            ResponseModel<List<FuncionarioModel>> response = new ResponseModel<List<FuncionarioModel>>();

            try
            {
                var funcionarios = await _context.Funcionarios.ToListAsync();

                response.Dados = funcionarios;
                response.Status = true;
                response.Mensagem = "Funcionarios listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }
    }
}