import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final String role;

  const BottomNav({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.role,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [];

    if (role == "user") {
      items = const [
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: 'Playlist',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add Song',
        ),
      ];
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.green[700],
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      items: items,
      type: BottomNavigationBarType.fixed, 
    );
  }
}
