


import 'package:flutter/material.dart';
import 'package:project_front_end/pages/LoginPage.dart';

void main() {
  runApp( const MaterialApp(home: StartPage()));
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});


  @override
  Widget build(BuildContext context) {

    return const LoginPage();
  }
}
