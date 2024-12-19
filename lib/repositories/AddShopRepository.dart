import '../database/Util.dart';
import '../model/AddShopModel.dart';
import '../database/DBHelper.dart';
class AddShopRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<AddShopModel>> getAddShop() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableName,columns: ['id','shopName','city','shopAddress','ownerName','ownerCNIC','phoneNumber','alterPhoneNumber' ]);
    List<AddShopModel> addShop = [];
    for(int i = 0; i<maps.length; i++)
    {
      addShop.add(AddShopModel.fromMap(maps[i]));
    }
    return addShop;
  }

  Future<int> add(AddShopModel addShopModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableName, addShopModel.toMap());
  }

  Future<int> update(AddShopModel addShopModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableName, addShopModel.toMap(),
        where: 'id = ?', whereArgs: [addShopModel.id]);
  }

  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableName,
        where: 'id = ?', whereArgs: [id]);
  }

}