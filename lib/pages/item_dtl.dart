import 'dart:async';
import 'package:favorites/model/item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';

// This is the Detailpage of the items

class ItemDtl extends StatefulWidget {
  const ItemDtl({Key? key, required this.items, required this.id})
      : super(key: key);

  final TestItems items;
  final int id;

  @override
  _ItemDtlState createState() => _ItemDtlState();
}

class _ItemDtlState extends State<ItemDtl> {
  // ignore: prefer_typing_uninitialized_variables
  var database;

  @override
  void initState() {
    super.initState();

    initDb();
  }

  Future initDb() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'person_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE person(id INTEGER PRIMARY KEY,  name TEXT, height TEXT, mass TEXT, hair_color TEXT, skin_color TEXT, eye_color TEXT, birth_year TEXT, gender TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertEntry(TestItems items) async {
    final Database db = await database;

    await db.insert(
      'person',
      items.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateDB(TestItems items) async {
    final db = await database;

    await db.update(
      'person',
      items.toMap(),
      where: "id = ?",
      whereArgs: [items.id],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.items.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.storage),
            label: const Text(
              "Add To Favorites",
            ),
            onPressed: () {
              insertEntry(widget.items);
            },
          ),
          Text(
            "Name: ${widget.items.name}",
          ),
        ]),
      ),
    );
  }
}
