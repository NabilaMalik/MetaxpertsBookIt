import 'package:flutter/foundation.dart';

import '../Database/Util.dart';
import '../Model/return_form_model.dart';
import '../database/dp_helper.dart';
class ReturnFormRepository{
  DBHelper dbHelper = DBHelper();
  Future<List<ReturnFormModel>> getReturnForm() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(returnFormMasterTableName,columns: ['returnMasterId','selectShop']);
    List<ReturnFormModel> returnform = [];
    for(int i = 0; i<maps.length; i++)
    {
      returnform.add(ReturnFormModel.fromMap(maps[i]));
    }
    if (kDebugMode) {
      print('Return form Raw data from database:');
    }
    for (var map in maps) {
      if (kDebugMode) {
        print(map);
      }
    }
    return returnform;
  }
  Future<int> add(ReturnFormModel returnformModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(returnFormMasterTableName, returnformModel.toMap());
  }
  Future<int> update(ReturnFormModel returnformModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(returnFormMasterTableName, returnformModel.toMap(),
        where: 'id = ?', whereArgs: [returnformModel.returnMasterId]);
  }
  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(returnFormMasterTableName,
        where: 'id = ?', whereArgs: [id]);
  }
}