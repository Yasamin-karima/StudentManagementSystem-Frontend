import 'package:flutter/material.dart';
import 'package:project_front_end/pages/AssignPage.dart';
import 'package:project_front_end/pages/Courses.dart';
import 'package:project_front_end/pages/HomePage.dart';
import 'package:project_front_end/pages/NewsPage.dart';
import 'package:project_front_end/pages/ProfilePage.dart';
import 'package:project_front_end/pages/TodoPage.dart';


class MainPage extends StatefulWidget {
  int currentIndex = 0;
  MainPage(this.currentIndex, {super.key});

  @override
  _MainPageState createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {

  final List<Widget> _tabs = [
    NewsPage(),
    const TodoPage(),
    HomePage(),
    AssignPage('SJF'),
    const Courses(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[widget.currentIndex],

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

        selectedIndex: widget.currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            widget.currentIndex = index;
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

