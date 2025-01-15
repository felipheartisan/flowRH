class Login{
  int? idLogin;
  String? usuario;
  String? token;

  Login({
    this.idLogin,
    this.usuario,
    this.token,
  });

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'idLogin': idLogin,
      'usuario': usuario,
      'token': token,
    };
  } 
}