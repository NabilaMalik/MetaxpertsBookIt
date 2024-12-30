import 'package:order_booking_app/Database/Util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart'  show join;
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DBHelper{
 /// In Dart, the underscore (_) at the beginning of a variable or method name indicates private access.
  /// This means the variable or method is only accessible within the file in which it is declared.
  /// Like Encapsulation process

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
    String path = join(documentDirectory.path,'bookIt.db');
    var db = openDatabase(path,version: 1,onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version){
    db.execute("CREATE TABLE $orderMasterTableName(id INTEGER PRIMARY KEY,shopName TEXT,ownerName TEXT, phoneNumber TEXT,brand TEXT,total INGEGER, creditLimit TEXT, requiredDelivery TEXT)");
    // Database Table
    db.execute("CREATE TABLE $addShopTableName(id INTEGER PRIMARY KEY, shopName TEXT,city SELECTED,shopAddress TEXT,ownerName TEXT,ownerCNIC TEXT,phoneNumber TEXT, alterPhoneNumber TEXT )");
    db.execute("CREATE TABLE $shopVisitTableName(id INTEGER PRIMARY KEY, brand TEXT, shopName TEXT, shopAddress TEXT, ShopOwner TEXT, bookerName TEXT,photoPath TEXT, feedback TEXT, shopId TEXT)");

    //print('Order Master table Name: $orderMasterTableName');

    db.execute("CREATE TABLE $orderDetailsTableName (id INTEGER PRIMARY KEY, product TEXT, quantity TEXT, inStock INTEGER, rate REAL, amounT REAL, orderMasterId INTEGER, FOREIGN KEY(orderMasterId) REFERENCES $orderMasterTableName(id))");
    db.execute("CREATE TABLE $returnFormMasterTableName(returnMasterId INTEGER PRIMARY KEY, selectShop TEXT)");
    db.execute("CREATE TABLE $returnFormDetailsTableName(id INTEGER PRIMARY KEY, returnMasterId INTEGER, item TEXT, qty INTEGER, reason TEXT, FOREIGN KEY(returnMasterId) REFERENCES $returnFormMasterTableName(returnMasterId))");
    db.execute("CREATE TABLE $recoveryFormTableName(id INTEGER PRIMARY KEY, shopName TEXT,date TEXT,currentBalance TEXT)");
  }

}

