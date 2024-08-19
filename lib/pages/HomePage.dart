
import 'package:flutter/material.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../NavigationBar.dart';
import '../SocketMethods.dart';
import '../classes/models.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  List<Assignment> assignments = [];
  List<Todo> todos = [];
  List<Course> coursesForExams = [];
  Assignment? bestAssign, worstAssign;
  String studentName = '';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Assignment> fetchedAssigns = await SocketMethods.getUndoneAssigns('SJF');
      List<Todo> fetchedTodo = await SocketMethods.getTodo();
      bestAssign = await SocketMethods.studentBestAssignment();
      worstAssign = await SocketMethods.studentWorstAssignment();
      studentName = (await SocketMethods.getStudent()).name.split(" ")[0];
      var tempExams = await SocketMethods.getCourses();

      setState(() {
        /**
         * removing passed deadline assignments
         * and getting the first 3
         */
        List<Assignment> tempAssign = [];
        for (Assignment ass in fetchedAssigns) {
          if (int.parse((ass.getJalaliDeadline() ^ Jalali.now()).toString()) >= 0){
            tempAssign.add(ass);
          }
        }
        if (tempAssign.length < 3) {
          assignments.addAll(tempAssign);
        } else {
          assignments.addAll(tempAssign.getRange(0, 3));
        }
        /**
         * removing done todos
         * and getting the first 4
         */
        List<Todo> tempTodo = [];
        for (Todo t in fetchedTodo) {
          if (!t.isDone){
            tempTodo.add(t);
          }
        }
        if (tempTodo.length < 4) {
          todos.addAll(tempTodo);
        } else {
          todos.addAll(tempTodo.getRange(0, 4));
        }
        /**
         * delete courses which exams are passed
         */
        for (Course c in tempExams){
          if (int.parse((c.getJalaliDate() ^ Jalali.now()).toString()) >= 0){
            coursesForExams.add(c);
          }
        }
      });
    } catch (e,s) {
      print('Error fetching assigns: $e');
      print(s);
    }
  }



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
                  'سلام ${studentName} !',
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
                  child: ListView.builder(
                    reverse: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: assignments.length,
                    itemBuilder: (context, index) {
                      return AssignCard(assignments[index]);
                    },
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
                  width: 0.98 * widthOfScreen,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0),
                    scrollDirection: Axis.vertical,
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      return TodoParts(todos[index]);
                    },
                  )
                )
            ),//todos
            Positioned(
                top: heightOfScreen * 0.565 + 90,
                left: 0,
                child: OtherButtons('درسا')
            ),// text"other courses"
            Positioned(
              top: 0.565 * heightOfScreen + 138,
                child: Container(
                  width: 0.98 * widthOfScreen,
                  height: 0.185 * heightOfScreen,
                  decoration: const BoxDecoration(
                    color: orangeBack,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(18), bottomRight: Radius.circular(18))
                  ),

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ScoreCard(bestAssign?.course!.name ?? "بهترین درس", bestAssign?.score.toString() ?? "0.0"),
                          ScoreCard(worstAssign?.course!.name ?? "بدترین درس", worstAssign?.score.toString() ?? "0.0"),
                        ],
                      ),//scores
                      SizedBox(
                        // width: 0.98 * widthOfScreen,
                        height: 0.12 * heightOfScreen,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          reverse: true,
                          itemCount: coursesForExams.length,
                          itemBuilder: (context, index) {
                            return ExamCard(coursesForExams[index]);
                          },
                          /*children: [
                            ExamCard('مدار الکتریکی', '۲۳ خرداد', '۵'),
                            ExamCard('برنامه نویسی پیشرفته', '۱۱ تیر', '۱۳'),
                            ExamCard('ریاضی ۲', '۲۵ خرداد', '۷'),
                          ],*/
                        ),
                      )//exams
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}

class AssignCard extends StatelessWidget {
  Assignment assignment;
  AssignCard(this.assignment, {super.key});

  @override
  Widget build(BuildContext context) {

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;

    return Card(
      child: Container(
        width: 0.3 * widthOfScreen,
        height: 0.195 * heightOfScreen,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13)
        ),
        child: Card(
          borderOnForeground: true,
          margin: const EdgeInsets.all(0),
          color: const Color.fromARGB(200, 78, 128, 152),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                assignment.title,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'iransans',
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  const Text(
                    'مهلت:'
                    ,textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'iransans',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    assignment.getJalaliDeadline().formatter.wN,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'iransans',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),),
                  Text(
                    '${assignment.getJalaliDeadline().formatter.d} ${assignment.getJalaliDeadline().formatter.mN}',
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontFamily: 'iransans',
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),),
                ],
              ),
              Text (
                '‏${(Jalali.now() ^ assignment.getJalaliDeadline()).abs()} روز مانده',
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
    );
  }

}

class OtherButtons extends StatefulWidget {
  String other = '';
  OtherButtons(this.other, {super.key});

  @override
  State<OtherButtons> createState() => _OtherButtonsState();
}

class _OtherButtonsState extends State<OtherButtons> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        int index = 0;
        switch (widget.other) {
          case "تمرینا" :
            index = 3;
            break;
          case "کارا" :
            index = 1;
            break;
          case "درسا" :
            index = 4;
            break;
        }
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(index)));
      },
      child: Row(
        children :[
          const Icon(Icons.chevron_left, size: 35, color: Colors.black,),
          Text(
            'بقیه ${widget.other}',
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

class TodoParts extends StatefulWidget {
  Todo todo;

  TodoParts(this.todo, {super.key});

  @override
  State<TodoParts> createState() => _TodoPartsState();
}
class _TodoPartsState extends State<TodoParts> {
  @override
  Widget build(BuildContext context) {

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    bool s = false;

    return Container(
      width: 0.98 * widthOfScreen,
      height: 0.05 * heightOfScreen,
      margin: const EdgeInsets.only(top: 3, bottom: 3),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(15), bottomRight: Radius.circular(15)),
        color: Color.fromARGB(102, 82, 131, 170),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          Checkbox(
            activeColor: const Color.fromARGB(255, 34, 86, 111),
            checkColor: Colors.white,
            value: widget.todo.isDone,
            onChanged: (bool? value) {
              setState(() {
                widget.todo.isDone = value!;
                SocketMethods.setTodoState(widget.todo.title, value);
              });
            },
          ),
          Text(
              widget.todo.title,
            style: const TextStyle(fontFamily: 'iransans')
            )
        ],
      ),
    );
  }
}

class ExamCard extends StatelessWidget {
  Course course;
  ExamCard(this.course, {super.key});

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
          margin: const EdgeInsets.all(0),
          color: const Color.fromARGB(220, 78, 128, 152),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'امتحان ${course.name}',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'iransans',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${course.getJalaliDate().formatter.d} ${course.getJalaliDate().formatter.mN}',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'iransans',
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),),
              Text(
                '‏${(Jalali.now() ^ course.getJalaliDate()).abs()} روز مانده',
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
              SizedBox(width: 0.02 * widthOfScreen),
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
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
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
