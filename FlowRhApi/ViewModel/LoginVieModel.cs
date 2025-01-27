using System.ComponentModel.DataAnnotations;

namespace FlowRhApi.ViewModel.Login
{
    public class LoginViewModel
    {
        
    
        [Required]
        public string Login { get; set; }

        [Required]
        public string Password { get; set; }

    
    }
}