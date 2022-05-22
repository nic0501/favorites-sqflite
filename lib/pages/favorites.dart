// ignore_for_file: deprecated_member_use

import 'package:favorites/model/item.dart';
import 'package:favorites/pages/item_dtl.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// This is the page where the stored favorite items are displayed.
//You will see that it only refreshes the page when I restart the app.
//I think this is caused by the CupertinoBottomNavigationBar as it works properly with the Material on.
// But I would like to keep the CupertinoBar as I want it to be shown on every page

// Thank you so much for you support!!!

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {
  // ignore: prefer_typing_uninitialized_variables
  var database;
  List<TestItems> items = <TestItems>[];

  Future initDb() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'person_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE person(id INTEGER PRIMARY KEY,  name TEXT)",
        );
      },
      version: 1,
    );

    getMechanism().then((value) {
      setState(() {
        items = value;
      });
    });
  }

  Future<List<TestItems>> getMechanism() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('person');
    return List.generate(maps.length, (i) {
      return TestItems(
        id: maps[i]['id'],
        name: maps[i]['name'] as String,
      );
    });
  }

  Future<void> deleteDB(int id) async {
    final db = await database;
    await db.delete(
      'person',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Future<void> updateDB(Mechanism person) async {
  //   final db = await database;

  //   await db.update(
  //     'person',
  //     where: "id = ?",
  //     whereArgs: [person.id],
  //   );
  // }

  @override
  void initState() {
    super.initState();
    initDb();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
      ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            var item = items[index];
            return ListTile(
              title: Text(
                item.name,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ItemDtl(items: item, id: index)),
                );
              },
              trailing: IconButton(
                color: Colors.red,
                icon: const Icon(Icons.delete_forever_rounded),
                onPressed: () {
                  deleteDB(item.id).then((value) {
                    getMechanism().then((value) {
                      setState(() {
                        items = value;
                      });
                    });
                  });
                },
              ),
            );
          }),
    );
  }
}
