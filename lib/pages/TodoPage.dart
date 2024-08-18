
import 'package:flutter/material.dart';
import 'package:project_front_end/SocketMethods.dart';
import 'package:project_front_end/classes/models.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';


class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage>    {
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
    const blue = Color.fromARGB(255, 34, 86, 111);

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
                      color: blue
                  )
              ),
            ),//above text
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
            ),//undone todos
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
                      SocketMethods.setTodoState(doneData![index].title, newValue);
                    });
                  },
                ),
              ),
            ),//done todos
            const Positioned(
              bottom: 50,right: 50,
              child: TodoAdder(),
            )//adder
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
  @override
  Widget build(BuildContext context) {

    return Container(

      decoration: const BoxDecoration(
        color: Color.fromARGB(102, 82, 131, 170),
        borderRadius: BorderRadius.all(Radius.circular(22))

      ),
      margin: const EdgeInsets.all(4),
      child: CheckboxListTile(
        title: Text(
            widget.title,
          textAlign: TextAlign.right,
        ),
        secondary: InkWell(
            child: const Icon(Icons.delete_outline_outlined),
                onDoubleTap: () {
                  SocketMethods.removeTodo(widget.title);
                },
        ),
        activeColor: const Color.fromARGB(255, 34, 86, 111),
        checkColor: Colors.white,
        value: widget.checked,
        onChanged: (bool? value) {
          setState(() {
            widget.onChanged(value!);
          });
        },
      ),
    );
  }
}


class TodoAdder extends StatefulWidget {
  const TodoAdder({super.key});

  @override
  _TodoAdderState createState() => _TodoAdderState();
}
class _TodoAdderState extends State<TodoAdder> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  bool _isOpen = false;


  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 60, height: 120,
      child: SpeedDial(
        icon: Icons.add,
        renderOverlay: false,
        backgroundColor: const Color.fromARGB(150, 34, 86, 111),
        // isOpen: _isOpen,
        onOpen: () => setState(() => _isOpen = true),
        onClose: () => setState(() => _isOpen = false),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.edit),
            label: 'Add Todo',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Add Todo'),
                  content: Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
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
                      child: const Text('OK'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          SocketMethods.addTodo(_titleController.text);
                          _titleController.clear();
                          setState(() {});
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
