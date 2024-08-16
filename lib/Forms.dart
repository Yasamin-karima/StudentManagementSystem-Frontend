
import 'package:flutter/material.dart';
import 'package:project_front_end/SocketMethods.dart';


class IdForm extends StatelessWidget{


  final Color darkBlue = const Color.fromARGB(255, 78, 128, 152);
  final Color lighterBlue = const Color.fromARGB(170, 78, 128, 152);

  TextEditingController userId = TextEditingController();
  String hintText = "شماره دانشجویی";
  bool isEditTexComplete = false;

  @override
  Widget build(BuildContext context) {



    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return SizedBox(
      width: widthOfScreen * 0.8,
      height: 50,
      child: TextFormField(
        // controller: userId,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: hintText,
          labelStyle: TextStyle(
            fontFamily: 'iransans',
              fontSize: 13,
              color: lighterBlue,
              fontWeight: FontWeight.bold
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: darkBlue,
                  width: 2.5
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: darkBlue,
                  width: 2.5
              ),
              gapPadding: 8,
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
        ),
        onEditingComplete: () {isEditTexComplete = true;},
        onFieldSubmitted: (value) {
          if (isEditTexComplete) SocketMethods().setUserId(value);
        },// todo save ID even after focus disabled
      ),
    );

  }
}

class PasswordForm extends StatefulWidget{
  const PasswordForm({super.key});

  @override
  State<PasswordForm> createState() => _PasswordFormState();
}
class _PasswordFormState extends State<PasswordForm> {

  final Color lighterBlue = const Color.fromARGB(170, 78, 128, 152);
  final Color darkBlue = const Color.fromARGB(255, 78, 128, 152);

  TextEditingController password = TextEditingController();
  String hintText = "رمز عبور";
  bool isEditTexComplete = false;
  bool obscure = true;

  @override
  Widget build(BuildContext context) {

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return SizedBox(
      width: widthOfScreen * 0.8,
      height: 50,
      child: TextFormField(
        // controller: password,
        obscureText: obscure,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: hintText,
          labelStyle: TextStyle(
            fontFamily: 'iransans',
              fontSize: 13,
              color: lighterBlue,
              fontWeight: FontWeight.bold
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: darkBlue,
                  width: 2.5
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: darkBlue,
                  width: 2.5
              ),
              gapPadding: 8,
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscure ? Icons.visibility : Icons.visibility_off,
              color: Colors.grey,
            ),
            onPressed: () {
              setState(() {
                obscure = !obscure;
              });
            },
          )
        ),
        onEditingComplete: () {isEditTexComplete = true;},
        onFieldSubmitted: (value) {
          if (isEditTexComplete) SocketMethods().setPassword(value);
        },

      ),
    );
  }

}

class NameForm extends StatelessWidget{


  final Color darkBlue = const Color.fromARGB(255, 78, 128, 152);
  final Color lighterBlue = const Color.fromARGB(170, 78, 128, 152);

  TextEditingController userName = TextEditingController();
  String hintText = "نام و نام‌خانوادگی";
  bool isEditTexComplete = false;

  @override
  Widget build(BuildContext context) {



    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return SizedBox(
      width: widthOfScreen * 0.8,
      height: 50,
      child: TextFormField(
        // controller: userId,
        textAlign: TextAlign.left,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: hintText,
          labelStyle: TextStyle(
              fontFamily: 'iransans',
              fontSize: 13,
              color: lighterBlue,
              fontWeight: FontWeight.bold
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: darkBlue,
                  width: 2.5
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: darkBlue,
                  width: 2.5
              ),
              gapPadding: 8,
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
        ),
        onFieldSubmitted: (value) {
          SocketMethods().setName(value);
        },// todo save ID even after focus disabled
      ),
    );

  }
}