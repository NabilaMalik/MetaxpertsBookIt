import '../Database/Util.dart';
import '../database/dp_helper.dart';
import '../model/re_confirm_order_model.dart';
class ReConfirmOrderRepository{
  DBHelper dbHelper = DBHelper();
  Future<List<ReConfirmOrderModel>> getReConfirmOrder() async{
    var dbClient = await dbHelper.db;
    List<Map> maps = await dbClient.query(orderDetailsTableName,columns: ['id','orderId','customerName','phoneNumber','description','qty','amount','total','creditLimit','required' ]);
    List<ReConfirmOrderModel> reconfirmorder = [];
    for(int i = 0; i<maps.length; i++)
    {
      reconfirmorder.add(ReConfirmOrderModel.fromMap(maps[i]));
    }
    return reconfirmorder;
  }
  Future<int> add(ReConfirmOrderModel reconfirmorderModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.insert(orderDetailsTableName, reconfirmorderModel.toMap());
  }
  Future<int> update(ReConfirmOrderModel reconfirmorderModel) async{
    var dbClient = await dbHelper.db;
    return await dbClient.update(orderDetailsTableName, reconfirmorderModel.toMap(),
        where: 'id = ?', whereArgs: [reconfirmorderModel.id]);
  }
  Future<int> delete(int id) async{
    var dbClient = await dbHelper.db;
    return await dbClient.delete(orderDetailsTableName,
        where: 'id = ?', whereArgs: [id]);
  }
}