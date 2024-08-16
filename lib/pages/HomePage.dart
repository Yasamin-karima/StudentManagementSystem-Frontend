
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  // Student student;
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    const orangeBack = Color.fromARGB(255, 195, 144, 108);

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    final Shader linearGradient = const LinearGradient(
      colors: <Color>[
        Color.fromARGB(255, 39, 64, 76),
        Color.fromARGB(255, 70, 115, 136),
        Color.fromARGB(255, 78, 128, 152)],
    ).createShader(Rect.fromLTWH(
        widthOfScreen*0.5,
        widthOfScreen*0.75 ,
        widthOfScreen*0.85,
        widthOfScreen*0.95));


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
              top: heightOfScreen * 0.08,
              right: widthOfScreen * 0.1,
              width: widthOfScreen,
                child: Text(
                  'سلام، کاربر عزیز !',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient),
                  ),
                ), // text"hello"
            Positioned(
              top: heightOfScreen * 0.125,
              left: widthOfScreen * 0.005,
                child: OtherButtons('تمرینا')
            ),// text"other assigns"
            Positioned(
              top: 0.125 * heightOfScreen + 44,
                left: 0.02 * widthOfScreen,
                child: Container(
                  width: 0.96 * widthOfScreen,
                  height: 0.21 * heightOfScreen,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: orangeBack,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AssignCard(),
                      AssignCard(),
                      AssignCard(),
                    ],
                  ),
                )
            ),//assign cards
            Positioned(
              top: heightOfScreen * 0.335 + 44,
              left: widthOfScreen * 0.005,
              child: OtherButtons('کارا')
            ),//text"other TODOs"
            Positioned(
              top: heightOfScreen * 0.335 + 90,
                left: 0,
                child: SizedBox(
                  height: 0.23 * heightOfScreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TodoParts('انجام پروژه'),
                      TodoParts('ورزش'),
                      TodoParts('تمرین پایتون'),
                      TodoParts('تمرین مدار'),
                    ],
                  ),
                )
            ),
            Positioned(
                top: heightOfScreen * 0.565 + 90,
                left: 0,
                child: OtherButtons('درسا')
            ),// text"other courses"
            Positioned(
              top: 0.565 * heightOfScreen + 138,
                child: Container(
                  width: 0.98 * widthOfScreen,
                  height: 0.19 * heightOfScreen,
                  decoration: const BoxDecoration(
                    color: orangeBack,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(18), bottomRight: Radius.circular(18))
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ScoreCard('معادلات دیفرانسیل', '۱۳.۲'),
                          ScoreCard('برنامه نویسی پیشرفته', '۱۹.۷۵'),
                        ],
                      ),
                      Container(
                        // width: 0.98 * widthOfScreen,
                        height: 0.12 * heightOfScreen,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          children: [
                            ExamCard('مدار الکتریکی', '۲۳ خرداد', '۵'),
                            ExamCard('برنامه نویسی پیشرفته', '۱۱ تیر', '۱۳'),
                            ExamCard('ریاضی ۲', '۲۵ خرداد', '۷'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
            ),
            /*const Positioned (
              bottom: 0,
                left: 0,
                right: 0,
                child: BottomBar()*/
            // ),
          ],
        ),
      ),
    );
  }
}

class AssignCard extends StatelessWidget {
  const AssignCard({super.key});

  @override
  Widget build(BuildContext context) {

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return InkWell(
      // onTap: ,
      child: Card(
        child: Container(
          width: 0.277 * widthOfScreen,
          height: 0.195 * heightOfScreen,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13)
          ),
          child: Card(
            borderOnForeground: true,
            margin: EdgeInsets.all(0),
            color: const Color.fromARGB(200, 78, 128, 152),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'تمرین مدار الکتریکی',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'iransans',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Column(
                  children: [
                    Text(
                      'مهلت:'
                      ,textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'iransans',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),),
                    Text('شنبه'
                      ,textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'iransans',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),),
                    Text('۲۳ خرداد',
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'iransans',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),),
                  ],
                ),
                Text('‏۴ روز مانده',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'iransans',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange.shade900
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class OtherButtons extends StatelessWidget {
  String other = '';
  OtherButtons(this.other, {super.key});


  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {null;  },
      child: Row(
        children :[
          const Icon(Icons.chevron_left, size: 35, color: Colors.black,),
          Text(
            'بقیه $other',
            style: const TextStyle(
              fontFamily: 'iransans',
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black
            ),
          )
      ]),
    );
  }

}

class TodoParts extends StatelessWidget {
  String todoStatement;

  TodoParts(this.todoStatement, {super.key});

  @override
  Widget build(BuildContext context) {

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    bool s =false;

    return Container(
      width: 0.98 * widthOfScreen,
      height: 0.05 * heightOfScreen,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
        color: Color.fromARGB(102, 82, 131, 170),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(width: 0.015 * widthOfScreen),
          Checkbox(
              value: s,
              onChanged: (value) {
                s = true;
              },
          ),
          Text(
              todoStatement,
            style: const TextStyle(fontFamily: 'iransans')
            )
        ],
      ),
    );
  }

}

class ExamCard extends StatelessWidget {
  String course, examDate, remaining;
  ExamCard(this.course, this.examDate, this.remaining, {super.key});

  @override
  Widget build(BuildContext context) {

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return Card(
      child: Container(
        width: 0.38 * widthOfScreen,
        height: 0.12 * heightOfScreen,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13)
        ),
        child: Card(
          borderOnForeground: true,
          margin: EdgeInsets.all(0),
          color: const Color.fromARGB(220, 78, 128, 152),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'امتحان $course',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'iransans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                examDate,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'iransans',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),),
              Text( '$remaining روز مانده',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'iransans',
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange.shade900
                ),),
            ],
          ),
        ),
      ),
    );
  }

}

class ScoreCard extends StatelessWidget {
  String course, score;
  ScoreCard(this.course, this.score ,{super.key});

  @override
  Widget build(BuildContext context) {

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return Card(
      child: Container(
        width: 0.38 * widthOfScreen,
        height: 0.05 * heightOfScreen,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
        ),
        child: Card(
          borderOnForeground: true,
          margin: const EdgeInsets.all(0),
          color: const Color.fromARGB(200, 78, 128, 152),
          child: Row(
            textDirection: TextDirection.rtl,
            children: [
              SizedBox(width: 0.013 * widthOfScreen),
              Text(
                score,
                textWidthBasis: TextWidthBasis.parent,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'iransans',
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Expanded(
                child: Text(
                  course,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'iransans',
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
      ),
    ),
    );
  }

}
