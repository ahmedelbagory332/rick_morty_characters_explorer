import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'entity/characters_local_model.dart';

class DbHelper{

  static Database? _db ;


  Future<Database?> get db async {
    if(_db == null){
      _db = await _createDatabase();
      return _db;
    }else{
      return _db;
    }
  }

  _createDatabase() async{
    //define the path to the database
    String path = join(await getDatabasesPath(), 'character.db');
    Database myDb = await openDatabase(path,version: 1, onCreate: _createDb);
    return myDb;
  }

  _createDb(Database db, int v) async{
    //create tables
    await db.execute(
        'create table characters(id integer primary key autoincrement, name varchar(50), species varchar(50), status varchar(50), avatar_image text)');
  }

  Future<int> insertCharacter(LocalCharacter character) async{
    Database? myDb = await db;
    return myDb!.insert('characters', character.toMap());
  }


  Future<List> allCharacters() async{
    Database? myDb = await db;
    return await  myDb!.query('characters');
  }

  Future<int> delete(int id) async{
    Database? myDb = await db;
    return  myDb!.delete('characters', where: 'id = ?', whereArgs: [id]);
  }

}