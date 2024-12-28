import 'package:flutter/foundation.dart';


import '../Database/Util.dart';
import '../model/add_shop_model.dart';
import '../database/dp_helper.dart';
class AddShopRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<AddShopModel>> getAddShop() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(addShopTableName,columns: ['id','shopName','city','shopAddress','ownerName','ownerCNIC','phoneNumber','alterPhoneNumber' ]);
    List<AddShopModel> addShop = [];
    for(int i = 0; i<maps.length; i++)
    {
      addShop.add(AddShopModel.fromMap(maps[i]));
    }
    if (kDebugMode) {
      print('Raw data from database:');
    }
    for (var map in maps) {
      if (kDebugMode) {
        print(map);
    }
    }
    return addShop;

  }

  Future<int> add(AddShopModel addShopModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(addShopTableName, addShopModel.toMap());
  }

  Future<int> update(AddShopModel addShopModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(addShopTableName, addShopModel.toMap(),
        where: 'id = ?', whereArgs: [addShopModel.id]);
  }

  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(addShopTableName,
        where: 'id = ?', whereArgs: [id]);
  }

}