import '../database/Util.dart';
import '../database/DBHelper.dart';
import '../model/ConfirmOrderModel.dart';
class ConfirmOrderRepository{

  DBHelper dbHelper = DBHelper();

  Future<List<ConfirmOrderModel>> getConfirmOrder() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(tableName,columns: ['id','shopName','city','shopAddress','ownerName','ownerCNIC','phoneNumber','alterPhoneNumber' ]);
    List<ConfirmOrderModel> confirmorder = [];
    for(int i = 0; i<maps.length; i++)
    {
      confirmorder.add(ConfirmOrderModel.fromMap(maps[i]));
    }
    return confirmorder;
  }

  Future<int> add(ConfirmOrderModel confirmorderModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(tableName, confirmorderModel.toMap());
  }

  Future<int> update(ConfirmOrderModel confirmorderModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(tableName, confirmorderModel.toMap(),
        where: 'id = ?', whereArgs: [confirmorderModel.id]);
  }

  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(tableName,
        where: 'id = ?', whereArgs: [id]);
  }

}