using FlowRhApi.Dto.Avaliacao;
using FlowRhApi.Dto.BeneficiosFuncionarios;
using FlowRhApi.Models;
using FlowRhApi.Repositories.BeneficiosFuncionarios;
using Microsoft.AspNetCore.Mvc;

namespace FlowRhApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BeneficioFuncionarioController : ControllerBase
    {
        private readonly IBeneficiosFuncionariosInterface _beneficiosFuncionariosInterface;

        public BeneficioFuncionarioController(IBeneficiosFuncionariosInterface beneficiosFuncionariosInterface)
        {
            _beneficiosFuncionariosInterface = beneficiosFuncionariosInterface;
        }

        [HttpGet("ListarBeneficiosFuncionarios")]
        public async Task<ActionResult<ResponseModel<List<BeneficiosFuncionariosModel>>>> ListarBeneficiosFuncionarios()
        {
            var beneficioFuncionarioListReponse = await _beneficiosFuncionariosInterface.ListarTodos();
            return Ok(beneficioFuncionarioListReponse);
        }

        [HttpGet("BuscarPorBeneficio/{idBeneficio}")]
        public async Task<ActionResult<ResponseModel<List<BeneficiosFuncionariosModel>>>> BuscarPorBeneficio(int idBeneficio)
        {
            var beneficioFuncionarioListReponse = await _beneficiosFuncionariosInterface.BuscarPorBeneficio(idBeneficio);
            return Ok(beneficioFuncionarioListReponse);
        }

        [HttpGet("BuscarPorFuncionario/{idFuncionario}")]
        public async Task<ActionResult<ResponseModel<List<BeneficiosFuncionariosModel>>>> BuscarPorFuncionario(int idFuncionario)
        {
            var beneficioFuncionarioListReponse = await _beneficiosFuncionariosInterface.BuscarPorFuncionario(idFuncionario);
            return Ok(beneficioFuncionarioListReponse);
        }


        [HttpPost("VincularBeneficioFuncionario")]
        public async Task<ActionResult<ResponseModel<List<BeneficiosFuncionariosModel>>>> VincularBeneficioFuncionario(BeneficioFuncionarioCriacaoDto beneficioFuncionarioCriacaoDto)
        {
            var beneficioFuncionarioListReponse = await _beneficiosFuncionariosInterface.VincularBeneficioFuncionario(beneficioFuncionarioCriacaoDto);
            return Ok(beneficioFuncionarioListReponse);
        }

        [HttpDelete("DeletarVinculoBeneficioFuncionario/{idBeneficioFuncionario}")]
        public async Task<ActionResult<ResponseModel<List<BeneficiosFuncionariosModel>>>> DeletarVinculoBeneficioFuncionario(int idBeneficioFuncionario)
        {
            var beneficioFuncionarioListReponse = await _beneficiosFuncionariosInterface.DeletarVinculoBeneficioFuncionario(idBeneficioFuncionario);
            return Ok(beneficioFuncionarioListReponse);
        }
        
    }
}