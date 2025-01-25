
import 'package:flow_rh/routes.dart';
import 'package:flow_rh/view/login_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routName,
      routes: Routes.routes,
    );
  }
  
}




