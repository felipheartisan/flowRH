using Azure;
using FlowRhApi.Data;
using FlowRhApi.Dto.Beneficio;
using FlowRhApi.Models;
using Microsoft.EntityFrameworkCore;

namespace FlowRhApi.Repositories.Beneficio
{
    public class BeneficioService : IBeneficioInterface
    {
        private readonly AppDbContext _context;
        public BeneficioService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<ResponseModel<BeneficioModel>> BuscarBeneficioPorId(int idBeneficio)
        {
            ResponseModel<BeneficioModel> response = new ResponseModel<BeneficioModel>();

            try
            {
                var beneficio = await _context.Beneficios.FirstOrDefaultAsync(x => x.Id == idBeneficio);  
                if (beneficio == null)
                {
                    response.Mensagem = "beneficio não encontrado";
                    response.Status = true;
                    return response;
                }

                response.Dados = beneficio;
                response.Status = true;
                response.Mensagem = "beneficio encontrado com sucesso";
                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<BeneficioModel>>> CriarBeneficio(BeneficioCriacaoDto beneficioCriacaoDto)
        {
            ResponseModel<List<BeneficioModel>> response = new ResponseModel<List<BeneficioModel>>();

            try
            {
                var novoBeneficio = new BeneficioModel()
                {
                    Dependentes = beneficioCriacaoDto.Dependentes,
                    Descricao = beneficioCriacaoDto.Descricao
                   
                };

                 _context.Beneficios.Add(novoBeneficio);
                await _context.SaveChangesAsync();

                var beneficios = await _context.Beneficios.ToListAsync();

                response.Dados = beneficios;
                response.Status = true;
                response.Mensagem = "beneficios listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<BeneficioModel>>> DeletarBeneficio(int idBeneficio)
        {
            ResponseModel<List<BeneficioModel>> response = new ResponseModel<List<BeneficioModel>>();

            try
            {
                var beneficio = await _context.Beneficios.FirstOrDefaultAsync(x => x.Id == idBeneficio);  
                if (beneficio == null)
                {
                    response.Mensagem = "Beneficio não encontrado";
                    response.Status = true;
                    return response;
                }

                _context.Beneficios.Remove(beneficio);
                await _context.SaveChangesAsync();

                var beneficios = await _context.Beneficios.ToListAsync();

                response.Dados = beneficios;
                response.Status = true;
                response.Mensagem = "Beneficios listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<BeneficioModel>>> EditarBeneficio(BeneficioEdicaoDto beneficioEdicaoDto)
        {
            ResponseModel<List<BeneficioModel>> response = new ResponseModel<List<BeneficioModel>>();

            try
            {
                var beneficio = await _context.Beneficios.FirstOrDefaultAsync(x => x.Id == beneficioEdicaoDto.Id);  
                if (beneficio == null)
                {
                    response.Mensagem = "beneficio não encontrado";
                    response.Status = true;
                    return response;
                }

               beneficio.Dependentes = beneficioEdicaoDto.Dependentes;
                beneficio.Descricao = beneficioEdicaoDto.Descricao;
                

                _context.Beneficios.Update(beneficio);
                await _context.SaveChangesAsync();

                var beneficios = await _context.Beneficios.ToListAsync();

                response.Dados = beneficios;
                response.Status = true;
                response.Mensagem = "beneficios listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<BeneficioModel>>> ListarBeneficios()
        {
            ResponseModel<List<BeneficioModel>> response = new ResponseModel<List<BeneficioModel>>();

            try
            {
                var beneficios = await _context.Beneficios.ToListAsync();

                response.Dados = beneficios;
                response.Status = true;
                response.Mensagem = "beneficios listados com sucesso";

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