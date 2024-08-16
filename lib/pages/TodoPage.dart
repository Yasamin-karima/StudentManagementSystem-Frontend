import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_front_end/NavigationBar.dart';
import 'package:project_front_end/SocketMethods.dart';
import 'package:project_front_end/classes/models.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'HomePage.dart';

class TodoPage extends StatefulWidget {
  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  List<Todo>? _todosList;
  List<Todo>? doneData = [];
  List<Todo>? undoneData = [];

  @override
  void initState() {
    super.initState();
    fetchData(); // Call your method here
  }

  Future<void> fetchData() async {
    try {
      List<Todo> data = await SocketMethods.getTodo();

      setState(() {
        _todosList = data;
        _todosList?.forEach( (e) {
          if(e.isDone) doneData?.add(e);
        });
        _todosList?.forEach( (e) {
          if(!e.isDone) undoneData?.add(e);
        });
      });
    } catch (e) {
      print('Error fetching todos: $e');
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
                  'کارای شما اینجاست:',
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
              bottom: 80,
              child: SizedBox(
                height: 0.3 * heightOfScreen,
                width: widthOfScreen,
                child: ListView.builder(

                  itemCount: undoneData?.length,
                  itemBuilder: (context, index) {
                    return TodoParts(undoneData![index].title, undoneData![index].isDone, onChanged: (bool newValue) {
                      setState(() {
                        undoneData![index].isDone = newValue;
                        doneData?.add(Todo(undoneData![index].title, undoneData![index].isDone));
                        undoneData!.remove(Todo(undoneData![index].title, undoneData![index].isDone));
                      });
                      SocketMethods.setTodoState(undoneData![index].title, newValue);});
                      },
                ),
              ),
            ),
            Positioned(
              top: 0.56 * heightOfScreen,
              child: SizedBox(
                height: 0.3 * heightOfScreen,
                width: widthOfScreen,
                child: ListView.builder(
                  itemCount: doneData?.length,
                  itemBuilder: (context, index) {
                    return TodoParts(doneData![index].title, doneData![index].isDone, onChanged: (bool newValue) {
                      setState(() {
                        doneData![index].isDone = newValue;
                        undoneData?.add(Todo(doneData![index].title, doneData![index].isDone));
                        doneData!.remove(Todo(doneData![index].title, doneData![index].isDone));
                      });
                      SocketMethods.setTodoState(doneData![index].title, newValue);});
                      },
                ),
              ),
            ),
            Positioned(
              bottom: 50,right: 50,
              child: TodoAdder(),
            )
          ],
        ),
      ),
    );
  }
}


class TodoParts extends StatefulWidget {
  String title;
  bool checked;
  final Function(bool) onChanged;

  TodoParts(this.title, this.checked, { required this.onChanged, super.key});

  @override
  State<TodoParts> createState() => _TodoPartsState();
}
class _TodoPartsState extends State<TodoParts> {
  bool? _value;
  @override
  Widget build(BuildContext context) {

    _value = widget.checked;
    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;



    return Container(

      decoration: BoxDecoration(
        color: Color.fromARGB(102, 82, 131, 170),
        borderRadius: BorderRadius.all(Radius.circular(22))

      ),
      margin: EdgeInsets.all(4),
      child: CheckboxListTile(
        title: Text(
            widget.title,
          textAlign: TextAlign.right,
        ),
        secondary: InkWell(
            child: Icon(Icons.delete_outline_outlined),
                onDoubleTap: () {
                  SocketMethods.removeTodo(widget.title);
                },
        ),
        activeColor: const Color.fromARGB(255, 34, 86, 111),
        checkColor: Colors.white,
        // selected: _value,
        value: _value,
        onChanged: (bool? value) {
          setState(() {
            widget.onChanged(value!);
          });
        },
      ),
    );

    /*return Container(
      height: 0.065 * heightOfScreen,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Color.fromARGB(102, 82, 131, 170),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          SizedBox(width: 0.015 * widthOfScreen),
          Checkbox(
            value: s,
            onChanged: (value) {
              // SocketMethods.
            },
          ),
          Text(
              todoStatement!,
              style: const TextStyle(fontFamily: 'iransans')
          )
        ],
      ),
    );*/
  }
}


class TodoAdder extends StatefulWidget {
  @override
  _TodoAdderState createState() => _TodoAdderState();
}
class _TodoAdderState extends State<TodoAdder> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  bool _isOpen = false;


  @override
  Widget build(BuildContext context) {

    double widthOfScreen = MediaQuery.of(context).size.width;
    double heightOfScreen = MediaQuery.of(context).size.height;
    const lightBlueBackground = Color.fromARGB(255, 206, 211, 220);

    return Container(
      width: 60, height: 120,
      decoration: BoxDecoration(
      ),
      child: SpeedDial(
        icon: Icons.add,
        renderOverlay: false,
        backgroundColor: Color.fromARGB(150, 34, 86, 111),
        // isOpen: _isOpen,
        onOpen: () => setState(() => _isOpen = true),
        onClose: () => setState(() => _isOpen = false),
        children: [
          SpeedDialChild(
            child: Icon(Icons.edit),
            label: 'Add Todo',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Add Todo'),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Todo title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                  ),
                  actions: [
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          SocketMethods.addTodo(_titleController.text);
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