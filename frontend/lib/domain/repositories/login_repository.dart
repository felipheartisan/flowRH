import 'package:flow_rh/data/database_provider.dart';
import 'package:flow_rh/domain/models/login.dart';
import 'package:sqflite/sqflite.dart';

class LoginRepository {
  late DatabaseProvider databaseProvider;
  LoginRepository(this.databaseProvider);

  Future<int> insert(Login entity) async{
    try{
      print("salvou 000");
       await databaseProvider.open();
      Database dt = databaseProvider.database;
      return await dt.insert("Login", entity.toMap());
    } on Exception catch (e){
      throw Exception(e);
    }finally{
      if (databaseProvider.database.isOpen){
        databaseProvider.database.close();
      }
    }

  }

   Future<bool> validateUser(String usuario, String token) async {
    DatabaseProvider databaseProvider = DatabaseProvider();
    try{
      print("salvou 000");
       await databaseProvider.open();
       Database dt = databaseProvider.database;
      final List<Map<String, dynamic>> result = await dt.query( 'Login',
      where: 'usuario = ? AND token = ?',
      whereArgs: [usuario, token],);
      return result.isNotEmpty;
      } on Exception catch (e){
      throw Exception(e);
    }finally{
      if (databaseProvider.database.isOpen){
        databaseProvider.database.close();
      }
    }

  }

}