// import 'package:member_site_app/common/db/models/KeywordLocal.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
//
// class DbManager {
//   static Database? _database;
//   static const String COLUMN_ID = 'id';
//   static const String COLUMN_QUANTITY_PRODUCT = 'quantityProduct';
//   static const String COLUMN_QUANTITY_PRODUCT_CHECK_SHOW_MAKER = 'quantityProductCheckShowMaker';
//   static const String COLUMN_IS_ENABLED_KEYWORD = 'isEnabledKeyword';
//   static const String TABLE_KEYWORDS_LOCAL = 'keywords_local';
//
//   static const String DB_NAME = 'app.db';
//   static const int DB_VERSION = 1;
//
//   DbManager._privateConstructor();
//   static final DbManager instance = DbManager._privateConstructor();
//
//   Future<Database?> get database async {
//     if (_database != null) return _database;
//     // lazily instantiate the db the first time it is accessed
//     _database = await initDb();
//     return _database;
//   }
//
//   initDb() async {  //init db
//     print('init db local');
//     String pathSaveDb = await getDatabasesPath();
//     String path = join(pathSaveDb, DB_NAME);
//     var db = await openDatabase(path, version: DB_VERSION, onCreate: _onCreate);
//     return db;
//   }
//
//   _onCreate(Database db, int version) async { //tạo database
//     await db.execute("CREATE TABLE $TABLE_KEYWORDS_LOCAL ($COLUMN_ID INTEGER PRIMARY KEY, $COLUMN_QUANTITY_PRODUCT INTEGER, $COLUMN_QUANTITY_PRODUCT_CHECK_SHOW_MAKER INTEGER, $COLUMN_IS_ENABLED_KEYWORD INTEGER)");
//   }
//
//   Future closeDb() async {
//     Database? db = await instance.database;
//     db?.close();
//   }
//
//   Future clearTable() async {
//     Database? db = await instance.database;
//     db?.delete(TABLE_KEYWORDS_LOCAL);
//   }
//
//   Future<void> deleteDatabase(String path) =>
//       databaseFactory.deleteDatabase(path);
//
//   /*TABLE_KEYWORDS_LOCAL*/
//   Future<int?> insertItem(KeywordLocal keywordLocal) async {
//     Database? db = await instance.database;
//     return await db?.insert(TABLE_KEYWORDS_LOCAL, keywordLocal.toMapAll(), conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<int?> updateItem(KeywordLocal keywordLocal) async {
//     Database? db = await instance.database;
//     print('update $COLUMN_ID: ${keywordLocal.id}');
//     return await db?.update(TABLE_KEYWORDS_LOCAL, keywordLocal.toMapAll(), where: "$COLUMN_ID = ?", whereArgs: [keywordLocal.id]);
//   }
//
//
//   Future<void> deleteItem(int keywordLocalId) async {
//     Database? db = await instance.database;
//     await db?.delete(TABLE_KEYWORDS_LOCAL, where: "$COLUMN_ID = ?", whereArgs: [keywordLocalId]);
//   }
//
//   Future<int?> getQuantityProductQueryById(int id) async {
//     Database? db = await instance.database;
//     List<Map>? res = await db?.query(TABLE_KEYWORDS_LOCAL, where: "$COLUMN_ID = ?", whereArgs: [id]);
//     if (res != null) {
//       if (res.length == 0) {
//         return null;
//       }
//       final map = res[0];
//       return map[COLUMN_QUANTITY_PRODUCT];
//     } else {
//       return null;
//     }
//   }
//
//   Future<int?> getQuantityCheckShowMakerProductQueryById(int id) async {
//     Database? db = await instance.database;
//     List<Map>? res = await db?.query(TABLE_KEYWORDS_LOCAL, where: "$COLUMN_ID = ?", whereArgs: [id]);
//     if (res != null) {
//       if (res.length == 0) {
//         return null;
//       }
//       final map = res[0];
//       return map[COLUMN_QUANTITY_PRODUCT_CHECK_SHOW_MAKER];
//     } else {
//       return null;
//     }
//   }
//
//   Future<List<KeywordLocal>?> getAll() async {
//     Database? db = await instance.database;
//     var res = await db?.query(TABLE_KEYWORDS_LOCAL);
//     if (res != null) {
//       List<KeywordLocal>? listKeywordsLocal = res.isNotEmpty ? res.map((e) => KeywordLocal.fromMapAll(e)).toList() : [];
//       return listKeywordsLocal;
//     } else {
//       return null;
//     }
//   }
//   /*END_TABLE_KEYWORDS_LOCAL*/
// }