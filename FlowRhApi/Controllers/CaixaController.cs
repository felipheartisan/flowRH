using FlowRhApi.Dto.Caixa;
using FlowRhApi.Models;
using FlowRhApi.Repositories.Caixa;
using Microsoft.AspNetCore.Mvc;

namespace FlowRhApi.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class CaixaController : ControllerBase
    {
        private readonly ICaixaInterface _caixaInterface;

        public CaixaController(ICaixaInterface caixaInterface)
        {
            _caixaInterface = caixaInterface;
        }

        [HttpGet("ListarCaixa")]
        public async Task<ActionResult<ResponseModel<List<CaixaModel>>>> ListarCaixa()
        {
            var lancamentosListReponse = await _caixaInterface.ListarCaixa();
            return Ok(lancamentosListReponse);
        }

        [HttpGet("BuscarLancamentoPorId")]
        public async Task<ActionResult<ResponseModel<CaixaModel>>> BuscarLancamentoPorId(int idCaixa)
        {
            var lancamentosListReponse = await _caixaInterface.BuscarLancamentoPorId(idCaixa);
            return Ok(lancamentosListReponse);
        }

        [HttpPost("CriarLancamento")]
        public async Task<ActionResult<ResponseModel<List<CaixaModel>>>> CriarLancamento(CaixaCriacaoDto caixaCriacaoDto)
        {
            var lancamentosListReponse = await _caixaInterface.CriarLancamento(caixaCriacaoDto);
            return Ok(lancamentosListReponse);
        }

        [HttpDelete("DeletarLancamento/{idCaixa}")]
        public async Task<ActionResult<ResponseModel<List<CaixaModel>>>> DeletarLancamento(int idCaixa)
        {
            var lancamentosListReponse = await _caixaInterface.DeletarLancamento(idCaixa);
            return Ok(lancamentosListReponse);
        }
        
        [HttpPut("EditarCaixa")]
        public async Task<ActionResult<ResponseModel<List<CaixaModel>>>> EditarCaixa(CaixaEdicaoDto caixaEdicaoDto)
        {
            var funcionariosListReponse = await _caixaInterface.EditarLancamento(caixaEdicaoDto);
            return Ok(funcionariosListReponse);
        }
    }
}