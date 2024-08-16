import 'package:flutter/material.dart';
import 'package:project_front_end/buttons.dart';
import 'package:project_front_end/layers.dart';
import 'package:project_front_end/pages/Courses.dart';
import 'package:project_front_end/pages/LoginPage.dart';
import 'package:project_front_end/pages/SignUpPage.dart';
import 'package:project_front_end/pages/ProfilePage.dart';
import 'package:project_front_end/pages/HomePage.dart';
import 'package:project_front_end/pages/TodoPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Form.dart';


void main() {
  runApp( const MaterialApp(home: StartPage()));
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});


  @override
  Widget build(BuildContext context) {

    return LoginPage();
    /*return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blueGrey.shade200,
              Colors.blueGrey.shade100,
              Colors.blueGrey.shade100,
              Colors.blueGrey.shade200,
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.27, 0.5, 0.75, 0.97]

          ),
          // color: lightBlueBackground,
        ),
        child: Stack(
          children: [
            Positioned(
              top: heightOfScreen * 0.1,
              left: (widthOfScreen-120) / 2,
              child: const Text(
                "دانشجویار",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                  fontFamily: 'iransans'
                ),
              ),
            ),//text"دانشجویار"
            Positioned(
              top: 0.157 * heightOfScreen,
              width: 0.64 * widthOfScreen,
              left: 0.18 * widthOfScreen,
                child: Image.asset('images/students.png')
            ),//image
            Positioned(
                left: 0.025 * widthOfScreen,
                top: 0.33 * heightOfScreen,
                child: const LoginSecondLayer()
            ),//blue background
            Positioned(
              left: 0.25 * widthOfScreen,
              top: 0.33 * heightOfScreen + 30,
              child: const Text(
                "وارد حساب کاربری خود شوید",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  fontFamily: 'iransans'
                ),
              ),
            ),//text"وارد شوید"
            Positioned(
              left: 0.1 * widthOfScreen,
              top: 0.425 * heightOfScreen, //0.33 + 0.16*0.5
              child: IdForm(),
            ),//form-studentId
            Positioned(
              left: 0.1 * widthOfScreen,
              top: 0.42 * heightOfScreen + 70, //0.33 + 0.16*0.5
              child: const PasswordForm(),
            ),//form-password
            Positioned(
                top: heightOfScreen * 0.605,
                left: (widthOfScreen - 130) / 2,
                child: const InkWell(
                  // onTap: ,
                  child: LoginButton(),
                  ),
                ),//"ورود"button
            Positioned(
              top: heightOfScreen * 0.68,
                left:  (widthOfScreen - 310) / 2,
                child: Row(
                  children: [
                    Container(width: 100, height: 1, color: Colors.grey.shade600,),
                    Text("حساب کاربری ندارید؟", style: TextStyle(color: Colors.grey.shade800,fontFamily: 'iransans', fontSize: 11),),
                    Container(width: 100, height: 1, color: Colors.grey.shade600,)
                  ],
                )
            ),//line
            Positioned(
              top: heightOfScreen * 0.715,
              left: (widthOfScreen - 150) / 2,
              child: const InkWell(
                // onTap: ,
                child: SignUpButton(),
              ),
            ),//button"ثبت نام"
            Positioned(
              top: heightOfScreen * 0.85,
                left: (widthOfScreen - 140) / 2,
                child: Column(
                  children: [
                    const sbuWebsiteViewButton(),
                    SizedBox(
                      width: 60, height: 60,
                      child: Image.asset('images/SBULogo.png', color: Colors.black),
                    ),
                  ],
                ),
            )// downPage
          ],
        ),
      ),
    );*/
  }
}
