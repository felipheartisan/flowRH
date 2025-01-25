using FlowRhApi.Dto.Beneficio;
using FlowRhApi.Models;
using FlowRhApi.Repositories.Beneficio;
using Microsoft.AspNetCore.Mvc;

namespace FlowRhApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BeneficioController : ControllerBase
    {
        private readonly IBeneficioInterface _beneficioInterface;

        public BeneficioController(IBeneficioInterface BeneficioInterface)
        {
            _beneficioInterface = BeneficioInterface;
        }

        [HttpGet("ListarBeneficios")]
        public async Task<ActionResult<ResponseModel<List<BeneficioModel>>>> ListarBeneficio()
        {
            var beneficiosListReponse = await _beneficioInterface.ListarBeneficios();
            return Ok(beneficiosListReponse);
        }

        [HttpGet("BuscarBeneficioPorId")]
        public async Task<ActionResult<ResponseModel<BeneficioModel>>> BuscarBeneficioPorId(int idBeneficio)
        {
            var beneficiosListReponse = await _beneficioInterface.BuscarBeneficioPorId(idBeneficio);
            return Ok(beneficiosListReponse);
        }

        [HttpPost("CriarBeneficio")]
        public async Task<ActionResult<ResponseModel<List<BeneficioModel>>>> CriarBeneficio(BeneficioCriacaoDto beneficioCriacaoDto)
        {
            var beneficiosListReponse = await _beneficioInterface.CriarBeneficio(beneficioCriacaoDto);
            return Ok(beneficiosListReponse);
        }

        [HttpDelete("DeletarBeneficio/{idBeneficio}")]
        public async Task<ActionResult<ResponseModel<List<BeneficioModel>>>> DeletarBeneficio(int idBeneficio)
        {
            var beneficiosListReponse = await _beneficioInterface.DeletarBeneficio(idBeneficio);
            return Ok(beneficiosListReponse);
        }
        
        [HttpPut("EditarBeneficio")]
        public async Task<ActionResult<ResponseModel<List<BeneficioModel>>>> EditarBeneficio(BeneficioEdicaoDto BeneficioEdicaoDto)
        {
            var beneficiosListReponse = await _beneficioInterface.EditarBeneficio(BeneficioEdicaoDto);
            return Ok(beneficiosListReponse);
        }
    }
}