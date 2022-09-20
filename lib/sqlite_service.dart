import 'package:cashflow_sertifikasi/data.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SqliteService {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE Dana(id INTEGER PRIMARY KEY AUTOINCREMENT, 
    tanggal TEXT NOT NULL,  
    jumlah INTEGER NOT NULL, 
    status INTEGER NOT NULL, 
    keterangan TEXT NOT NULL)
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'newdb.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Create new item (dana)
  static Future<int> createItem(Dana dana) async {
    final db = await SqliteService.db();
    final result = await db.insert(
      'Dana', dana.toMap(), 
      conflictAlgorithm: ConflictAlgorithm.replace);
    print('add new data $result');
    return result;
  }

  static Future<List<Map<String, dynamic>>> getAll() async {
    final db = await SqliteService.db();
    print(db.query('Dana'));
    return db.query('Dana');
  }

  static Future<int> getExpanseTotal()async {
    final db = await SqliteService.db();
    var total=0;
    db.query('Dana');
    List<Map<String, dynamic>> listDana = await SqliteService.getAll();
    for (var i = 0; i < listDana.length; i++) {
      if (listDana[i]['status'] == 0) {
        var cash = listDana[i]['jumlah'].toString();

        total += int.parse(cash);
      }
    }
    // print(total.toString());
    return total;
  }

  static Future<int> getIncomeTotal()async {
    final db = await SqliteService.db();
    var total1=0;
    db.query('Dana');
    List<Map<String, dynamic>> listDana = await SqliteService.getAll();
    for (var i = 0; i < listDana.length; i++) {
      if (listDana[i]['status'] == 1) {
        var cash = listDana[i]['jumlah'].toString();

        total1 += int.parse(cash);
      }
    }
    // print(total1.toString());
    return total1;
  }
  
}