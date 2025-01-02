

import 'package:flutter/foundation.dart';

import '../Database/Util.dart';
import '../model/shop_visit_model.dart';
import '../database/dp_helper.dart';
class ShopVisitRepository{
  DBHelper dbHelper = DBHelper();
  Future<List<ShopVisitModel>> getShopVisit() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(shopVisitTableName,columns: ['id','brand','shopName','shopAddress','ShopOwner','bookerName','addPhoto','feedback' ]);
    List<ShopVisitModel> shopvisit = [];
    for(int i = 0; i<maps.length; i++)
    {
      shopvisit.add(ShopVisitModel.fromMap(maps[i]));
    }
    if (kDebugMode) {
      print('Raw data from Shop Visit Table database:');
    }
    for (var map in maps) {
      if (kDebugMode) {
        print(map);
      }
    }
    return shopvisit;
  }
  Future<int> add(ShopVisitModel shopvisitModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(shopVisitTableName, shopvisitModel.toMap());
  }
  Future<int> update(ShopVisitModel shopvisitModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(shopVisitTableName, shopvisitModel.toMap(),
        where: 'id = ?', whereArgs: [shopvisitModel.id]);
  }
  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(shopVisitTableName,
        where: 'id = ?', whereArgs: [id]);
  }
}