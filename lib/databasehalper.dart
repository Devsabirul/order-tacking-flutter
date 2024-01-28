import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    // Get the path to the database
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'salesmandb.db');

    // Open the database
    return await openDatabase(path, version: 1, onCreate: _createTables);
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE distributorinfo (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        distributorName TEXT,
        distributorAddress TEXT,
        name TEXT,
        number TEXT,
        companyName TEXT
      )
    ''');

    await db.execute(
        '''CREATE TABLE outletlist (id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,address TEXT,personName TEXT,number TEXT,outletType TEXT)''');

    await db.execute('''
          CREATE TABLE orders(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            orderId INTEGER,
            date TEXT,
            outletName TEXT,
            outletAddress TEXT,
            totalAmount REAL,
            remark TEXT
          )
        ''');

    await db.execute('''
          CREATE TABLE order_items(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            orderId INTEGER,
            itemName TEXT,
            price REAL,
            quantity REAL,
            FOREIGN KEY (orderId) REFERENCES orders(id)
          )
        ''');
  }
}
