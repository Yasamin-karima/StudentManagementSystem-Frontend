
import 'package:flutter/material.dart';
import 'package:project_front_end/NavigationBar.dart';
import 'package:project_front_end/buttons.dart';

import '../Forms.dart';
import '../SocketMethods.dart';

class LoginPage extends StatelessWidget{

  static bool _checkId = false, _checkPass = false;

  const LoginPage({super.key});

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
              left: 0.1 * widthOfScreen,
              width: 0.8 * widthOfScreen,
              top: 0.5 * heightOfScreen + 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_checkId && _checkPass)// wrong id
                      const Text('نام کاربری نامعتبر، لطفا ثبت نام کنید')
                    else if (_checkId && !_checkPass)// wrong pass
                      const Text('رمز عبور اشتباه است، دوباره تلاش کنید')
                    else// successful login
                      const Text('')
                  ],
                )
            ),
            Positioned(
              top: heightOfScreen * 0.605,
              left: (widthOfScreen - 130) / 2,
              child: const InkWell(
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
                child: SignUpPageNavigateButton(),
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
    );
  }

  static void setCheckIdPass(bool id, bool pass){
    _checkId = id; _checkPass = pass;
  }
}


class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

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
            String res = await SocketMethods.studentLogin();
            switch(res){
              case '401': LoginPage.setCheckIdPass(true, false);print(401);break;
              case '404': LoginPage.setCheckIdPass(false, false);print(404);break;
              case '200': LoginPage.setCheckIdPass(true, true);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(2)));
            }
          },
          child: const Text(
            "ورود",
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