using FlowRhApi.Dto.Beneficio;
using FlowRhApi.Models;

namespace FlowRhApi.Repositories.Beneficio
{
    public interface IBeneficioInterface
    {
        Task<ResponseModel<List<BeneficioModel>>> ListarBeneficios();
        Task<ResponseModel<BeneficioModel>> BuscarBeneficioPorId(int idBeneficio);
        Task<ResponseModel<List<BeneficioModel>>> CriarBeneficio(BeneficioCriacaoDto beneficioCriacaoDto);
        Task<ResponseModel<List<BeneficioModel>>> EditarBeneficio(BeneficioEdicaoDto beneficioEdicaoDto);
        Task<ResponseModel<List<BeneficioModel>>> DeletarBeneficio(int idBeneficio);
    }
}