

import 'package:flutter/material.dart';
import 'package:profile_photo/profile_photo.dart';
import 'package:project_front_end/buttons.dart';
import 'package:project_front_end/classes/models.dart';

import '../NavigationBar.dart';
import '../SocketMethods.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Student? _student;

  @override
  void initState() {
    super.initState();
    fetchData(); // Call your method here
  }

  Future<void> fetchData() async {
    try {
      var data = await SocketMethods.getStudent();
      setState(() {
        _student = data;
      });
    } catch (e) {
      print('Error fetching student: $e');
    }
  }



  @override
  Widget build(BuildContext context) {

    const darkBlue = Color.fromARGB(255, 78, 128, 152);
    const lightBlueBackground = Color.fromARGB(255, 206, 211, 220);
    const anotherBlue = Color.fromARGB(90, 78, 128, 152);
    const orangeBack = Color.fromARGB(255, 195, 144, 108);

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: lightBlueBackground,
        child: Stack(
          children: [
            Positioned(
              top: 0, left: 0,right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: anotherBlue,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))
                  ),
                  height: heightOfScreen * 0.42,
                )
            ),
            Positioned(
              top: heightOfScreen * 0.085,
                left: (widthOfScreen - 140) / 2,
                child: Column(
                  children: [
                    ProfilePhoto(
                      totalWidth: 140,
                      cornerRadius: 100,
                      color: anotherBlue,
                      outlineWidth: 8,
                      image: const AssetImage('images/pic.png'),
                    ),
                    const SizedBox(height: 20),
                    Text(
                        _student?.name ?? "error",
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'iransans',
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "دانشجو",
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'iransans',
                        fontWeight: FontWeight.w100
                      ),
                    ),
                  ],
                )
            ),
            Positioned(
              top: 0.37 * heightOfScreen,
                left: widthOfScreen * 0.1,
                child: Container(
                  decoration: BoxDecoration(
                    color: orangeBack,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  height: 0.3 * heightOfScreen,
                  width: 0.8 * widthOfScreen,
                  child: Flex(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    direction: Axis.vertical,
                    children: [
                      //todo start of subjectTexts should be in a same vertical line
                      Flexible(child: ShowingDataBoxes('نام', _student?.name ?? "error")),
                      Flexible(child: ShowingDataBoxes('معدل', _student?.averageScore ?? "0.0"),),
                      Flexible(child: ShowingDataBoxes('واحد اخذ شده', _student?.totalUnits ?? "0"),),
                      Flexible(child: BirthDateWidget(_student?.dateOfBirth),),
                      Flexible(child: ShowingDataBoxes('شماره دانشجویی', _student?.id ?? "error"),),
                    ],
                  ),
                )
            ),
            Positioned(
                top: 0.72 * heightOfScreen,
                left: widthOfScreen * 0.1,
                child: Container(
                  decoration: BoxDecoration(
                      color: orangeBack,
                      borderRadius: BorderRadius.circular(30)
                  ),
                  height: 0.08 * heightOfScreen,
                  width: 0.8 * widthOfScreen,
                  child: const Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ChangePasswordButton(),
                      DeleteAccountButton(),
                    ],
                  ),
                )
            ),
            Positioned(
                top: 0.82 * heightOfScreen,
                left: widthOfScreen * 0.35,
                child: const LogoutButton()
            ),
          ],
        ),
      ),
      // bottomNavigationBar: const BottomBar(),
    );
  }
}

class ShowingDataBoxes extends StatelessWidget{

  final String subjectText, valueText;
  
  const ShowingDataBoxes(this.subjectText, this.valueText, {super.key});
  
  @override
  Widget build(BuildContext context) {

    const darkBlue = Color.fromARGB(255, 78, 128, 152);
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    
    return Container(
      height: heightOfScreen * 0.3 / 6,
      width: widthOfScreen * 0.62,
      decoration: BoxDecoration(
        color: darkBlue,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            textDirection: TextDirection.rtl,
            children: [
              SizedBox(width: 0.04 * widthOfScreen),
              Text(': $subjectText', style: const TextStyle(fontFamily: 'iransans', fontSize: 13),),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 0.04 * widthOfScreen),
              Text(valueText ,style: const TextStyle(fontFamily: 'iransans', fontSize: 13)),
            ],
          ),
        ],
      )
    );
  }

}

class BirthDateWidget extends StatefulWidget {

  DateTime? _birthDate;
  BirthDateWidget(this._birthDate, {super.key});

  @override
  _BirthDateWidgetState createState() => _BirthDateWidgetState();
}
class _BirthDateWidgetState extends State<BirthDateWidget> {

  @override
  Widget build(BuildContext context) {

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    const darkBlue = Color.fromARGB(255, 78, 128, 152);

    return Container(
      padding: EdgeInsets.only(left: 10, right: 20),
        height: heightOfScreen * 0.3 / 6,
        width: widthOfScreen * 0.62,
        decoration: BoxDecoration(
            color: darkBlue,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Flex(
          direction: Axis.horizontal,
          textDirection: TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
                child: Text(': تاریخ تولد', style: const TextStyle(fontFamily: 'iransans', fontSize: 13)),
              flex: 1,
            ),
            Flexible(
              flex: 1,
              child: Text((widget._birthDate != null) ? _formatDate(widget._birthDate!) : '--'
                ,style: const TextStyle(
                    fontFamily: 'iransans'
                    , fontSize: 13
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: 80,
                height: 30,
                child: ElevatedButton(
                  child: Text('تغییر'),
                  onPressed: () async {
                    final DateTime? pickedDate = await _showDatePicker(context);
                    if (pickedDate!= null) {
                      setState(() {
                        widget._birthDate = pickedDate;
                      });
                    }
                  },
                ),
              ),
            ),
          ],
        )
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  Future<DateTime?> _showDatePicker(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: widget._birthDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
  }
}