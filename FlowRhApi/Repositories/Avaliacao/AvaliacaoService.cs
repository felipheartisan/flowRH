using Azure;
using FlowRhApi.Data;
using FlowRhApi.Dto.Avaliacao;
using FlowRhApi.Models;
using Microsoft.EntityFrameworkCore;

namespace FlowRhApi.Repositories.Avaliacao
{
    public class AvaliacaoService : IAvaliacaoInterface
    {
        private readonly AppDbContext _context;
        public AvaliacaoService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<ResponseModel<AvaliacoesFuncionarioModel>> BuscarAvaliacaoPorId(int idAvaliacao)
        {
            ResponseModel<AvaliacoesFuncionarioModel> response = new ResponseModel<AvaliacoesFuncionarioModel>();

            try
            {
                var avaliacao = await _context.AvaliacoesFuncionarios.Include(x => x.Funcionario).FirstOrDefaultAsync(x => x.Id == idAvaliacao);  
                if (avaliacao == null)
                {
                    response.Mensagem = "avaliacao não encontrado";
                    response.Status = true;
                    return response;
                }

                response.Dados = avaliacao;
                response.Status = true;
                response.Mensagem = "avaliacao encontrada com sucesso";
                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<AvaliacoesFuncionarioModel>>> CriarAvaliacao(AvaliacaoCriacaoDto AvaliacaoCriacaoDto)
        {
            ResponseModel<List<AvaliacoesFuncionarioModel>> response = new ResponseModel<List<AvaliacoesFuncionarioModel>>();
            
            try
            {
                
                var funcionario = await _context.Funcionarios.FirstOrDefaultAsync(linhaBanco => linhaBanco.Id == AvaliacaoCriacaoDto.IdFuncionario);
                if (funcionario == null)
                {
                    response.Mensagem = "Funcionario nao encontrado";
                    response.Status = false;
                    return response;
                }

                var novaAvaliacao = new AvaliacoesFuncionarioModel()
                {
                    Nota = AvaliacaoCriacaoDto.Nota,
                    CursosFazer = AvaliacaoCriacaoDto.CursosFazer,
                    CursosFeitos = AvaliacaoCriacaoDto.CursosFeitos,
                    Atividades = AvaliacaoCriacaoDto.Atividades,
                    AnoReferencia = AvaliacaoCriacaoDto.AnoReferencia,
                    MesReferencia = AvaliacaoCriacaoDto.MesReferencia,
                    Funcionario = funcionario
                   
                };

                 _context.AvaliacoesFuncionarios.Add(novaAvaliacao);
                await _context.SaveChangesAsync();

                var avaliacoesFuncionarios = await _context.AvaliacoesFuncionarios.Include(x => x.Funcionario).ToListAsync();

                response.Dados = avaliacoesFuncionarios;
                response.Status = true;
                response.Mensagem = "avaliacaos listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<AvaliacoesFuncionarioModel>>> DeletarAvaliacao(int idAvaliacao)
        {
            ResponseModel<List<AvaliacoesFuncionarioModel>> response = new ResponseModel<List<AvaliacoesFuncionarioModel>>();

            try
            {
                var avaliacao = await _context.AvaliacoesFuncionarios.FirstOrDefaultAsync(x => x.Id == idAvaliacao);  
                if (avaliacao == null)
                {
                    response.Mensagem = "avaliacao não encontrado";
                    response.Status = true;
                    return response;
                }

                _context.AvaliacoesFuncionarios.Remove(avaliacao);
                await _context.SaveChangesAsync();

                 var avaliacoes = await _context.AvaliacoesFuncionarios
                    .Include(x => x.Funcionario).ToListAsync();

                response.Dados = avaliacoes;
                response.Status = true;
                response.Mensagem = "avaliacoes listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<AvaliacoesFuncionarioModel>>> EditarAvaliacao(AvaliacaoEdicaoDto avaliacaoEdicaoDto)
        {
            
            ResponseModel<List<AvaliacoesFuncionarioModel>> response = new ResponseModel<List<AvaliacoesFuncionarioModel>>();

            try
            {
                var funcionario = await _context.Funcionarios.FirstOrDefaultAsync(linhaBanco => linhaBanco.Id == avaliacaoEdicaoDto.IdFuncionario);
                if (funcionario == null)
                {
                    response.Mensagem = "Funcionario nao encontrado";
                    response.Status = false;
                    return response;
                }

                var avaliacao = await _context.AvaliacoesFuncionarios.FirstOrDefaultAsync(x => x.Id == avaliacaoEdicaoDto.Id);  
                if (avaliacao == null)
                {
                    response.Mensagem = "avaliacao não encontrada";
                    response.Status = true;
                    return response;
                }

                avaliacao.Nota = avaliacaoEdicaoDto.Nota;
                avaliacao.CursosFazer = avaliacaoEdicaoDto.CursosFazer;
                avaliacao.CursosFeitos = avaliacaoEdicaoDto.CursosFeitos;
                avaliacao.Atividades = avaliacaoEdicaoDto.Atividades;
                avaliacao.AnoReferencia = avaliacaoEdicaoDto.AnoReferencia;
                avaliacao.MesReferencia = avaliacaoEdicaoDto.MesReferencia;
                avaliacao.Funcionario = funcionario;
                

                _context.AvaliacoesFuncionarios.Update(avaliacao);
                await _context.SaveChangesAsync();

                var avaliacoes = await _context.AvaliacoesFuncionarios.Include(x => x.Funcionario).ToListAsync();

                response.Dados = avaliacoes;
                response.Status = true;
                response.Mensagem = "avaliacoes listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<AvaliacoesFuncionarioModel>>> ListarAvaliacoes()
        {
           ResponseModel<List<AvaliacoesFuncionarioModel>> response = new ResponseModel<List<AvaliacoesFuncionarioModel>>();

            try
            {
                var avaliacoes = await _context.AvaliacoesFuncionarios.Include(x => x.Funcionario).ToListAsync();

                response.Dados = avaliacoes;
                response.Status = true;
                response.Mensagem = "avaliacoes listadas com sucesso";

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