import 'package:flutter/foundation.dart';
import '../Database/Util.dart';
import '../Model/recovery_form_model.dart';
import '../database/dp_helper.dart';
class RecoveryFormRepository{
  DBHelper dbHelper = DBHelper();
  Future<List<RecoveryFormModel>> getRecoveryForm() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(recoveryFormTableName,columns: ['Id','shopName','currentBalance' ,'cashRecovery','newBalance','date']);
    List<RecoveryFormModel> recoveryform = [];
    for(int i = 0; i<maps.length; i++)
    {
      recoveryform.add(RecoveryFormModel.fromMap(maps[i]));
    }
    if (kDebugMode) {
      print('Recovery form Raw data from database:');
    }
    for (var map in maps) {
      if (kDebugMode) {
        print(map);
      }
    }
    return recoveryform;
  }
  Future<int> add(RecoveryFormModel recoveryformModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(recoveryFormTableName, recoveryformModel.toMap());
  }
  Future<int> update(RecoveryFormModel recoveryformModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(recoveryFormTableName, recoveryformModel.toMap(),
        where: 'id = ?', whereArgs: [recoveryformModel.id]);
  }
  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(recoveryFormTableName,
        where: 'id = ?', whereArgs: [id]);
  }
}