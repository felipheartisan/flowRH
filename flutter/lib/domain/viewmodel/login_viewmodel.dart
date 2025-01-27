class LoginViewModel {
  final String Login;
  final String Password;

  LoginViewModel({
    required this.Login,
    required this.Password,
  });

  Map<String, dynamic> toMap() {
    return {
      'Login': Login,
      'Password': Password,
    };
  }
}