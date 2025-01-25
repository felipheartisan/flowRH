using FlowRhApi.Dto.Caixa;
using FlowRhApi.Models;

namespace FlowRhApi.Repositories.Caixa
{
    public interface ICaixaInterface
    {
        Task<ResponseModel<List<CaixaModel>>> ListarCaixa();
        Task<ResponseModel<CaixaModel>> BuscarLancamentoPorId(int idCaixa);
        Task<ResponseModel<List<CaixaModel>>> CriarLancamento(CaixaCriacaoDto caixaCriacaoDto);
        Task<ResponseModel<List<CaixaModel>>> EditarLancamento(CaixaEdicaoDto caixaEdicaoDto);
        Task<ResponseModel<List<CaixaModel>>> DeletarLancamento(int idCaixa);
    }
}