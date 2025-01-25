using FlowRhApi.Dto.BeneficiosFuncionarios;
using FlowRhApi.Models;

namespace FlowRhApi.Repositories.BeneficiosFuncionarios
{
    public interface IBeneficiosFuncionariosInterface
    {
        Task<ResponseModel<List<BeneficiosFuncionariosModel>>> ListarTodos();
        Task<ResponseModel<List<BeneficiosFuncionariosModel>>> BuscarPorBeneficio(int idBeneficio);
        Task<ResponseModel<List<BeneficiosFuncionariosModel>>> BuscarPorFuncionario(int idFuncionario);
        Task<ResponseModel<List<BeneficiosFuncionariosModel>>> VincularBeneficioFuncionario(BeneficioFuncionarioCriacaoDto beneficioFuncionarioCriacaoDto);
        Task<ResponseModel<List<BeneficiosFuncionariosModel>>> DeletarVinculoBeneficioFuncionario(int idBeneficioFuncionario);
    }
}