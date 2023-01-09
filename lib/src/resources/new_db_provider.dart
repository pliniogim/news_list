import 'dart:io';
import 'dart:async';

import 'package:news/src/resources/repository.dart';
import 'package:path/path.dart' as p show join;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:sqflite/sqflite.dart' show Database, openDatabase;

import '../models/item_model.dart';

class NewsDbProvider implements Source, Cache {
  late Database db;

  NewsDbProvider() {
    init();
  }

  void init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = p.join(documentsDirectory.path, "items.db");

    db = await openDatabase(path, version: 1,
        onCreate: (Database newDb, int version) {
      newDb.execute("""
            CREATE TABLE Items (
              id INTEGER PRIMARY KEY,
              type TEXT,
              by TEXT,
              time INTEGER,
              text TEXT,
              parent INTEGER,
              kids BLOB,
              dead INTEGER, 
              deleted INTEGER,
              url TEXT,
              title TEXT,
              descendants INTEGER
            )
      """);
    });
  }

  @override
  Future<ItemModel?>? fetchItem(int id) async {
    final maps = await db.query(
      "Items",
      columns: null,
      where: "id = ?",
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ItemModel.fromDb(maps.first);
    } else {
      return null;
    }
  }

  @override
  Future<int> addItem(ItemModel item) {
    return db.insert("Items", item.toMap());
  }

  //TODO - store and fetch ids
  @override
  Future<List<int>>? fetchTopIds() {
    return null;
  }
}

final newsDbProvider = NewsDbProvider();
