import 'package:flutter/material.dart';
import 'package:project_front_end/pages/AssignPage.dart';
import 'package:project_front_end/pages/Courses.dart';
import 'package:project_front_end/pages/HomePage.dart';
import 'package:project_front_end/pages/NewsPage.dart';
import 'package:project_front_end/pages/ProfilePage.dart';
import 'package:project_front_end/pages/TodoPage.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<Widget> _tabs = [
    NewsPage(),
    TodoPage(),
    HomePage(),
    AssignPage('SJF'),
    const Courses(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[currentIndex],

      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(IconData(0xf0541, fontFamily: 'MaterialIcons')),
            label: 'خبرا',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline),
            label: 'کارا',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_filled),
            label: 'سرا',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_turned_in_outlined),
            label: 'تمرینا',
          ),
          NavigationDestination(
            icon: Icon(Icons.school_rounded),
            label: 'درسا',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_circle_sharp),
            label: 'پروفایل',
          ),
        ],

        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        backgroundColor: const Color.fromARGB(230, 195, 144, 108),
        animationDuration: const Duration(milliseconds: 800),
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        height: 75,
      )
    );
  }
}

