import 'dart:async';
import 'package:sqflite/sqflite.dart';

final String tableUser = 'userTable';
final String columnId = '_id';
final String columnUsername = 'username';
final String columnPassword = 'password';
final String columnAge = 'age';
final String columnName = 'name';

class Userr {
  int id;
  String username;
  String password;
  String name;
  int age;

  Userr();

  Userr.fromMap(Map<String, dynamic> map) {
    this.id = map[columnId];
    this.username = map[columnUsername];
    this.password = map[columnPassword];
    this.name = map[columnName];
    this.age = map[columnAge];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnUsername: username,
      columnPassword: password,
      columnName: name,
      columnAge: age,
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "id:${this.id}, username:${this.username}, password:${this.password}, name:${this.name}, age:${this.age}";
  }
}

class UserUtils {
  Database db;

  Future open(String path) async {
    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
        create table $tableUser (
          $columnId integer primary key autoincrement,
          $columnUsername text not null unique,
          $columnPassword text not null,
          $columnName text not null,
          $columnAge integer not null,
        )
        ''');
      },
    );
  }

  Future<Userr> insert(Userr user) async {
    user.id = await db.insert(tableUser, user.toMap());
    return user;
  }

  Future<int> delete(int id) async {
    return await db.delete(tableUser, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Userr user) async {
    return await db.update(tableUser, user.toMap(),
        where: '$columnId = ?', whereArgs: [user.id]);
  }

  Future<List<Userr>> getAllUsers() async {
    await this.open('user.db');
    var getUser = await db.query(tableUser, columns: [
      columnId,
      columnUsername,
      columnPassword,
      columnName,
      columnAge,
    ]);

    List<Userr> users =
        getUser.isNotEmpty ? getUser.map((f) => Userr.fromMap(f)).toList() : [];
    return users;
  }

  Future close() async => db.close();
}
