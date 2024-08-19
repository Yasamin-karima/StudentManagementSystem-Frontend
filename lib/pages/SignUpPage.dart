
import 'package:flutter/material.dart';
import 'package:project_front_end/NavigationBar.dart';
import 'package:project_front_end/buttons.dart';

import '../Forms.dart';
import '../SocketMethods.dart';

class SignUpPage extends StatelessWidget{
  static bool _checkExists = false;

  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return Scaffold(
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
              stops: const [0.27, 0.5, 0.75, 0.97]

          ),
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
                child: Container(
                  width: widthOfScreen - widthOfScreen * 0.05,
                  height: 0.5 * heightOfScreen,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(90, 78, 128, 152),
                      borderRadius: BorderRadius.all(Radius.circular(15))
                  ),
                )
            ),//blue background
            Positioned(
              left: (widthOfScreen-170) / 2,
              top: 0.33 * heightOfScreen + 20,
              child: const Text(
                "حساب جدید ایجاد کنید",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    fontFamily: 'iransans'
                ),
              ),
            ),//text"حساب جدید"
            Positioned(
              left: 0.1 * widthOfScreen,
              top: 0.4 * heightOfScreen, //0.33 + 0.16*0.5
              child: NameForm(),
            ),//form-Name
            Positioned(
              left: 0.1 * widthOfScreen,
              top: 0.4 * heightOfScreen + 60, //0.33 + 0.16*0.5
              child: IdForm(),
            ),//form-studentId
            Positioned(
              left: 0.1 * widthOfScreen,
              top: 0.4 * heightOfScreen + 120, //0.33 + 0.16*0.5
              child: const PasswordForm(),
            ),//form-password
            Positioned(
              top: heightOfScreen * 0.615,
              left: (widthOfScreen - 130) / 2,
              child: const SignUpButton(),
            ),//"ثبت نام"button
            Positioned(
                top: heightOfScreen * 0.69,
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
              top: heightOfScreen * 0.725,
              left: (widthOfScreen - 147) / 2,
              child: const LoginPageNavigateButton(),
            ),//button"ورود"
            Positioned(
                left: 0.1 * widthOfScreen,
                width: 0.8 * widthOfScreen,
                top: 0.725 * heightOfScreen + 58,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (_checkExists) ? const Text('شما حساب دارید، وارد شوید') : const Text('')
                  ],
                )
            ),
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
    );
  }

  static void setCheckExists(bool status){
    _checkExists = status;
  }
}


class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  static const Color darkBlue = Color.fromARGB(255, 78, 128, 152);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            color: darkBlue
        ),
        child: TextButton(
          onPressed: () async {
            String res = await SocketMethods.studentSignUp();
            print(res);
            switch(res){
              case '409': SignUpPage.setCheckExists(true); print(409);break;
              case '201': SignUpPage.setCheckExists(false); print(201);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(2)));
            }
          },
          child: const Text(
            "ثبت نام",
            style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontFamily: 'iransans'
            ),
          ),
        )
    );
  }
}