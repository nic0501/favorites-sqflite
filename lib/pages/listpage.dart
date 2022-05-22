import 'package:favorites/model/item.dart';
import 'package:favorites/pages/favorites.dart';
import 'package:favorites/pages/item_dtl.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// This is the page where user is albe to store individuall list items as favorites.

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  TextEditingController searchController = TextEditingController();
  List<TestItems> shownList = <TestItems>[
    TestItems(name: 'Test', id: 1),
    TestItems(name: 'Test2', id: 2),
    TestItems(name: 'Test3', id: 3)
  ];
  List<TestItems> initialData = <TestItems>[
    TestItems(name: 'Test', id: 1),
    TestItems(name: 'Test2', id: 2),
    TestItems(name: 'Test3', id: 3)
  ];

  void queryPeople(String queryString) {
    if (kDebugMode) {
      print("queryString = $queryString");
    }

    setState(() {
      shownList = initialData.where((string) {
        if (string.name.toLowerCase().contains(queryString.toLowerCase())) {
          return true;
        } else {
          return false;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: Column(
        children: <Widget>[
          TextButton.icon(
            label: const Text('Favorites'),
            icon: const Icon(
              Icons.storage,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Favorites()),
              );
            },
          ),
          Expanded(
            child: ItemList(
              item: shownList,
            ),
          ),
        ],
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<TestItems> item;

  const ItemList({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: item.length,
      itemBuilder: (context, index) {
        var items = item[index];
        var name = items.name;
        return ListTile(
          title: Text(
            name,
          ),
          onTap: () {
            items.id = index;
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ItemDtl(
                        id: index,
                        items: items,
                      )),
            );
          },
        );
      },
    );
  }
}
