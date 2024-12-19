import '../model/ShopVisitModel.dart';
import '../database/DBHelper.dart';
import '../database/Util.dart';

class ShopVisitRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ShopVisitModel>> getShopVisit() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableName,columns: ['id','shopName','city','shopAddress','ownerName','ownerCNIC','phoneNumber','alterPhoneNumber' ]);
    List<ShopVisitModel> shopvisit = [];
    for(int i = 0; i<maps.length; i++)
    {
      shopvisit.add(ShopVisitModel.fromMap(maps[i]));
    }
    return shopvisit;
  }

  Future<int> add(ShopVisitModel shopvisitModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableName, shopvisitModel.toMap());
  }

  Future<int> update(ShopVisitModel shopvisitModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableName, shopvisitModel.toMap(),
        where: 'id = ?', whereArgs: [shopvisitModel.id]);
  }

  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableName,
        where: 'id = ?', whereArgs: [id]);
  }

}