import 'package:favorites/pages/favorites.dart';
import 'package:favorites/pages/listpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoBottomNav extends StatelessWidget {
  const CupertinoBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home_filled,
                size: 28,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.storage_rounded,
                size: 28,
              ),
              label: 'Favorites'),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(builder: (context) => const ListPage());
          case 1:
          default:
            return CupertinoTabView(builder: (context) => const Favorites());
        }
      },
    );
  }
}
