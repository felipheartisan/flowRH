using Azure;
using ControleEnderecos.Helper;
using FlowRhApi.Data;
using FlowRhApi.Dto.Usuario;
using FlowRhApi.Models;
using FlowRhApi.ViewModel.Login;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace FlowRhApi.Repositories.Usuario
{
    public class UsuarioService : IUsuarioInterface
    {
        private readonly AppDbContext _context;
        public UsuarioService(AppDbContext context)
        {
            _context = context;
        }

        public async Task<ResponseModel<UsuarioModel>> BuscarPorId(int idUsuario)
        {
            ResponseModel<UsuarioModel> response = new ResponseModel<UsuarioModel>();

            try
            {
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(x => x.Id == idUsuario);  
                if (usuario == null)
                {
                    response.Mensagem = "Usuário não encontrado";
                    response.Status = true;
                    return response;
                }

                response.Dados = usuario;
                response.Status = true;
                response.Mensagem = "Usuário encontrado com sucesso";
                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }

        }
       
        public async Task<ResponseModel<List<UsuarioModel>>> CriarUsuario(UsuarioCriacaoDto usuarioCriacaoDto)
        {
            ResponseModel<List<UsuarioModel>> response = new ResponseModel<List<UsuarioModel>>();

            try
            {

                var novoUsuario = new UsuarioModel()
                {
                    Nome = usuarioCriacaoDto.Nome,
                    Email = usuarioCriacaoDto.Email,
                   
                };

                 byte[] salt = Helper.GenerateSaltToBytes();
            
                novoUsuario.Salt = Convert.ToBase64String(salt);
    
                var passNew = Helper.GenerateSHA256Hash(usuarioCriacaoDto.Senha);
    
                var passHash = Helper.GetPasswordHash(passNew, salt);
    
                novoUsuario.Senha = passHash;

                 _context.Usuarios.Add(novoUsuario);
                await _context.SaveChangesAsync();

                var usuarios = await _context.Usuarios.ToListAsync();

                response.Dados = usuarios;
                response.Status = true;
                response.Mensagem = "Usuários listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<UsuarioModel>>> DeletarUsuario(int idUsuario)
        {
            ResponseModel<List<UsuarioModel>> response = new ResponseModel<List<UsuarioModel>>();

            try
            {
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(x => x.Id == idUsuario);  
                if (usuario == null)
                {
                    response.Mensagem = "Usuário não encontrado";
                    response.Status = true;
                    return response;
                }

                _context.Usuarios.Remove(usuario);
                await _context.SaveChangesAsync();

                var usuarios = await _context.Usuarios.ToListAsync();

                response.Dados = usuarios;
                response.Status = true;
                response.Mensagem = "Usuários listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }

        }

        public async Task<ResponseModel<List<UsuarioModel>>> EditarUsuario(UsuarioEdicaoDto usuarioEdicaoDto)
        {
            ResponseModel<List<UsuarioModel>> response = new ResponseModel<List<UsuarioModel>>();

            try
            {
                var usuario = await _context.Usuarios.FirstOrDefaultAsync(x => x.Id == usuarioEdicaoDto.Id);  
                if (usuario == null)
                {
                    response.Mensagem = "Usuário não encontrado";
                    response.Status = true;
                    return response;
                }

                usuario.Nome = usuarioEdicaoDto.Nome;
                usuario.Email = usuarioEdicaoDto.Email; 
                usuario.Senha = usuarioEdicaoDto.Senha;

                _context.Usuarios.Update(usuario);
                await _context.SaveChangesAsync();

                var usuarios = await _context.Usuarios.ToListAsync();

                response.Dados = usuarios;
                response.Status = true;
                response.Mensagem = "Usuários listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<List<UsuarioModel>>> ListarUsuarios()
        {
            ResponseModel<List<UsuarioModel>> response = new ResponseModel<List<UsuarioModel>>();

            try
            {
                var usuarios = await _context.Usuarios.ToListAsync();

                response.Dados = usuarios;
                response.Status = true;
                response.Mensagem = "Usuários listados com sucesso";

                return response;
            }
            catch (Exception ex)
            {
                
                response.Mensagem = ex.Message;
                response.Status = false;

                return response;
            }
        }

        public async Task<ResponseModel<UsuarioModel>> Autenticar(LoginViewModel loginViewModel)
        {
            ResponseModel<UsuarioModel> response = new ResponseModel<UsuarioModel>();
            /*
             * Verificando se o usuário existe no sistema
             */
            var usuario = await _context.Usuarios.FirstOrDefaultAsync(
                entidade => entidade.Nome == loginViewModel.Login
                            || entidade.Email == loginViewModel.Login);

            if (usuario == null)
            {
                response.Mensagem = "Usuário ou senha Inválidos.";
                response.Status = false;
                return response;
            }

            //Converte o salt armazenado na tabela do usuario para byte[]
            byte[] salt = Convert.FromBase64String(usuario.Salt);


            //Pega a senha que o usuario digitou durante o login e aplica o hash
            var password = Helper.GenerateSHA256Hash(loginViewModel.Password);

            //Pega a senha digitada que foi criptografada em hash e salt para retornar o valor original
            var passHash = Helper.GetPasswordHash(password, salt);


            if ((usuario == null) || (passHash != usuario.Senha))
            {
                response.Mensagem = "Usuário ou senha Inválidos.";
                response.Status = false;
                return response;
            }

            response.Dados = usuario;
            response.Status = true;
            response.Mensagem= "Usuário logado";
            return response;
        }
    }
}