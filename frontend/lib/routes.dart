import 'package:flow_rh/domain/controllers/login_controller.dart';
import 'package:flow_rh/view/avaliation/FormAvaliationScreen.dart';
import 'package:flow_rh/view/avaliation/SearchAvaliationScreen.dart';
import 'package:flow_rh/view/benefits/FormBenefitsScreen.dart';
import 'package:flow_rh/view/benefits/SearchBenefitsScreen.dart';
import 'package:flow_rh/view/cashflow/SearchCashScreen.dart';
import 'package:flow_rh/view/cashflow/FormCashScreen.dart';
import 'package:flow_rh/view/functionary/FormFunctionaryScreen.dart';
import 'package:flow_rh/view/functionary_benefits/FormFuncBene.dart';
import 'package:flow_rh/view/functionary_benefits/SearchFuncBene.dart';
import 'package:flow_rh/view/login_screen.dart';
import 'package:flow_rh/view/functionary/SearchFunctionaryScreen.dart';
import 'package:flow_rh/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Routes{
  static Map<String, Widget Function(BuildContext context)> routes = {
    HomeScreen.routName : (context) => HomeScreen(),
    FormFunctionaryScreen.routName : (context) => FormFunctionaryScreen(),
    SearchFunctionaryScreen.routName : (context) => const SearchFunctionaryScreen(),
    FormCashScreen.routName : (context) => FormCashScreen(),
    SearchCashScreen.routName : (context) => const SearchCashScreen(),
    LoginScreen.routName : (context) => LoginScreen(),
    FormBenefitsScreen.routName : (context) => FormBenefitsScreen(),
    SearchBenefitsScreen.routName : (context) => const SearchBenefitsScreen(),
    FormFuncBeneScreen.routName : (context) => FormFuncBeneScreen(),
    SearchfuncbeneScreen.routName : (context) => SearchfuncbeneScreen(),
    FormAvaliationScreen.routName : (context) => FormAvaliationScreen(),
    SearchAvaliationScreen.routName : (context) => const SearchAvaliationScreen(),
  };
}