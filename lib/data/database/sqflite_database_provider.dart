import 'package:hrm_app/data/model/downloads.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if(_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async{
    return await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async{

        await db.execute("CREATE TABLE ${Downloads.downloadsTable} ("
            "id INTEGER PRIMARY KEY,"
            "title TEXT,"
            "logo TEXT,"
            "attachment TEXT,"
            "streamAttachment TEXT,"
            "createdBy TEXT,"
            "timeStamp TEXT,"
            "progress INTEGER"
            ")");
      }
    );
  }

  Future<List<Downloads>> getAllDownloads() async {
    final db = await database;
    final results = await db?.query(Downloads.downloadsTable,
        columns: Downloads.downloadsColumns, orderBy: "timeStamp Desc");
    List<Downloads> mediaList = [];
    results?.forEach((result) {
      Downloads media = Downloads.fromMap(result);
      mediaList.add(media);
    });
    return mediaList;
  }

  addNewDownloadItem(Downloads media) async {
    final db = await database;
    var result = await db?.rawInsert(
        "INSERT OR IGNORE Into ${Downloads.downloadsTable} (id,title,logo,attachment,streamAttachment,createdBy,timeStamp,progress)"
            " VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        [
          media.id,
          media.title,
          media.logo,
          media.attachment,
          media.streamAttachment,
          media.createdBy,
          media.timeStamp,
          media.progress
        ]);
    return result;
  }

  deleteDownloadMedia(int id) async {
    final db = await database;
    db?.delete(Downloads.downloadsTable, where: "id = ?", whereArgs: [id]);
  }
}