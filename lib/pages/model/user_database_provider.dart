import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:yuru_kazan/pages/model/user_info.dart';

class UserDatabaseProvider {
  String _userDatabaseName = "User";
  String _userTableName = "UserInfo";
  late Database database;

  String columnId = "id";
  String columnMesafe = "mesafe";
  String columnSure = "sure";

  Future<void> open() async {
    database = await openDatabase(
      _userDatabaseName,
      onCreate: createTable,
    );
  }

  Future<void> createTable(db, version) async {
    await db.execute(
      'CREATE TABLE $_userTableName (id INTEGER PRIMARY KEY, $columnSure TIME, $columnMesafe DOUBLE)',
    );
  }

  Future<List<UserInfo>> getList() async {
    if (database == null) open();

    List<Map> userInfoMaps = await database.query(_userTableName);

    return userInfoMaps.map((e) => UserInfo.fromJson(e)).toList();
  }

  Future<UserInfo?> getItem(int id) async {
    if (database == null) open();

    final userInfoMaps = await database.query(_userTableName,
        where: '$columnId = ?', columns: [columnId], whereArgs: [id]);

    if (userInfoMaps.isNotEmpty) {
      return UserInfo.fromJson(userInfoMaps.first);
    } else {
      return null;
    }
  }

  Future<bool?> delete(int id) async {
    if (database == null) open();

    final userInfoMaps = await database
        .delete(_userTableName, where: '$columnId = ?', whereArgs: [id]);

    return userInfoMaps != null;
  }

  Future<bool?> insert(UserInfo userInfo) async {
    if (database == null) open();

    final userInfoMaps =
        await database.insert(_userTableName, userInfo.toJson());

    return userInfoMaps != null;
  }

  Future<bool?> update(int id, UserInfo userInfo) async {
    if (database == null) open();

    final userInfoMaps = await database.update(
        _userTableName, userInfo.toJson(),
        where: '$columnId = ?', whereArgs: [id]);

    return userInfoMaps != null;
  }

  Future<void> close() async {
    await database.close();
  }
}
