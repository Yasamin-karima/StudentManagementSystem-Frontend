
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_front_end/classes/models.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../SocketMethods.dart';

class AssignPage extends StatefulWidget{
  String sortFormat;
  AssignPage(this.sortFormat, {super.key});

  @override
  State<AssignPage> createState() => _AssignPageState();
}
class _AssignPageState extends State<AssignPage> {

  List<Assignment> doneAssigns = [];
  List<Assignment> passedUndoneAssigns = [];
  List<Assignment> undoneAssigns = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      List<Assignment> done = [];
      List<Assignment> undone = [];
      if (widget.sortFormat == 'SJF') {
        done = await SocketMethods.getDoneAssigns('SJF');
        undone = await SocketMethods.getUndoneAssigns('SJF');
      } else if (widget.sortFormat == 'FIFO') {
        done = await SocketMethods.getDoneAssigns('FIFO');
        undone = await SocketMethods.getUndoneAssigns('FIFO');
      }

      setState(() {
        doneAssigns = done;
        for (Assignment ass in undone){
          if (getDistanceBetween(ass) >= 0) {
            undoneAssigns.add(ass);
          } else {
            passedUndoneAssigns.add(ass);
          }
        }
      });
    } catch (e, s) {
      print('Error fetching assigns: $e');
      print(s);
    }
  }


  @override
  Widget build(BuildContext context) {
    double widthOfScreen = MediaQuery
        .of(context)
        .size
        .width;
    double heightOfScreen = MediaQuery
        .of(context)
        .size
        .height;

    const anotherBlue = Color.fromARGB(255, 34, 86, 111);

    return Scaffold(
        body: Container(
          width: widthOfScreen,
          height: heightOfScreen,
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
          ),
          child: Stack(
            children: [
              Positioned(
                top: heightOfScreen * 0.05,
                right: (widthOfScreen - 300) / 2,
                width: widthOfScreen,
                child: const Text(
                    'تمرینای شما اینجاست:',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        fontFamily: 'iransans',
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: anotherBlue
                    )
                ),
              ), //تمرینا اینجاست
              Positioned(
                  top: 0.12 * heightOfScreen,
                  right: 0.1 * widthOfScreen,
                  child: Container(
                    decoration: const BoxDecoration(
                        border: Border(bottom: BorderSide())
                    ),
                    width: 0.8 * widthOfScreen,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: (widget.sortFormat == 'SJF')
                                  ? Border.all(color: Colors.black)
                                  : null
                          ),
                          child: InkWell(
                            child: Text('مرتب شده طبق مهلت', style: _textStyle(12, FontWeight.w100),),
                            onTap: () {
                              widget.sortFormat = 'SJF';
                              fetchData();
                            },
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: (widget.sortFormat == 'FIFO')
                                ? Border.all(color: Colors.black)
                                : null
                          ),
                          child: InkWell(
                            child: Text('مرتب شده طبق زمان تعریف', style: _textStyle(12, FontWeight.w100),),
                            onTap: () {
                              widget.sortFormat = 'FIFO';
                              fetchData();
                            },
                          ),
                        ),

                      ],
                    ),
                  )
              ), //sort options
              Positioned(
                  top: 0.16 * heightOfScreen,
                  child: SizedBox(
                    width: widthOfScreen, height: 0.76 * heightOfScreen,
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                            '   انجام نشده:',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'iransans',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )
                        ),
                        Flexible(
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: undoneAssigns.length,
                            reverse: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                            itemBuilder: (context, index) {
                              return AssignCard(undoneAssigns[index]);
                            },
                          ),
                        ),
                        const Text(
                            '   ارسال شده:',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'iransans',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )
                        ),
                        Flexible(
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: doneAssigns.length,
                            reverse: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                            itemBuilder: (context, index) {
                              return AssignCard(doneAssigns[index]);
                            },
                          ),
                        ),
                        const Text(
                            '   ددلاین گذشته:',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(
                              fontFamily: 'iransans',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            )
                        ),
                        Flexible(
                          child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: passedUndoneAssigns.length,
                            reverse: true,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                            itemBuilder: (context, index) {
                              return AssignCard(passedUndoneAssigns[index]);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
              ) //grids
            ],
          ),
        )
    );
  }
}



class AssignCard extends StatefulWidget {
  final Assignment assignment;
  const AssignCard(this.assignment, {super.key});

  @override
  State<AssignCard> createState() => _AssignCardState();
}
class _AssignCardState extends State<AssignCard> {
  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        _showModalBottomSheet(context, widget.assignment);
      },
      hoverColor: Colors.black,
      child: Card(
        margin: const EdgeInsets.all(10),
        borderOnForeground: true,
        color: (getDistanceBetween(widget.assignment) > 0) ?  const Color.fromARGB(180, 78, 128, 152) :  const Color.fromARGB(230, 230, 110, 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              textDirection: TextDirection.rtl,
              children: [
                const SizedBox(width: 10),
                Text(
                  widget.assignment.course!.name,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontFamily: 'iransans',
                    fontSize: 22,
                    color: Color.fromARGB(255, 12 , 48, 66),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                const SizedBox(width: 10),
                Text(
                  widget.assignment.title,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontFamily: 'iransans',
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              textDirection: TextDirection.rtl,
              children: [
                const SizedBox(width: 10),
                Text(getDistanceBetween(widget.assignment) > 0
                    ?'‏${getDistanceBetween(widget.assignment)} روز مانده'
                    :'‏${-getDistanceBetween(widget.assignment)} روز گذشته',
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontFamily: 'iransans',
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: Color.fromARGB(255, 12 , 48, 66)
                  ),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


void _showModalBottomSheet(BuildContext context, Assignment ass){
  showModalBottomSheet(
      backgroundColor: const Color.fromARGB(230, 195, 144, 108),
      useSafeArea: false,
      context: context,
      builder: (context) {
        return Flex(
          direction: Axis.vertical,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
                flex: 6,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  textDirection: TextDirection.rtl,
                  children: [
                    Flexible(
                        flex: 6,
                        child: Flex(
                          textDirection: TextDirection.rtl,
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                                flex: 4,
                                child: Text(
                                  style: _textStyle(20, FontWeight.w700),
                                  ass.title,
                                )
                            ),//ass_title
                            Flexible(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'توضیحات استاد',
                                      style: _textStyle(15, FontWeight.w400),
                                      textAlign: TextAlign.right,
                                    ),
                                    Text(
                                        ass.teacherDescription,
                                      style: _textStyle(14, FontWeight.w200),
                                      textDirection: TextDirection.rtl,
                                    )
                                  ],
                                )
                            ),//description
                          ],
                        ),
                    ),//right part
                    Flexible(
                        flex: 5,
                        child: Flex(
                          // textDirection: TextDirection.ltr,
                          direction: Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 170,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 2, color: Colors.black),
                                    borderRadius: BorderRadius.all(Radius.circular(14))
                                  ),
                                  child: Row(
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(':نمره', style: _textStyle(16, FontWeight.w500)),
                                      Text(ass.score.toString(), style: _textStyle(18, FontWeight.w500))
                                    ],
                                  ),
                                )
                            ),//score
                            Flexible(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 170,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.5, color: Colors.black),
                                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                                    color: Colors.blueGrey.shade300
                                  ),
                                  child: Column(
                                    children: [
                                      Text(format1(ass.getJalaliDeadline()), style: _textStyle(16, FontWeight.w500)),
                                      Text(getDistanceBetween(ass) > 0
                                          ?'‏${getDistanceBetween(ass)} روز مانده'
                                          :'‏${(-getDistanceBetween(ass))} روز گذشته',
                                          style: _textStyle(16, FontWeight.w500)),
                                    ],
                                  ),
                                )
                            ),//deadline
                            Flexible(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  width: 170,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 0.5, color: Colors.black),
                                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                                      color: Colors.blueGrey.shade300
                                  ),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      elevation: WidgetStateProperty.all(0),
                                      backgroundColor: WidgetStateColor.transparent
                                    ),
                                    child: Text('ارسال فایل', style: _textStyle(16, FontWeight.w500), textAlign: TextAlign.center,),
                                    onPressed: () async {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                                      if (result == null) return;
                                      PlatformFile file = result.files.first;
                                    },
                                  ),
                                )
                            ),//send button
                          ],
                        ),
                    ),//left part
                  ],
                )
            ),
            Flexible(
                  flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      textDirection: TextDirection.rtl,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('تایید', style: _textStyle(16, FontWeight.w500))
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('خروج', style: _textStyle(16, FontWeight.w500))
                        )
                      ],
                    )
                ),//buttons part
          ],
        );
      }
  );
}

int getDistanceBetween(Assignment ass) {
  return ass.getJalaliDeadline() ^ Jalali.now();
}

TextStyle _textStyle(double size, FontWeight w){
  return TextStyle(
    fontFamily: 'iransans',
    fontSize: size,
    fontWeight: w,
    color: Colors.black
  );
}

String format1(Date d) {
  final f = d.formatter;

  return '${f.wN} ${f.d} ${f.mN}';
}

