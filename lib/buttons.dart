import 'package:flutter/material.dart';
import 'package:project_front_end/pages/LoginPage.dart';
import 'package:project_front_end/SocketMethods.dart';
import 'package:project_front_end/pages/SignUpPage.dart';
import 'package:url_launcher/url_launcher.dart';



class LoginPageNavigateButton extends StatelessWidget {
  static const Color darkBlue = Color.fromARGB(255, 78, 128, 152);
  const LoginPageNavigateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: darkBlue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: const Text(
                "وارد شوید",
                style: TextStyle(fontSize: 16, fontFamily: 'iransans', color: Colors.black),
              ),
            ),
          ],
        ));
  }
}

class SignUpPageNavigateButton extends StatelessWidget {
  static const Color darkBlue = Color.fromARGB(255, 78, 128, 152);

  const SignUpPageNavigateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), color: darkBlue),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage()));
              },
              child: const Text(
                "ثبت ‌نام کنید",
                style: TextStyle(fontSize: 16, fontFamily: 'iransans', color: Colors.black),
              ),
            ),
          ],
        ));
  }
}

class sbuWebsiteViewButton extends StatefulWidget {
  const sbuWebsiteViewButton({super.key});

  @override
  State<sbuWebsiteViewButton> createState() => _sbuWebsiteViewButtonState();
}
class _sbuWebsiteViewButtonState extends State<sbuWebsiteViewButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => setState(() {
        _launchInBrowser(Uri.parse("https://lms2.sbu.ac.ir"));
      }),
      child: Text(
        "ورود به سایت دانشگاه",
        style: TextStyle(
            color: Colors.lightBlue.shade800,
            fontFamily: 'iransans',
            fontSize: 12,
            decoration: TextDecoration.underline,
            decorationColor: Colors.lightBlue.shade800),
      ),
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

class ChangePasswordButton extends StatefulWidget {
  const ChangePasswordButton({super.key});

  @override
  State<ChangePasswordButton> createState() => _ChangePasswordButtonState();
}
class _ChangePasswordButtonState extends State<ChangePasswordButton> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    final _passController = TextEditingController();

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    const darkBlue = Color.fromARGB(255, 78, 128, 152);

    return Container(
        width: widthOfScreen * 0.3,
        height: heightOfScreen * 0.05,
        decoration: BoxDecoration(color: darkBlue, borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('تغییر رمز عبور'),
                      content: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _passController,
                          decoration: const InputDecoration(
                            labelText: 'رمز جدید',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'رمز جدید را وارد کنید';
                            }
                            return null;
                          },
                        ),
                      ),
                      actions: [
                        TextButton(
                          child: const Text('تایید'),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              SocketMethods.changePassword(_passController.text);
                              _passController.clear();
                              setState(() {});
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                      ],
                    ));
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'تغییر رمز عبور',
                style:
                    TextStyle(fontFamily: 'iransans', color: Colors.black, fontSize: 11, fontWeight: FontWeight.w400),
              ),
              Icon(
                Icons.key,
                color: Colors.grey,
              )
            ],
          ),
        ));
  }
}

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    const darkBlue = Color.fromARGB(255, 78, 128, 152);

    return Container(
        width: widthOfScreen * 0.3,
        height: heightOfScreen * 0.05,
        decoration: BoxDecoration(color: darkBlue, borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onDoubleTap: () {
            print("jhgdfd");
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('آیا از حذف کامل حساب خود مطمئن هستید؟', textAlign: TextAlign.right,),
                actions: [
                  TextButton(
                      onPressed: () {
                        SocketMethods.deleteAccount();
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                      }, 
                      child: const Text('بله،‌ مطمئنم')
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('نه، حذف نمیکنم')
                  )
                ],
              ),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'حذف حساب ',
                style:
                    TextStyle(fontFamily: 'iransans', color: Colors.black, fontSize: 11, fontWeight: FontWeight.w400),
              ),
              Icon(
                Icons.delete_forever_outlined,
                color: Colors.grey,
              ),
            ],
          ),
        ));
  }

  void showAccountRemoveAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text(
              'حساب خود را حذف میکنید؟',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'iransans', fontSize: 18, color: LoginButton.darkBlue),
            ),
            content: const Text(
              'در صورت حذف حساب، تمامی اطلاعات شما پاک شده و دیگر قابل دسترسی نمیباشد. آیا از حذف حساب مطمئنید؟',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'iransans', fontSize: 12, color: Colors.black),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'بله، حذف میکنیم',
                      style: TextStyle(
                          fontFamily: 'iransans', fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'خیر، حذف نمیکنم',
                        style: TextStyle(
                            fontFamily: 'iransans',
                            fontSize: 12,
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          );
        });
  }
}

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    const darkBlue = Color.fromARGB(255, 78, 128, 152);

    return Container(
        width: widthOfScreen * 0.3,
        height: heightOfScreen * 0.05,
        decoration: BoxDecoration(color: darkBlue, borderRadius: BorderRadius.circular(20)),
        child: InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('آیا خارج میشوید؟', textAlign: TextAlign.right,),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                      },
                      child: const Text('بله')
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: const Text('خیر')
                  )
                ],
              ),
            );
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'خروج',
                style:
                    TextStyle(fontFamily: 'iransans', color: Colors.black, fontSize: 11, fontWeight: FontWeight.w400),
              ),
              Icon(
                Icons.logout_outlined,
                color: Colors.grey,
              ),
            ],
          ),
        ));
  }

  void showAccountRemoveAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text(
              'حساب خود را حذف میکنید؟',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'iransans', fontSize: 18, color: LoginButton.darkBlue),
            ),
            content: const Text(
              'در صورت حذف حساب، تمامی اطلاعات شما پاک شده و دیگر قابل دسترسی نمیباشد. آیا از حذف حساب مطمئنید؟',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'iransans', fontSize: 12, color: Colors.black),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      SocketMethods.deleteAccount();
                    },
                    child: const Text(
                      'بله، حذف میکنیم',
                      style: TextStyle(
                          fontFamily: 'iransans', fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'خیر، حذف نمیکنم',
                        style: TextStyle(
                            fontFamily: 'iransans',
                            fontSize: 12,
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ],
          );
        });
  }
}
