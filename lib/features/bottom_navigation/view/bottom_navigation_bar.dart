import '../../home/view/home_screen.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_constants.dart';
import '../../blog/view/categories_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.screenIndex});

  static const String home = '/home_screen';
  static const String discover = '/discover_screen';
  final int screenIndex;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: kPrimaryColour,
        unselectedItemColor: Colors.grey,
        selectedIconTheme: const IconThemeData(color: kPrimaryColour),
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(_selectedIndex == 0 ? Icons.home_outlined : Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Discover',
            icon: Icon(
              _selectedIndex == 1 ? Icons.search_outlined : Icons.search,
            ),
          ),
          // BottomNavigationBarItem(
          //   label: '',
          //   icon: SizedBox(
          //     height: 55,
          //     child: ElevatedButton(
          //       onPressed: () {
          //         print("object");
          //       },
          //       style: ElevatedButton.styleFrom(
          //         elevation: 2,
          //         backgroundColor: kPrimaryColour,
          //         foregroundColor: Colors.white,
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.all(Radius.circular(20)),
          //         ),
          //         iconColor: Colors.white,
          //       ),
          //       child: Icon(Icons.add),
          //     ),
          //   ),
          // ),
          BottomNavigationBarItem(
            label: 'Saved',
            icon: Icon(
              _selectedIndex == 3
                  ? Icons.bookmark_border_outlined
                  : Icons.bookmark_border,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              _selectedIndex == 4 ? Icons.person_2_outlined : Icons.person_2,
            ),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (selectedIndex) => _onItemTapped(selectedIndex),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [HomeScreen(), CategoriesScreen()],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: kPrimaryColour,
      //   foregroundColor: Colors.white,
      //   child: Icon(Icons.add),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void initState() {
    setState(() {
      _selectedIndex = widget.screenIndex;
    });
    super.initState();
  }

  _onItemTapped(int index) {
    if (index == 0 || index == 1) {
      setState(() {
        _selectedIndex = index;
      });
      return;
    }
  }
}
