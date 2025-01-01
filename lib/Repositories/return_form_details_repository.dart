import 'package:flutter/foundation.dart';
import '../Database/Util.dart';
import '../Model/returnform_details_model.dart';
import '../database/dp_helper.dart';
class ReturnFormDetailsRepository{
  DBHelper dbHelper = DBHelper();
  Future<List<ReturnFormDetailsModel>> getReturnFormDetails() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(returnFormDetailsTableName,columns: ['id','item','qty','reason','returnMasterId']);
    List<ReturnFormDetailsModel> returnformdetails = [];
    for(int i = 0; i<maps.length; i++)
    {
      returnformdetails.add(ReturnFormDetailsModel.fromMap(maps[i]));
    }
    if (kDebugMode) {
      print('Return Form Details Raw data from database:');
    }
    for (var map in maps) {
      if (kDebugMode) {
        print(map);
      }
    }
    return returnformdetails;
  }
  Future<int> add(ReturnFormDetailsModel returnformdetailsModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(returnFormDetailsTableName, returnformdetailsModel.toMap());
  }
  Future<int> update(ReturnFormDetailsModel returnformdetailsModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(returnFormDetailsTableName, returnformdetailsModel.toMap(),
        where: 'id = ?', whereArgs: [returnformdetailsModel.id]);
  }
  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(returnFormDetailsTableName,
        where: 'id = ?', whereArgs: [id]);
  }
}