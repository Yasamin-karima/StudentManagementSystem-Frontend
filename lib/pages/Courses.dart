import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:project_front_end/NavigationBar.dart';
import 'package:project_front_end/SocketMethods.dart';
import 'package:project_front_end/classes/models.dart';
import 'package:shamsi_date/shamsi_date.dart';

import 'HomePage.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  List<Course> _coursesList = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Call your method here
  }

  Future<void> fetchData() async {
    try {
      var data = await SocketMethods.getCourses();
      setState(() {
        _coursesList = data;
      });
    } catch (e) {
      print('Error fetching student: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    const darkBlue = Color.fromARGB(255, 78, 128, 152);
    const lightBlueBackground = Color.fromARGB(255, 206, 211, 220);
    const anotherBlue = Color.fromARGB(255, 34, 86, 111);
    const orangeBack = Color.fromARGB(255, 195, 144, 108);

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
              stops: const [0.27, 0.5, 0.75, 0.97]),
          // color: lightBlueBackground,
        ),
        child: Stack(
          children: [
            Positioned(
              top: heightOfScreen * 0.08,
              right: (widthOfScreen - 285) / 2,
              width: widthOfScreen,
              child: const Text(
                'درسای شما اینجاست:',
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontFamily: 'iransans',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: anotherBlue
                )
              ),
            ),
            Positioned(
              top: 0.13 * heightOfScreen,
              child: SizedBox(
                height: 0.78 * heightOfScreen,
                width: widthOfScreen,
                child: ListView.builder(
                  itemCount: _coursesList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: CourseCards(_coursesList[index])
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 50,
                right: 50,
                child: CourseAdder()
            )
          ],
        ),
      ),
    );
  }
}

class CourseCards extends StatelessWidget {
  final Course course;

  const CourseCards(this.course, {super.key});

  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    bool s = false;

    return Container(
      width: widthOfScreen,
      height: 0.2 * heightOfScreen,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromARGB(102, 82, 131, 170),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        // mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            child: Container(
              width: 0.5 * widthOfScreen,
              height: 0.2 * heightOfScreen,
              // decoration: BoxDecoration(color: Colors.lightBlue.shade100),
              child: Column(
                textDirection: TextDirection.rtl,
                children: [
                  Flexible(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(top: 5, bottom: 2, right: 8),
                        alignment: Alignment.centerRight,
                        child: Text(
                          style: const TextStyle(
                            fontFamily: 'iransans',
                            fontSize: 24,
                            color: Color.fromARGB(255, 27, 68, 88),
                            fontWeight: FontWeight.w700,
                          ),
                          textDirection: TextDirection.rtl,
                          course.name,
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                        margin: const EdgeInsets.only(top: 2, bottom: 2, right: 8),
                        alignment: Alignment.centerRight,
                        child: Text(
                          style: const TextStyle(
                            fontFamily: 'iransans',
                            fontSize: 20,
                            color: Color.fromARGB(255, 27, 68, 88),
                            fontWeight: FontWeight.w200,
                          ),
                          textDirection: TextDirection.ltr,
                          course.id,
                        ),
                      )),
                  Flexible(flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(top: 2, bottom: 2, right: 8),
                        alignment: Alignment.topRight,
                        child: Text(
                          style: const TextStyle(
                            fontFamily: 'iransans',
                            fontSize:  18,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                          ),
                          textDirection: TextDirection.rtl,
                          '${course.unit} واحد',
                        ),
                      )
                  ),
                  Flexible(flex: 1, child: Container(
                    margin: const EdgeInsets.only(top: 2, right: 8, bottom: 5),
                    alignment: Alignment.topRight,
                    child: Text(
                      style: const TextStyle(
                        fontFamily: 'iransans',
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                      ),
                      textDirection: TextDirection.rtl,
                      '‏امتحان: ${format1(course.getJalaliDate())}',
                    ),
                  )),
                ],
              ),
            ),
          ),
          Flexible(
            child: Container(
              width: 0.5 * widthOfScreen,
              height: 0.2 * heightOfScreen,
              // decoration: BoxDecoration(color: Colors.lightBlue.shade100),
              child: Flex(
                direction: Axis.vertical,
                textDirection: TextDirection.rtl,
                children: [
                  Flexible(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.all(3),
                        alignment: Alignment.topCenter,
                        child: Text(
                          style: const TextStyle(
                            fontFamily: 'iransans',
                            fontSize: 22,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                          textDirection: TextDirection.ltr,
                          course.teacher.name,
                        ),
                      )),
                  Flexible(
                    flex: 5,
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: const Text(
                      style: TextStyle(
                        fontFamily: 'iransans',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w200,
                      ),
                      textDirection: TextDirection.rtl,
                      '‏ساعت کلاس:',
                                        ),
                    ),),
                  Flexible(
                    flex: 12,
                      child: Container(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: course.times.map((text) => Text(text, style: const TextStyle(fontFamily: 'iransans',fontSize: 14),)).toList()
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
          /* Text(
              todoStatement,
              style: const TextStyle(fontFamily: 'iransans')
          )*/
        ],
      ),
    );
  }
}

class CourseAdder extends StatefulWidget {
  const CourseAdder({super.key});

  @override
  _CourseAdderState createState() => _CourseAdderState();
}
class _CourseAdderState extends State<CourseAdder> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  bool _isOpen = false;


  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 60, height: 120,
      child: SpeedDial(
        renderOverlay: false,
        icon: Icons.add,
        backgroundColor: const Color.fromARGB(255, 34, 100, 111),
        onOpen: () => setState(() => _isOpen = true),
        onClose: () => setState(() => _isOpen = false),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.edit),
            label: 'افزودن درس',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('افزودن درس', textAlign: TextAlign.right,),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        labelText: 'کد درس',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'کد درس را وارد کنید';
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
                          SocketMethods.addCourse(_titleController.text);
                          _titleController.clear();
                          // Update the UI
                          setState(() {});
                          // Close the dialog
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

String format1(Date d) {
  final f = d.formatter;

  return '${f.wN} ${f.d} ${f.mN}';
}