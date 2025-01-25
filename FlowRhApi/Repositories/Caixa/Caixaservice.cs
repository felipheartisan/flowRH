using Azure;
using FlowRhApi.Data;
using FlowRhApi.Dto.Caixa;
using FlowRhApi.Models;
using FlowRhApi.Repositories.Caixa;
using Microsoft.EntityFrameworkCore;

namespace FlowRhApi.Repositories.Usuario
{
    public class CaixaService : ICaixaInterface
    {
        private readonly AppDbContext _context;
        public CaixaService(AppDbContext context)
        {
            _context = context;
        }
        
        public async Task<ResponseModel<CaixaModel>> BuscarLancamentoPorId(int idCaixa)
        {
            ResponseModel<CaixaModel> response = new ResponseModel<CaixaModel>();

            try
            {
                var lancamento = await _context.Caixas.FirstOrDefaultAsync(x => x.Id == idCaixa);  
                if (lancamento == null)
                {
                    response.Mensagem = "Lancamento não encontrado";
                    response.Status = true;
                    return response;
                }

                response.Dados = lancamento;
                response.Status = true;
                response.Mensagem = "Lancamento encontrado com sucesso";
                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }

        }

        public async Task<ResponseModel<List<CaixaModel>>> CriarLancamento(CaixaCriacaoDto caixaCriacaoDto)
        {
            ResponseModel<List<CaixaModel>> response = new ResponseModel<List<CaixaModel>>();

            try
            {
                var novoLancamento = new CaixaModel()
                {
                    Data = caixaCriacaoDto.Data,
                    Descricao = caixaCriacaoDto.Descricao,
                    Tipo = caixaCriacaoDto.Tipo,
                    Valor = caixaCriacaoDto.Valor
                   
                };

                 _context.Caixas.Add(novoLancamento);
                await _context.SaveChangesAsync();

                var lancamentos = await _context.Caixas.ToListAsync();

                response.Dados = lancamentos;
                response.Status = true;
                response.Mensagem = "Lançamentos listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<CaixaModel>>> DeletarLancamento(int idCaixa)
        {
            ResponseModel<List<CaixaModel>> response = new ResponseModel<List<CaixaModel>>();

            try
            {
                var caixa = await _context.Caixas.FirstOrDefaultAsync(x => x.Id == idCaixa);  
                if (caixa == null)
                {
                    response.Mensagem = "Lancamento não encontrado";
                    response.Status = true;
                    return response;
                }

                _context.Caixas.Remove(caixa);
                await _context.SaveChangesAsync();

                var lancamentos = await _context.Caixas.ToListAsync();

                response.Dados = lancamentos;
                response.Status = true;
                response.Mensagem = "Lançamentos listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<CaixaModel>>> EditarLancamento(CaixaEdicaoDto caixaEdicaoDto)
        {
            ResponseModel<List<CaixaModel>> response = new ResponseModel<List<CaixaModel>>();

            try
            {
                var lancamento = await _context.Caixas.FirstOrDefaultAsync(x => x.Id == caixaEdicaoDto.Id);  
                if (lancamento == null)
                {
                    response.Mensagem = "Lancamento não encontrado";
                    response.Status = true;
                    return response;
                }

                lancamento.Valor = caixaEdicaoDto.Valor;
                lancamento.Descricao = caixaEdicaoDto.Descricao;
                lancamento.Data = caixaEdicaoDto.Data;
                lancamento.Tipo = caixaEdicaoDto.Tipo;
                

                _context.Caixas.Update(lancamento);
                await _context.SaveChangesAsync();

                var lancamentos = await _context.Caixas.ToListAsync();

                response.Dados = lancamentos;
                response.Status = true;
                response.Mensagem = "Lancamentos listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<CaixaModel>>> ListarCaixa()
        {
            ResponseModel<List<CaixaModel>> response = new ResponseModel<List<CaixaModel>>();

            try
            {
                var lancamentos = await _context.Caixas.ToListAsync();

                response.Dados = lancamentos;
                response.Status = true;
                response.Mensagem = "Lancamentos listados com sucesso";

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