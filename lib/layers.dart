


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginSecondLayer extends StatelessWidget{
  const LoginSecondLayer({super.key});


  @override
  Widget build(BuildContext context){

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return Container(
      width: widthOfScreen - widthOfScreen * 0.05,
      height: 0.5 * heightOfScreen,
      decoration: const BoxDecoration(
        color: Color.fromARGB(90, 78, 128, 152),
        borderRadius: BorderRadius.all(Radius.circular(15))
      ),
    );
  }
}