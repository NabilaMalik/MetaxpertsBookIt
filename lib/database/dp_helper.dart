import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'  show join;
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DBHelper{

  static Database? _db;

  Future<Database> get db async{
    if(_db != null)
    {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  initDatabase() async{
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path,'shopvisit.db');
    var db = openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version){
    // AddShop Database
    db.execute("CREATE TABLE addShop(id INTEGER PRIMARY KEY, shopName TEXT,city TEXT,shopAddress TEXT,ownerName TEXT,ownerCNIC TEXT,phoneNumber TEXT,alterPhoneNumber TEXT )");
    //ShopVisit Database
    db.execute("CREATE TABLE shopvisit(id INTEGER PRIMARY KEY, brand TEXT, shopName TEXT, shopAddress TEXT, ShopOwner TEXT, bookerName TEXT,photoPath TEXT, feedback TEXT, shopId TEXT)");
    //confirm order.
    db.execute("CREATE TABLE confirmorder(id INTEGER PRIMARY KEY, shopName TEXT, ownerName TEXT , phoneNumber TEXT, brand TEXT, total TEXT,credit TEXT, requireDelivery TEXT)");
    //Reconfirm Order
    db.execute("CREATE TABLE confirmorder(id INTEGER PRIMARY KEY, orderId TEXT, customerName TEXT, phoneNumber TEXT, description TEXT, qty TEXT,amount TEXT, total TEXT, creditLimit TEXT, required TEXT)");
  }

}